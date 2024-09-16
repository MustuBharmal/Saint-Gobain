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
