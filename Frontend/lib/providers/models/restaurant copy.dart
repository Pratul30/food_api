class UserModel {
  String firstName;
  String lastName;
  String email;
  String country;
  String cusId;
  String ewalletId;
  String businessVatId;

  UserModel({
    this.firstName,
    this.lastName,
    this.email,
    this.country,
    this.cusId,
    this.ewalletId,
    this.businessVatId
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    country = json['country'];
    cusId = json['cus_id'];
    ewalletId = json['ewallet_id'];
    businessVatId = json['business_vat_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['email'] = this.email;
    data['country'] = this.country;
    data['cus_id'] = this.cusId;
    data['ewallet_id'] = this.ewalletId;
    data['business_vat_id'] = this.businessVatId;
    return data;
  }
}
