class Item {
  late String barcode;
  String? itemImageId;
  late String locationId;
  String? timestamp;

  Item({required this.barcode, this.itemImageId, required this.locationId, this.timestamp});

  Item.fromJson(Map<String, dynamic> json) {
    barcode = json['barcode'] ?? '';
    itemImageId = json['item_image_id'] ?? '';
    locationId = json['locationId'] ?? '';
    timestamp = json['timestamp'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['barcode'] = barcode;
    data['item_image_id'] = itemImageId;
    data['locationId'] = locationId;
    data['timestamp'] = timestamp;
    return data;
  }
}
