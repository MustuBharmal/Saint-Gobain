import '../../common_models/common_model.dart';

class RanPainterModel {
  String? dbType;
  int? painterId;
  int? companyId;
  String? painterName;
  String? painterType;
  String? painterPhone;
  String? remarks;
  String? giveaways;
  String? latitude;
  String? longitude;
  String? geolocation;
  int? engagement;
  int? videoShown;
  List<ImageModel>? images;

  RanPainterModel(
      {this.dbType,
      this.painterId,
      this.companyId,
      this.painterName,
      this.painterType,
      this.painterPhone,
      this.remarks,
      this.giveaways,
      this.latitude,
      this.longitude,
      this.geolocation,
      this.engagement,
      this.videoShown,
      this.images});

  factory RanPainterModel.fromJson(Map<String, dynamic> json) {
    String? dbType = json['dbtype'];
    int? painterId = json['painter_id'];
    int? companyId = json['company_id'];
    String? painterName = json['painter_name'];
    String? painterType = json['painter_type'];
    String? painterPhone = json['painter_phone'];
    String? remarks = json['remarks'];
    String? giveaways = json['give_aways'];
    String? latitude = json['latitude'];
    String? longitude = json['longitude'];
    String? geolocation = json['geolocation'];
    int? engagement = json['engagement'];
    int? videoShown = json['video_shown'];
    List<dynamic> images = json['images'];
    List<ImageModel>? listOfImages = [];
    for (var element in images) {
      listOfImages.add(ImageModel.fromJson(element));
    }
    return RanPainterModel(
      dbType: dbType,
      painterId: painterId,
      companyId: companyId,
      painterName: painterName,
      painterType: painterType,
      painterPhone: painterPhone,
      remarks: remarks,
      giveaways: giveaways,
      latitude: latitude,
      longitude: longitude,
      geolocation: geolocation,
      engagement: engagement,
      videoShown: videoShown,
      images: listOfImages,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['dbtype'] = dbType;
    data['company_id'] = companyId;
    data['painter_name'] = painterName;
    data['painter_type'] = painterType;
    data['painter_phone'] = painterPhone;
    data['remarks'] = remarks;
    data['give_aways'] = giveaways;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['geolocation'] = geolocation;
    data['engagement'] = engagement;
    data['video_shown'] = videoShown;
    return data;
  }

  Map<String, dynamic> toJsonDelete() {
    final Map<String, dynamic> data = <String, dynamic>{};

    List<dynamic> image = [];
    for (int i = 0; i < images!.length; i++) {
      image.add(images![i].toJson());
    }
    data['dbtype'] = dbType;
    data['company_id'] = companyId;
    data['painter_id'] = painterId;
    data['painter_name'] = painterName;
    data['painter_type'] = painterType;
    data['painter_phone'] = painterPhone;
    data['remarks'] = remarks;
    data['give_aways'] = giveaways;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['geolocation'] = geolocation;
    data['engagement'] = engagement;
    data['video_shown'] = videoShown;
    data['deleted_images'] = image;
    return data;
  }
}
