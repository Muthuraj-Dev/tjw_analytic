class AddressList {
  String? name;
  String? phoneNumber;
  String? pinCode;
  String? state;
  String? city;
  String? houseNoBuildingName;
  String? roadNameAreaColony;

  AddressList({
    this.name,
    this.phoneNumber,
    this.pinCode,
    this.state,
    this.city,
    this.houseNoBuildingName,
    this.roadNameAreaColony,
  });

  AddressList.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    phoneNumber = json['phoneNumber'];
    pinCode = json['pinCode'];
    state = json['state'];
    city = json['city'];
    houseNoBuildingName = json['houseNoBuildingName'];
    roadNameAreaColony = json['roadNameAreaColony'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['phoneNumber'] = phoneNumber;
    data['pinCode'] = pinCode;
    data['state'] = state;
    data['city'] = city;
    data['houseNoBuildingName'] = houseNoBuildingName;
    data['roadNameAreaColony'] = roadNameAreaColony;
    return data;
  }
}
