class LoginModel {
  int? status;
  LoginData? loginData;

  LoginModel({this.status, this.loginData});

  LoginModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    loginData = json['data'] != null ? LoginData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (loginData != null) {
      data['data'] = loginData!.toJson();
    }
    return data;
  }
}

class LoginData {
  User? user;
  Member? member;
  String? token;

  LoginData({this.user, this.member, this.token});

  LoginData.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    member =
    json['member'] != null ? Member.fromJson(json['member']) : null;
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (user != null) {
      data['user'] = user!.toJson();
    }
    if (member != null) {
      data['member'] = member!.toJson();
    }
    data['token'] = token;
    return data;
  }
}

class User {
  String? sId;
  String? name;
  String? email;
  String? password;
  String? createdAt;
  String? updatedAt;
  int? iV;
  String? lastLogin;

  User({
    this.sId,
    this.name,
    this.email,
    this.password,
    this.createdAt,
    this.updatedAt,
    this.iV,
    this.lastLogin,
  });

  User.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    email = json['email'];
    password = json['password'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    lastLogin = json['lastLogin'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    data['email'] = email;
    data['password'] = password;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    data['lastLogin'] = lastLogin;
    return data;
  }
}

class Member {
  String? sId;
  String? name;
  String? phoneNumber;
  String? email;
  String? password;
  bool? status;
  Company? company;
  String? user;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Member({
    this.sId,
    this.name,
    this.phoneNumber,
    this.email,
    this.password,
    this.status,
    this.company,
    this.user,
    this.createdAt,
    this.updatedAt,
    this.iV,
  });

  Member.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    phoneNumber = json['phone_number'];
    email = json['email'];
    password = json['password'];
    status = json['status'];
    company =
    json['company'] != null ? Company.fromJson(json['company']) : null;
    user = json['user'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    data['phone_number'] = phoneNumber;
    data['email'] = email;
    data['password'] = password;
    data['status'] = status;
    if (company != null) {
      data['company'] = company!.toJson();
    }
    data['user'] = user;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}

class Company {
  String? sId;
  String? name;
  String? code;
  String? totalMember;
  bool? status;
  List<String>? addresses;
  List<CompanyMembers>? companyMembers;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Company({
    this.sId,
    this.name,
    this.code,
    this.totalMember,
    this.status,
    this.addresses,
    this.companyMembers,
    this.createdAt,
    this.updatedAt,
    this.iV,
  });

  Company.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    code = json['code'];
    totalMember = json['total_member'];
    status = json['status'];
    addresses = json['addresses'].cast<String>();
    if (json['members'] != null) {
      companyMembers = <CompanyMembers>[];
      json['members'].forEach((v) {
        companyMembers!.add(CompanyMembers.fromJson(v));
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
    data['total_member'] = totalMember;
    data['status'] = status;
    data['addresses'] = addresses;
    if (companyMembers != null) {
      data['members'] = companyMembers!.map((v) => v.toJson()).toList();
    }
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}

class CompanyMembers {
  String? name;
  String? phoneNumber;
  String? email;
  String? password;
  bool? status;
  String? company;
  String? user;
  String? createdAt;
  String? sId;
  String? updatedAt;
  int? iV;

  CompanyMembers({
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

  CompanyMembers.fromJson(Map<String, dynamic> json) {
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