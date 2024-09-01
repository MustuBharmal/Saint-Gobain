class UserModel {
  int? userId;
  String? name;
  int? companyId;
  String? baseUrl;
  String? companyName;
  String? token;

  UserModel({
    this.userId,
    this.name,
    this.companyId,
    this.baseUrl,
    this.companyName,
    this.token,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    // int? userId = json['user_id'];
    String? name = json['name'] ?? '';
    int? companyId = json['company_id'] ?? '';
    String? baseUrl = json['base_url'] ?? '';
    String? companyName = json['company_name'] ?? '';
    String? token = json['apitoken'];
    return UserModel(
      // userId: userId,
      name: name,
      companyId: companyId,
      baseUrl: baseUrl,
      companyName: companyName,
      token: token,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    // data['user_id'] = userId;
    data['name'] = name;
    data['company_id'] = companyId;
    data['base_url'] = baseUrl;
    data['company_name'] = companyName;
    data['apitoken'] = token;
    return data;
  }
}
