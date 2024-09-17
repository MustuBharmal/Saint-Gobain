class CityModel {
  int? cityId;
  String? cityName;
  String? state;

  CityModel({
    this.cityId,
    this.cityName,
    this.state,
  });

  factory CityModel.fromJson(Map<String, dynamic> json) {
    int? cityId = json['city_id'];
    String? cityName = json['city_name'];
    String? state = json['state'];

    return CityModel(
      cityId: cityId,
      cityName: cityName,
      state: state,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['city_id'] = cityId;
    data['city_name'] = cityName;
    data['state'] = state;
    return data;
  }
}
class ImageModel {
  int? imageId;
  String? path;
  int? siteId;

  ImageModel({this.imageId, this.path, this.siteId});

  factory ImageModel.fromJson(Map<String, dynamic> json) {
    int? imageId = json['image_id'];
    String? path = json['path'] ?? '';
    int? siteId = json['site_id'];
    return ImageModel(
      imageId: imageId,
      path: path,
      siteId: siteId,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['image_id'] = imageId;
    data['path'] = path;
    data['site_id'] = siteId;
    return data;
  }
}