class VariantTypeModel {
  int? status;
  List<VariantTypeData>? variantTypeData;

  VariantTypeModel({this.status, this.variantTypeData});

  VariantTypeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      variantTypeData = <VariantTypeData>[];
      json['data'].forEach((v) {
        variantTypeData!.add(VariantTypeData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (variantTypeData != null) {
      data['data'] = variantTypeData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class VariantTypeData {
  String? sId;
  String? name;
  // List<Null>? varians;
  String? createdAt;
  String? updatedAt;
  int? iV;

  VariantTypeData({
    this.sId,
    this.name,
    // this.varians,
    this.createdAt,
    this.updatedAt,
    this.iV,
  });

  VariantTypeData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    // if (json['varians'] != null) {
    //   varians = <Null>[];
    //   json['varians'].forEach((v) {
    //     varians!.add(new Null.fromJson(v));
    //   });
    // }
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    // if (this.varians != null) {
    //   data['varians'] = this.varians!.map((v) => v.toJson()).toList();
    // }
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}