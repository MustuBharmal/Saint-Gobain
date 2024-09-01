import '../../site/model/common_model.dart';

class RetailOutletModel {
  String? dbType;
  int? outletId;
  String? outletName;
  String? outletAddress;
  int? outletCityId;
  String? outletOwner;
  int? outletPhone;
  String? mapLink;
  String? giveaways;
  List<Customers>? customers;
  String? createdBy;
  String? createdAt;
  String? updatedBy;
  String? updatedAt;
  int? companyId;
  String? cityName;
  List<ImageModel>? images;

  RetailOutletModel(
      {this.dbType,
      this.outletId,
      this.outletName,
      this.outletAddress,
      this.outletCityId,
      this.outletOwner,
      this.outletPhone,
      this.mapLink,
      this.giveaways,
      this.customers,
      this.createdBy,
      this.createdAt,
      this.updatedBy,
      this.updatedAt,
      this.companyId,
      this.cityName,
      this.images});

  factory RetailOutletModel.fromJson(Map<String, dynamic> json) {
    int? outletId = json['outlet_id'];
    String? outletName = json['outlet_name'];
    String? outletAddress = json['outlet_address'];
    int? outletCityId = json['outlet_city_id'];
    String? outletOwner = json['outlet_owner'];
    int? outletPhone = json['outlet_phone'];
    String? mapLink = json['map_link'];
    String? giveaways = json['give_aways'];
    List<Customers>? listOfCustomers = [];
    List<dynamic> customers = json['customers'];
    for (var element in customers) {
      listOfCustomers.add(Customers.fromJson(element));
    }
    String? createdBy = json['created_by'];
    String? createdAt = json['created_at'];
    String? updatedBy = json['updated_by'];
    String? updatedAt = json['updated_at'];
    int? companyId = json['company_id'];
    String? cityName = json['city_name'];
    List<ImageModel>? listOfImages = [];
    List<dynamic> images = json['images'];
    for (var element in images) {
      listOfImages.add(ImageModel.fromJson(element));
    }
    return RetailOutletModel(
      outletId: outletId,
      outletName: outletName,
      outletAddress: outletAddress,
      outletCityId: outletCityId,
      outletOwner: outletOwner,
      outletPhone: outletPhone,
      mapLink: mapLink,
      giveaways: giveaways,
      customers: listOfCustomers,
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
    List<dynamic> customer = [];
    for (int i = 0; i < customers!.length; i++) {
      customer.add(customers![i].toJson());
    }
    data['dbtype'] = dbType;
    data['outlet_name'] = outletName;
    data['outlet_address'] = outletAddress;
    data['outlet_city_id'] = outletCityId;
    data['outlet_owner'] = outletOwner;
    data['outlet_phone'] = outletPhone;
    data['map_link'] = mapLink ?? '';
    data['give_aways'] = giveaways;
    data['customers'] = customer;
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
    List<dynamic> customer = [];
    for (int i = 0; i < customers!.length; i++) {
      customer.add(customers![i].toJson());
    }
    data['dbtype'] = dbType;
    data['outlet_id'] = outletId;
    data['outlet_name'] = outletName;
    data['outlet_address'] = outletAddress;
    data['outlet_city_id'] = outletCityId;
    data['outlet_owner'] = outletOwner;
    data['outlet_phone'] = outletPhone;
    data['map_link'] = mapLink;
    data['give_aways'] = giveaways;
    data['customers'] = customer;
    data['created_by'] = createdBy;
    data['created_at'] = createdAt;
    data['updated_by'] = updatedBy;
    data['updated_at'] = updatedAt;
    data['company_id'] = companyId;
    data['city_name'] = cityName;
    return data;
  }
}

class Customers {
  String? name;
  String? type;
  String? phone;

  Customers({this.name, this.type, this.phone});

  factory Customers.fromJson(Map<String, dynamic> json) {
    String? name = json['name'];
    String? type = json['type'];
    String? phone = json['phone'];

    return Customers(
      name: name,
      type: type,
      phone: phone,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['type'] = type;
    data['phone'] = phone;
    return data;
  }
}
