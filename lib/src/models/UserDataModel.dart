class UserDataModel {
  String? success;
  int? code;
  Data? data;

  UserDataModel({this.success, this.code, this.data});

  UserDataModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    code = json['code'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['code'] = this.code;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? id;
  Object? role;
  int? roleId;
  int? addedBy;
  String? name;
  String? email;
  String? phone;
  String? address;
  String? addressLatitude;
  String? addressLongitude;
  Object? pincode;
  Object? cityId;
  Object? emailVerifiedAt;
  int? verifiyStatus;
  Object? isAdmin;
  Object? profile;
  Object? drivingLicence;
  Object? idCard;
  Object? modelNumber;
  Object? registerNumber;
  Object? companyName;
  Object? companyAddress;
  Object? companyPhone;
  String? workType;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.id,
      this.role,
      this.roleId,
      this.addedBy,
      this.name,
      this.email,
      this.phone,
      this.address,
      this.addressLatitude,
      this.addressLongitude,
      this.pincode,
      this.cityId,
      this.emailVerifiedAt,
      this.verifiyStatus,
      this.isAdmin,
      this.profile,
      this.drivingLicence,
      this.idCard,
      this.modelNumber,
      this.registerNumber,
      this.companyName,
      this.companyAddress,
      this.companyPhone,
      this.workType,
      this.createdAt,
      this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    role = json['role'];
    roleId = json['role_id'];
    addedBy = json['added_by'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    address = json['address'];
    addressLatitude = json['address_latitude'];
    addressLongitude = json['address_longitude'];
    pincode = json['pincode'];
    cityId = json['city_id'];
    emailVerifiedAt = json['email_verified_at'];
    verifiyStatus = json['verifiy_status'];
    isAdmin = json['is_admin'];
    profile = json['profile'];
    drivingLicence = json['driving_licence'];
    idCard = json['id_card'];
    modelNumber = json['model_number'];
    registerNumber = json['register_number'];
    companyName = json['company_name'];
    companyAddress = json['company_address'];
    companyPhone = json['company_phone'];
    workType = json['work_type'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['role'] = this.role;
    data['role_id'] = this.roleId;
    data['added_by'] = this.addedBy;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['address'] = this.address;
    data['address_latitude'] = this.addressLatitude;
    data['address_longitude'] = this.addressLongitude;
    data['pincode'] = this.pincode;
    data['city_id'] = this.cityId;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['verifiy_status'] = this.verifiyStatus;
    data['is_admin'] = this.isAdmin;
    data['profile'] = this.profile;
    data['driving_licence'] = this.drivingLicence;
    data['id_card'] = this.idCard;
    data['model_number'] = this.modelNumber;
    data['register_number'] = this.registerNumber;
    data['company_name'] = this.companyName;
    data['company_address'] = this.companyAddress;
    data['company_phone'] = this.companyPhone;
    data['work_type'] = this.workType;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
