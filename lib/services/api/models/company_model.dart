class CompanyModel {
  int? status;
  CompanyData? companyData;

  CompanyModel({this.status, this.companyData});

  CompanyModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    companyData = json['data'] != null ? CompanyData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (companyData != null) {
      data['data'] = companyData!.toJson();
    }
    return data;
  }
}

class CompanyData {
  String? sId;
  String? name;
  String? code;
  String? phone;
  String? totalMember;
  bool? status;
  List<Addresses>? addresses;
  List<Members>? members;
  String? createdAt;
  String? updatedAt;
  int? iV;

  CompanyData({
    this.sId,
    this.name,
    this.code,
    this.phone,
    this.totalMember,
    this.status,
    this.addresses,
    this.members,
    this.createdAt,
    this.updatedAt,
    this.iV,
  });

  CompanyData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    code = json['code'];
    phone = json['phone_number'];
    totalMember = json['total_member'];
    status = json['status'];
    if (json['addresses'] != null) {
      addresses = <Addresses>[];
      json['addresses'].forEach((v) {
        addresses!.add(Addresses.fromJson(v));
      });
    }
    if (json['members'] != null) {
      members = <Members>[];
      json['members'].forEach((v) {
        members!.add(Members.fromJson(v));
      });
    }
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    data['code'] = code;
    data['phone_number'] = phone;
    data['total_member'] = totalMember;
    data['status'] = status;
    if (addresses != null) {
      data['addresses'] = addresses!.map((v) => v.toJson()).toList();
    }
    if (members != null) {
      data['members'] = members!.map((v) => v.toJson()).toList();
    }
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}

class Addresses {
  String? sId;
  String? address;
  String? company;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Addresses({
    this.sId,
    this.address,
    this.company,
    this.createdAt,
    this.updatedAt,
    this.iV,
  });

  Addresses.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    address = json['address'];
    company = json['company'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['address'] = address;
    data['company'] = company;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}

class Members {
  String? name;
  String? phoneNumber;
  String? email;
  String? password;
  String? status;
  String? company;
  String? user;
  String? createdAt;
  String? sId;
  String? updatedAt;
  int? iV;

  Members({
    this.name,
    this.phoneNumber,
    this.email,
    this.password,
    this.status,
    this.company,
    this.user,
    this.createdAt,
    this.sId,
    this.updatedAt,
    this.iV,
  });

  Members.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    phoneNumber = json['phone_number'];
    email = json['email'];
    password = json['password'];
    status = json['status'];
    company = json['company'];
    user = json['user'];
    createdAt = json['createdAt'];
    sId = json['_id'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['phone_number'] = phoneNumber;
    data['email'] = email;
    data['password'] = password;
    data['status'] = status;
    data['company'] = company;
    data['user'] = user;
    data['createdAt'] = createdAt;
    data['_id'] = sId;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}