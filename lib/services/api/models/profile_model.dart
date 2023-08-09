class ProfileModel {
  int? status;
  ProfileData? profileData;

  ProfileModel({this.status, this.profileData});

  ProfileModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    profileData = json['data'] != null ? ProfileData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (profileData != null) {
      data['data'] = profileData!.toJson();
    }
    return data;
  }
}

class ProfileData {
  String? sId;
  String? name;
  String? phoneNumber;
  String? email;
  String? password;
  String? status;
  Company? company;
  User? user;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  int? iV;
  Image? image;

  ProfileData({
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
    this.deletedAt,
    this.iV,
    this.image,
  });

  ProfileData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    phoneNumber = json['phone_number'];
    email = json['email'];
    password = json['password'];
    status = json['status'];
    company =
    json['company'] != null ? Company.fromJson(json['company']) : null;
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    deletedAt = json['deletedAt'];
    iV = json['__v'];
    image = json['image'] != null ? Image.fromJson(json['image']) : null;
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
    if (user != null) {
      data['user'] = user!.toJson();
    }
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['deletedAt'] = deletedAt;
    data['__v'] = iV;
    if (image != null) {
      data['image'] = image!.toJson();
    }
    return data;
  }
}

class Company {
  String? sId;
  String? name;
  String? code;
  String? totalMember;
  bool? status;
  List<Members>? members;
  List<String>? addresses;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  int? iV;
  String? phone;

  Company({
    this.sId,
    this.name,
    this.code,
    this.totalMember,
    this.status,
    this.members,
    this.addresses,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.iV,
    this.phone,
  });

  Company.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    code = json['code'];
    totalMember = json['total_member'];
    status = json['status'];
    if (json['members'] != null) {
      members = <Members>[];
      json['members'].forEach((v) {
        members!.add(Members.fromJson(v));
      });
    }
    addresses = json['addresses'].cast<String>();
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    deletedAt = json['deletedAt'];
    iV = json['__v'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    data['code'] = code;
    data['total_member'] = totalMember;
    data['status'] = status;
    if (members != null) {
      data['members'] = members!.map((v) => v.toJson()).toList();
    }
    data['addresses'] = addresses;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['deletedAt'] = deletedAt;
    data['__v'] = iV;
    data['phone'] = phone;
    return data;
  }
}

class Members {
  String? sId;
  String? name;
  String? phoneNumber;
  String? email;
  String? password;
  String? status;
  String? company;
  String? user;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  int? iV;

  Members({
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
    this.deletedAt,
    this.iV,
  });

  Members.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    phoneNumber = json['phone_number'];
    email = json['email'];
    password = json['password'];
    status = json['status'];
    company = json['company'];
    user = json['user'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    deletedAt = json['deletedAt'];
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
    data['company'] = company;
    data['user'] = user;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['deletedAt'] = deletedAt;
    data['__v'] = iV;
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
  String? deletedAt;
  int? iV;
  String? lastLogin;

  User({
    this.sId,
    this.name,
    this.email,
    this.password,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
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
    deletedAt = json['deletedAt'];
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
    data['deletedAt'] = deletedAt;
    data['__v'] = iV;
    data['lastLogin'] = lastLogin;
    return data;
  }
}

class Image {
  String? sId;
  String? filename;
  String? url;
  bool? primary;
  String? deletedAt;
  int? iV;

  Image({
    this.sId,
    this.filename,
    this.url,
    this.primary,
    this.deletedAt,
    this.iV,
  });

  Image.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    filename = json['filename'];
    url = json['url'];
    primary = json['primary'];
    deletedAt = json['deletedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['_id'] = sId;
    data['filename'] = filename;
    data['url'] = url;
    data['primary'] = primary;
    data['deletedAt'] = deletedAt;
    data['__v'] = iV;
    return data;
  }
}