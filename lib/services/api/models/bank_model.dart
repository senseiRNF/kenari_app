class BankModel {
  int? status;
  List<BankData>? bankData;

  BankModel({this.status, this.bankData});

  BankModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      bankData = <BankData>[];
      json['data'].forEach((v) {
        bankData!.add(BankData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (bankData != null) {
      data['data'] = bankData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BankData {
  String? sId;
  String? accountName;
  String? accountNo;
  Bank? bank;
  Member? member;
  String? createdAt;
  String? updatedAt;
  int? iV;

  BankData({
    this.sId,
    this.accountName,
    this.accountNo,
    this.bank,
    this.member,
    this.createdAt,
    this.updatedAt,
    this.iV,
  });

  BankData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    accountName = json['account_name'];
    accountNo = json['account_no'];
    bank = json['bank'] != null ? Bank.fromJson(json['bank']) : null;
    member =
    json['member'] != null ? Member.fromJson(json['member']) : null;
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['account_name'] = accountName;
    data['account_no'] = accountNo;
    if (bank != null) {
      data['bank'] = bank!.toJson();
    }
    if (member != null) {
      data['member'] = member!.toJson();
    }
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}

class Bank {
  String? sId;
  String? code;
  String? name;
  String? createdAt;
  int? iV;
  String? updatedAt;

  Bank({
    this.sId,
    this.code,
    this.name,
    this.createdAt,
    this.iV,
    this.updatedAt,
  });

  Bank.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    code = json['code'];
    name = json['name'];
    createdAt = json['createdAt'];
    iV = json['__v'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['code'] = code;
    data['name'] = name;
    data['createdAt'] = createdAt;
    data['__v'] = iV;
    data['updatedAt'] = updatedAt;
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
  String? company;
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
    company = json['company'];
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
    data['company'] = company;
    data['user'] = user;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}