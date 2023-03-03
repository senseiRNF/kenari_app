class CategoryModel {
  int? status;
  List<CategoryData>? categoryData;

  CategoryModel({this.status, this.categoryData});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      categoryData = <CategoryData>[];
      json['data'].forEach((v) {
        categoryData!.add(CategoryData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (categoryData != null) {
      data['data'] = categoryData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CategoryData {
  String? sId;
  String? name;
  bool? status;
  String? createdAt;
  String? updatedAt;
  int? iV;

  CategoryData({
    this.sId,
    this.name,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.iV,
  });

  CategoryData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    data['status'] = status;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}