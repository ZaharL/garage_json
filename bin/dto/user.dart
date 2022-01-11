class User {
  late String companyID;
  late String adminOfCompanyId;
  late String adminOfCompanyName;
  late String email;
  late String id;
  late bool isBlocked;
  late String role;

  User(
      {required this.companyID,
      required this.email,
      required this.adminOfCompanyId,
      required this.adminOfCompanyName,
      required this.id,
      required this.isBlocked,
      required this.role});

  User.fromJson(Map<String, dynamic> json) {
    companyID = json['companyID'] ?? '';
    adminOfCompanyId = json['adminOfCompanyId'] ?? '';
    adminOfCompanyName = json['adminOfCompanyName'] ?? '';
    email = json['email'];
    id = '${json['id']}';
    isBlocked = json['isBlocked'] ?? false;
    role = json['role'] ?? 'user';
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['companyID'] = companyID;
    data['adminOfCompanyId'] = adminOfCompanyId;
    data['adminOfCompanyName'] = adminOfCompanyName;
    data['email'] = email;
    data['id'] = id;
    data['isBlocked'] = isBlocked;
    data['role'] = role;
    return data;
  }
}
