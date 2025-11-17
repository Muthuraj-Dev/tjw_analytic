class Addresses {
  int? id;
  String? name;
  String? phoneNumber;
  String? pincode;
  String? city;
  String? state;
  String? houseBuilding;
  String? streetArea;
  int? userId;
  String? createdAt;
  String? updatedAt;

  Addresses(
      {this.id,
        this.name,
        this.phoneNumber,
        this.pincode,
        this.city,
        this.state,
        this.houseBuilding,
        this.streetArea,
        this.userId,
        this.createdAt,
        this.updatedAt});

  Addresses.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phoneNumber = json['phoneNumber'];
    pincode = json['pincode'];
    city = json['city'];
    state = json['state'];
    houseBuilding = json['houseBuilding'];
    streetArea = json['streetArea'];
    userId = json['userId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['phoneNumber'] = phoneNumber;
    data['pincode'] = pincode;
    data['city'] = city;
    data['state'] = state;
    data['houseBuilding'] = houseBuilding;
    data['streetArea'] = streetArea;
    data['userId'] = userId;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}