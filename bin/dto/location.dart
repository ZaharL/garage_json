class Location {
  late String barcode;

  Location({required this.barcode});

  Location.fromJson(Map<String, dynamic> json) {
    barcode = json['barcode'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['barcode'] = barcode;
    return data;
  }
}
