class Log {
  final String itemBarcode;
  final String locationBarcode;
  final int date;
  final String email;
  final String companyName;
  final String logEvent;

  Log({
    required this.itemBarcode,
    required this.locationBarcode,
    required this.date,
    required this.email,
    required this.companyName,
    required this.logEvent,
  });
}

class LogEvent {
  static final itemRemoved = 'Item removed from location';
  static final itemAdded = 'Item added to location';
  static final itemMoved = 'Item moved to location';
  static final bulk = 'Bulk change';
}
