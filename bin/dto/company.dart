import 'item.dart';
import 'location.dart';
import 'user.dart';

class Company {
  late String companyName;
  late String id;
  late Map<String, dynamic> itemImage;
  late Map<String, Item> items;
  late Map<String, Location> locations;
  late String userCount;
  late Map<String, User> users;

  Company(
      {required this.companyName,
      required this.id,
      required this.itemImage,
      required this.items,
      required this.locations,
      required this.userCount,
      required this.users});

  Company.fromJson(Map<String, dynamic> json) {
    companyName = json['companyName'];
    id = json['id'];
    itemImage = json['item_image'];
    items = (json['items'] as Map<String, dynamic>)
        .map((key, value) => MapEntry(key, Item.fromJson(value)));
    locations = (json['locations'] as Map<String, dynamic>)
        .map((key, value) => MapEntry(key, Location.fromJson(value)));
    userCount = json['userCount'];
    users = (json['users'] as Map<String, dynamic>)
        .map((key, value) => MapEntry(key, User.fromJson(value)));
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['companyName'] = companyName;
    data['id'] = id;
    data['item_image'] = itemImage;
    data['items'] = items.map((key, value) => MapEntry(key, value.toJson()));
    data['locations'] = locations.map((key, value) => MapEntry(key, value));
    data['userCount'] = userCount;
    data['users'] = users.map((key, value) => MapEntry(key, value.toJson()));
    return data;
  }
}
