import 'dart:convert';
import 'dart:io';

import 'package:intl/intl.dart';

import 'dto/company.dart';
import 'dto/item.dart';
import 'dto/location.dart';
import 'dto/log.dart';

void main(List<String> arguments) async {
  var file = File('assets/garageman.json');
  var jsonDecodeResult = jsonDecode(await file.readAsString());
  var company = Company.fromJson(jsonDecodeResult);

  var logsList = await parseLogsToObject();
  handleLogsList(logsList, company);

  var outputFile = File('assets/garageman_output.json');
  if (!await outputFile.exists()) {
    await outputFile.create();
  }
  await outputFile.writeAsString(jsonEncode(company.toJson()));
}

void handleLogsList(List<Log> logs, Company company) {
  logs.forEach((log) {
    if (log.logEvent == LogEvent.itemRemoved) {
      company.items.removeWhere((key, value) => value.barcode == log.itemBarcode);
    } else if (log.logEvent == LogEvent.itemAdded) {
      var locationId = locationIdByBarcode(log.locationBarcode, company);
      var itemId = itemIdByBarcode(log.itemBarcode, locationId, company);
      company.items[itemId] = Item(
        barcode: log.itemBarcode,
        locationId: locationId,
      );
    } else if (log.logEvent.contains(LogEvent.itemMoved)) {
      moveItem(company, log);
    } else if (log.logEvent.contains(LogEvent.bulk)) {
      moveItem(company, log);
    }
  });
}

void moveItem(Company company, Log log) {
  var item = company.items.entries.firstWhere(
    (item) => item.value.barcode == log.itemBarcode,
    orElse: () => MapEntry(
      log.itemBarcode,
      Item(
        barcode: log.itemBarcode,
        locationId: locationIdByBarcode(log.locationBarcode, company),
      ),
    ),
  );
  item.value.locationId = locationIdByBarcode(log.locationBarcode, company);
  company.items[item.key] = item.value;
}

String locationIdByBarcode(String barcode, Company company) {
  var locationToAdd = company.locations.entries.firstWhere(
    (entry) => entry.value.barcode == barcode,
    orElse: () {
      company.locations[barcode] = Location(barcode: barcode);
      return MapEntry(barcode, Location(barcode: barcode));
    },
  );
  return locationToAdd.key;
}

String itemIdByBarcode(String barcode, String locationId, Company company) {
  return company.items.entries.firstWhere(
    (entry) => entry.value.barcode == barcode,
    orElse: () {
      company.items[barcode] = Item(barcode: barcode, locationId: locationId);
      return MapEntry(barcode, Item(barcode: barcode, locationId: locationId));
    },
  ).key;
}

Future<List<Log>> parseLogsToObject() async {
  var file = File('assets/logs.txt');
  var logsLines = await file.readAsLines();
  var logs = <Log>[];
  try {
    for (var i = 0; i < logsLines.length; i++) {
      if (logsLines[i].isEmpty) {
        logs.add(Log(
          itemBarcode: logsLines[i + 1],
          locationBarcode: logsLines[i + 2],
          date: formatDate(logsLines[i + 3], i),
          email: logsLines[i + 4],
          companyName: logsLines[i + 5],
          logEvent: logsLines[i + 6],
        ));
      }
    }
  } catch (e) {
    e.toString();
  }
  logs.sort((log1, log2) => log1.date - log2.date);
  return logs;
}

int formatDate(String date, int i) {
  var tail = date.substring(6, date.length).replaceFirst('am', 'AM').replaceFirst('pm', 'PM');
  var day = date.substring(0, 3);
  var month = date.substring(3, 6);

  var dateFormat = DateFormat('MM-dd-yyyy hh:mm a');

  try {
    return dateFormat.parse('$month$day$tail').microsecondsSinceEpoch;
  } catch (e) {
    print('problem at line: $i');
    e.toString();
    return 0;
  }
}
