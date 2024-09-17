
class CommonTypeModel {
  int? commonTypeId;
  String? commonTypeValue;

  CommonTypeModel({
    this.commonTypeId,
    this.commonTypeValue,
  });

  factory CommonTypeModel.fromJson(Map<String, dynamic> json) {
    int? cityId = json['common_id'];
    String? cityName = json['common_value'];

    return CommonTypeModel(
      commonTypeId: cityId,
      commonTypeValue: cityName,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['common_id'] = commonTypeId;
    data['common_value'] = commonTypeValue;
    return data;
  }
}