class CheckCompanyModel {
  int? status;
  CheckCompanyData? checkCompanyData;

  CheckCompanyModel({this.status, this.checkCompanyData});

  CheckCompanyModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    checkCompanyData = json['data'] != null ? CheckCompanyData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (checkCompanyData != null) {
      data['data'] = checkCompanyData!.toJson();
    }
    return data;
  }
}

class CheckCompanyData {
  String? sId;
  String? name;
  String? code;
  String? totalMember;
  bool? status;
  String? createdAt;
  String? updatedAt;
  int? iV;

  CheckCompanyData({
    this.sId,
    this.name,
    this.code,
    this.totalMember,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.iV,
  });

  CheckCompanyData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    code = json['code'];
    totalMember = json['total_member'];
    status = json['status'];
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
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}