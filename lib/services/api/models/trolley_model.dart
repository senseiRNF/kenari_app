class TrolleyModel {
  int? status;
  List<TrolleyData>? trolleyData;

  TrolleyModel({this.status, this.trolleyData});

  TrolleyModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      trolleyData = <TrolleyData>[];
      json['data'].forEach((v) {
        trolleyData!.add(TrolleyData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (trolleyData != null) {
      data['data'] = trolleyData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TrolleyData {
  String? sId;
  String? price;
  String? totalPrice;
  String? varianName;
  String? varian;
  Product? product;
  Member? member;
  String? qty;
  String? createdAt;
  String? updatedAt;
  int? iV;

  TrolleyData({
    this.sId,
    this.price,
    this.totalPrice,
    this.varianName,
    this.varian,
    this.product,
    this.member,
    this.qty,
    this.createdAt,
    this.updatedAt,
    this.iV,
  });

  TrolleyData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    price = json['price'];
    totalPrice = json['total_price'];
    varianName = json['varian_name'];
    varian = json['varian'];
    product =
    json['product'] != null ? Product.fromJson(json['product']) : null;
    member =
    json['member'] != null ? Member.fromJson(json['member']) : null;
    qty = json['qty'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['price'] = price;
    data['total_price'] = totalPrice;
    data['varian_name'] = varianName;
    data['varian'] = varian;
    if (product != null) {
      data['product'] = product!.toJson();
    }
    if (member != null) {
      data['member'] = member!.toJson();
    }
    data['qty'] = qty;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}

class Product {
  String? sId;
  String? name;
  String? description;
  String? price;
  String? stock;
  bool? isStockAlwaysAvailable;
  String? productCategory;
  String? company;
  Address? address;
  bool? isPreOrder;
  List<String>? varians;
  List<Images>? images;
  // List<Null>? tipeVarian;
  bool? isCompleted;
  bool? status;
  bool? isPromo;
  bool? isRecomendation;
  String? createdAt;
  String? updatedAt;
  int? iV;
  String? promoPrice;

  Product({
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
    this.createdAt,
    this.updatedAt,
    this.iV,
    this.promoPrice,
  });

  Product.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    description = json['description'];
    price = json['price'];
    stock = json['stock'];
    isStockAlwaysAvailable = json['is_stock_always_available'];
    productCategory = json['productCategory'];
    company = json['company'];
    address =
    json['address'] != null ? Address.fromJson(json['address']) : null;
    isPreOrder = json['is_pre_order'];
    varians = json['varians'].cast<String>();
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
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    promoPrice = json['promo_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    data['description'] = description;
    data['price'] = price;
    data['stock'] = stock;
    data['is_stock_always_available'] = isStockAlwaysAvailable;
    data['productCategory'] = productCategory;
    data['company'] = company;
    if (address != null) {
      data['address'] = address!.toJson();
    }
    data['is_pre_order'] = isPreOrder;
    data['varians'] = varians;
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
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    data['promo_price'] = promoPrice;
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
    this.iV
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