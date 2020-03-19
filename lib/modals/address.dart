class AddressModel {
  String name;
  String phoneNumber;
  String flatNumber;
  String area;
  String landmark;
  String city;
  String state;
  String pincode;

  AddressModel(
      {this.name,
        this.phoneNumber,
        this.flatNumber,
        this.area,
        this.landmark,
        this.city,
        this.state,
        this.pincode});

  AddressModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    phoneNumber = json['phoneNumber'];
    flatNumber = json['flatNumber'];
    area = json['area'];
    landmark = json['landmark'];
    city = json['city'];
    state = json['state'];
    pincode = json['pincode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['phoneNumber'] = this.phoneNumber;
    data['flatNumber'] = this.flatNumber;
    data['area'] = this.area;
    data['landmark'] = this.landmark;
    data['city'] = this.city;
    data['state'] = this.state;
    data['pincode'] = this.pincode;
    return data;
  }
}
