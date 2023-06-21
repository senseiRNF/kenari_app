class SellerProductModel {
  int? status;
  List<SellerProductData>? sellerProductData;

  SellerProductModel({this.status, this.sellerProductData});

  SellerProductModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      sellerProductData = <SellerProductData>[];
      json['data'].forEach((v) {
        sellerProductData!.add(SellerProductData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (sellerProductData != null) {
      data['data'] = sellerProductData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SellerProductData {
  String? sId;
  String? name;
  String? description;
  String? price;
  String? stock;
  bool? isStockAlwaysAvailable;
  ProductCategory? productCategory;
  dynamic company;
  dynamic address;
  bool? isPreOrder;
  List<Varians>? varians;
  List<Images>? images;
  List? tipeVarian;
  bool? isCompleted;
  bool? status;
  bool? isPromo;
  bool? isRecomendation;
  Member? member;
  dynamic banner;
  String? createdAt;
  String? updatedAt;
  int? iV;

  SellerProductData({
    this.sId,
    this.name,
    this.description,
    this.price,
    this.stock,
    this.isStockAlwaysAvailable,
    this.productCategory,
    this.company,
    this.address,
    this.isPreOrder,
    this.varians,
    this.images,
    this.tipeVarian,
    this.isCompleted,
    this.status,
    this.isPromo,
    this.isRecomendation,
    this.member,
    this.banner,
    this.createdAt,
    this.updatedAt,
    this.iV,
  });

  SellerProductData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    description = json['description'];
    price = json['price'];
    stock = json['stock'];
    isStockAlwaysAvailable = json['is_stock_always_available'];
    productCategory = json['productCategory'] != null
        ? ProductCategory.fromJson(json['productCategory'])
        : null;
    company = json['company'];
    address = json['address'];
    isPreOrder = json['is_pre_order'];
    if (json['varians'] != null) {
      varians = <Varians>[];
      json['varians'].forEach((v) {
        varians!.add(Varians.fromJson(v));
      });
    }
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images!.add(Images.fromJson(v));
      });
    }
    if (json['tipeVarian'] != null) {
      tipeVarian = <Null>[];
      json['tipeVarian'].forEach((v) {
        tipeVarian!.add(v);
      });
    }
    isCompleted = json['is_completed'];
    status = json['status'];
    isPromo = json['is_promo'];
    isRecomendation = json['is_recomendation'];
    member =
    json['member'] != null ? Member.fromJson(json['member']) : null;
    banner = json['banner'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    data['description'] = description;
    data['price'] = price;
    data['stock'] = stock;
    data['is_stock_always_available'] = isStockAlwaysAvailable;
    if (productCategory != null) {
      data['productCategory'] = productCategory!.toJson();
    }
    data['company'] = company;
    data['address'] = address;
    data['is_pre_order'] = isPreOrder;
    if (varians != null) {
      data['varians'] = varians!.map((v) => v.toJson()).toList();
    }
    if (images != null) {
      data['images'] = images!.map((v) => v.toJson()).toList();
    }
    if (tipeVarian != null) {
      data['tipeVarian'] = tipeVarian!.map((v) => v.toJson()).toList();
    }
    data['is_completed'] = isCompleted;
    data['status'] = status;
    data['is_promo'] = isPromo;
    data['is_recomendation'] = isRecomendation;
    if (member != null) {
      data['member'] = member!.toJson();
    }
    data['banner'] = banner;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}

class ProductCategory {
  String? sId;
  String? name;
  bool? status;
  String? createdAt;
  int? iV;
  String? updatedAt;

  ProductCategory({
    this.sId,
    this.name,
    this.status,
    this.createdAt,
    this.iV,
    this.updatedAt
  });

  ProductCategory.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    status = json['status'];
    createdAt = json['createdAt'];
    iV = json['__v'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    data['status'] = status;
    data['createdAt'] = createdAt;
    data['__v'] = iV;
    data['updatedAt'] = updatedAt;
    return data;
  }
}

class Varians {
  String? sId;
  String? price;
  String? promoPrice;
  String? name1;
  String? name2;
  String? stock;
  bool? isStockAlwaysAvailable;
  String? varianType1;
  String? varianType2;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Varians({
    this.sId,
    this.price,
    this.promoPrice,
    this.name1,
    this.name2,
    this.stock,
    this.isStockAlwaysAvailable,
    this.varianType1,
    this.varianType2,
    this.createdAt,
    this.updatedAt,
    this.iV,
  });

  Varians.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    price = json['price'];
    promoPrice = json['promo_price'];
    name1 = json['name1'];
    name2 = json['name2'];
    stock = json['stock'];
    isStockAlwaysAvailable = json['is_stock_always_available'];
    varianType1 = json['varianType1'];
    varianType2 = json['varianType2'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['price'] = price;
    data['promo_price'] = promoPrice;
    data['name1'] = name1;
    data['name2'] = name2;
    data['stock'] = stock;
    data['is_stock_always_available'] = isStockAlwaysAvailable;
    data['varianType1'] = varianType1;
    data['varianType2'] = varianType2;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}

class Member {
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

class Images {
  String? sId;
  String? filename;
  String? url;
  bool? primary;
  String? product;
  int? iV;

  Images({this.sId, this.filename, this.url, this.primary, this.product, this.iV});

  Images.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    filename = json['filename'];
    url = json['url'];
    primary = json['primary'];
    product = json['product'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['filename'] = filename;
    data['url'] = url;
    data['primary'] = primary;
    data['product'] = product;
    data['__v'] = iV;
    return data;
  }
}