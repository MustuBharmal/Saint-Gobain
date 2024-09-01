import 'common_model.dart';

class SiteModel {
  String? dbType;
  int? siteId;
  String? contractorName;
  int? contractorPhone;
  String? contractorAddress;
  int? siteCityId;
  String? siteAddress;
  String? siteType;
  String? mapLink;
  String? remarks;
  String? giveAWays;
  List<Painters>? painters;
  String? createdBy;
  String? createdAt;
  String? updatedBy;
  String? updatedAt;
  int? companyId;
  String? cityName;
  List<ImageModel>? images;

  SiteModel(
      {this.dbType,
      this.siteId,
      this.contractorName,
      this.contractorPhone,
      this.contractorAddress,
      this.siteCityId,
      this.siteAddress,
      this.siteType,
      this.mapLink,
      this.remarks,
      this.giveAWays,
      this.painters,
      this.createdBy,
      this.createdAt,
      this.updatedBy,
      this.updatedAt,
      this.companyId,
      this.cityName,
      this.images});

  factory SiteModel.fromJson(Map<String, dynamic> json) {
    int? siteId = json['site_id'];
    String? contractorName = json['contractor_name'] ?? '';
    int? contractorPhone = json['contractor_phone'] ?? 0;
    String? contractorAddress = json['contractor_address'] ?? '';
    int? siteCityId = json['site_city_id'];
    String? siteAddress = json['site_address'] ?? '';
    String? siteType = json['site_type'] ?? '';
    String? mapLink = json['map_link'] ?? '';
    String? remarks = json['remarks'] ?? '';
    String? giveAWays = json['give_aways'] ?? '';
    List<Painters>? listOfPainters = [];
    List<dynamic> painters = json['painters'];
    for (var element in painters) {
      listOfPainters.add(Painters.fromJson(element));
    }
    String? createdBy = json['created_by'] ?? '';
    String? createdAt = json['created_at'] ?? '';
    String? updatedBy = json['updated_by'] ?? '';
    String? updatedAt = json['updated_at'] ?? '';
    int? companyId = json['company_id'];
    String? cityName = json['city_name'] ?? '';
    List<ImageModel>? listOfImages = [];
    List<dynamic> images = json['images'];
    for (var element in images) {
      listOfImages.add(ImageModel.fromJson(element));
    }
    return SiteModel(
      siteId: siteId,
      contractorName: contractorName,
      contractorPhone: contractorPhone,
      contractorAddress: contractorAddress,
      siteCityId: siteCityId,
      siteAddress: siteAddress,
      siteType: siteType,
      mapLink: mapLink,
      remarks: remarks,
      giveAWays: giveAWays,
      painters: listOfPainters,
      createdBy: createdBy,
      createdAt: createdAt,
      updatedBy: updatedBy,
      updatedAt: updatedAt,
      companyId: companyId,
      cityName: cityName,
      images: listOfImages,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    List<dynamic> painter = [];
    for (int i = 0; i < painters!.length; i++) {
      painter.add(painters![i].toJson());
    }
    data['dbtype'] = dbType;
    data['site_id'] = siteId;
    data['contractor_name'] = contractorName;
    data['contractor_phone'] = contractorPhone;
    data['contractor_address'] = contractorAddress;
    data['site_city_id'] = siteCityId;
    data['site_address'] = siteAddress;
    data['site_type'] = siteType;
    data['map_link'] = mapLink;
    data['remarks'] = remarks;
    data['give_aways'] = giveAWays;
    data['painters'] = painter;
    data['created_by'] = createdBy;
    data['created_at'] = createdAt;
    data['updated_by'] = updatedBy;
    data['updated_at'] = updatedAt;
    data['company_id'] = companyId;
    data['city_name'] = cityName;
    return data;
  }

  Map<String, dynamic> toJsonDelete() {
    final Map<String, dynamic> data = <String, dynamic>{};
    List<dynamic> image = [];
    for (int i = 0; i < images!.length; i++) {
      image.add(images![i].toJson());
    }
    List<dynamic> painter = [];
    for (int i = 0; i < painters!.length; i++) {
      painter.add(painters![i].toJson());
    }
    data['dbtype'] = dbType;
    data['site_id'] = siteId;
    data['contractor_name'] = contractorName;
    data['contractor_phone'] = contractorPhone;
    data['contractor_address'] = contractorAddress;
    data['site_city_id'] = siteCityId;
    data['site_address'] = siteAddress;
    data['site_type'] = siteType;
    data['map_link'] = mapLink;
    data['remarks'] = remarks;
    data['give_aways'] = giveAWays;
    data['painters'] = painter;
    data['created_by'] = createdBy;
    data['created_at'] = createdAt;
    data['updated_by'] = updatedBy;
    data['updated_at'] = updatedAt;
    data['company_id'] = companyId;
    data['city_name'] = cityName;
    data['deleted_images'] = image;
    return data;
  }
}

class Painters {
  String? name;
  String? phone;

  Painters({this.name, this.phone});

  factory Painters.fromJson(Map<String, dynamic> json) {
    String? name = json['name'] ?? '';
    String? phone = json['phone'] ?? '';

    return Painters(name: name, phone: phone);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['phone'] = phone;
    return data;
  }
}
