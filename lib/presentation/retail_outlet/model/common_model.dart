class CustomerTypeModel {
  int? siteTypeId;
  String? siteTypeValue;

  CustomerTypeModel({
    this.siteTypeId,
    this.siteTypeValue,
  });

  factory CustomerTypeModel.fromJson(Map<String, dynamic> json) {
    int? cityId = json['common_id'];
    String? cityName = json['common_value'];

    return CustomerTypeModel(
      siteTypeId: cityId,
      siteTypeValue: cityName,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['common_id'] = siteTypeId;
    data['common_value'] = siteTypeValue;
    return data;
  }
}
