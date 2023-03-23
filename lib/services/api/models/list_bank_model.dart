class ListBankModel {
  int? status;
  List<ListBankData>? listBankData;

  ListBankModel({this.status, this.listBankData});

  ListBankModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      listBankData = <ListBankData>[];
      json['data'].forEach((v) {
        listBankData!.add(ListBankData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (listBankData != null) {
      data['data'] = listBankData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ListBankData {
  String? sId;
  String? code;
  String? name;
  String? createdAt;
  int? iV;
  String? updatedAt;

  ListBankData({
    this.sId,
    this.code,
    this.name,
    this.createdAt,
    this.iV,
    this.updatedAt,
  });

  ListBankData.fromJson(Map<String, dynamic> json) {
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