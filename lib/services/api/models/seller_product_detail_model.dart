class SellerProductDetailModel {
  int? status;
  SellerProductDetailData? sellerProductDetailData;

  SellerProductDetailModel({this.status, this.sellerProductDetailData});

  SellerProductDetailModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    sellerProductDetailData = json['data'] != null ? SellerProductDetailData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (sellerProductDetailData != null) {
      data['data'] = sellerProductDetailData!.toJson();
    }
    return data;
  }
}

class SellerProductDetailData {
  String? sId;
  String? name;
  String? description;
  String? price;
  String? stock;
  bool? isStockAlwaysAvailable;
  ProductCategory? productCategory;
  Company? company;
  Address? address;
  bool? isPreOrder;
  List<Varians>? varians;
  List<Images>? images;
  // List<Null>? tipeVarian;
  bool? isCompleted;
  bool? status;
  bool? isPromo;
  bool? isRecomendation;
  String? member;
  // Null? banner;
  String? verifyAt;
  VerifyBy? verifyBy;
  String? createdAt;
  String? updatedAt;
  int? iV;

  SellerProductDetailData({
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
    // this.tipeVarian,
    this.isCompleted,
    this.status,
    this.isPromo,
    this.isRecomendation,
    this.member,
    // this.banner,
    this.verifyAt,
    this.verifyBy,
    this.createdAt,
    this.updatedAt,
    this.iV,
  });

  SellerProductDetailData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    description = json['description'];
    price = json['price'];
    stock = json['stock'];
    isStockAlwaysAvailable = json['is_stock_always_available'];
    productCategory = json['productCategory'] != null
        ? ProductCategory.fromJson(json['productCategory'])
        : null;
    company =
    json['company'] != null ? Company.fromJson(json['company']) : null;
    address =
    json['address'] != null ? Address.fromJson(json['address']) : null;
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
    // if (json['tipeVarian'] != null) {
    //   tipeVarian = <Null>[];
    //   json['tipeVarian'].forEach((v) {
    //     tipeVarian!.add(Null.fromJson(v));
    //   });
    // }
    isCompleted = json['is_completed'];
    status = json['status'];
    isPromo = json['is_promo'];
    isRecomendation = json['is_recomendation'];
    member = json['member'];
    // banner = json['banner'];
    verifyAt = json['verify_at'];
    verifyBy = json['verify_by'] != null
        ? VerifyBy.fromJson(json['verify_by'])
        : null;
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
    if (company != null) {
      data['company'] = company!.toJson();
    }
    if (address != null) {
      data['address'] = address!.toJson();
    }
    data['is_pre_order'] = isPreOrder;
    if (varians != null) {
      data['varians'] = varians!.map((v) => v.toJson()).toList();
    }
    if (images != null) {
      data['images'] = images!.map((v) => v.toJson()).toList();
    }
    // if (tipeVarian != null) {
    //   data['tipeVarian'] = tipeVarian!.map((v) => v.toJson()).toList();
    // }
    data['is_completed'] = isCompleted;
    data['status'] = status;
    data['is_promo'] = isPromo;
    data['is_recomendation'] = isRecomendation;
    data['member'] = member;
    // data['banner'] = banner;
    data['verify_at'] = verifyAt;
    if (verifyBy != null) {
      data['verify_by'] = verifyBy!.toJson();
    }
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

class Address {
  String? sId;
  String? address;
  String? company;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Address({
    this.sId,
    this.address,
    this.company,
    this.createdAt,
    this.updatedAt,
    this.iV,
  });

  Address.fromJson(Map<String, dynamic> json) {
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

class Varians {
  String? sId;
  String? price;
  String? promoPrice;
  String? name1;
  String? name2;
  String? stock;
  bool? isStockAlwaysAvailable;
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

  Images({
    this.sId,
    this.filename,
    this.url,
    this.primary,
    this.product,
    this.iV,
  });

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

class VerifyBy {
  String? sId;
  String? name;
  String? email;
  String? password;
  String? createdAt;
  String? updatedAt;
  int? iV;
  String? lastLogin;

  VerifyBy({
    this.sId,
    this.name,
    this.email,
    this.password,
    this.createdAt,
    this.updatedAt,
    this.iV,
    this.lastLogin,
  });

  VerifyBy.fromJson(Map<String, dynamic> json) {
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