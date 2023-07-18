class SellerProductModel {
  int? status;
  List<SellerProductData>? sellerProductData;
  Pagination? pagination;

  SellerProductModel({this.status, this.sellerProductData, this.pagination});

  SellerProductModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      sellerProductData = <SellerProductData>[];
      json['data'].forEach((v) {
        sellerProductData!.add(SellerProductData.fromJson(v));
      });
    }
    pagination = json['pagination'] != null
        ? Pagination.fromJson(json['pagination'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (sellerProductData != null) {
      data['data'] = sellerProductData!.map((v) => v.toJson()).toList();
    }
    if (pagination != null) {
      data['pagination'] = pagination!.toJson();
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
  Company? company;
  String? address;
  bool? isPreOrder;
  List<Varians>? varians;
  List<Images>? images;
  // List<Null>? tipeVarian;
  bool? isCompleted;
  bool? status;
  bool? isPromo;
  bool? isRecomendation;
  Members? member;
  // Null? banner;
  String? createdAt;
  String? updatedAt;
  int? iV;
  String? verifyAt;
  String? verifyBy;

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
    // this.tipeVarian,
    this.isCompleted,
    this.status,
    this.isPromo,
    this.isRecomendation,
    this.member,
    // this.banner,
    this.createdAt,
    this.updatedAt,
    this.iV,
    this.verifyAt,
    this.verifyBy
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
    company =
    json['company'] != null ? Company.fromJson(json['company']) : null;
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
    member =
    json['member'] != null ? Members.fromJson(json['member']) : null;
    // banner = json['banner'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    verifyAt = json['verify_at'];
    verifyBy = json['verify_by'];
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
    data['address'] = address;
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
    if (member != null) {
      data['member'] = member!.toJson();
    }
    // data['banner'] = banner;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    data['verify_at'] = verifyAt;
    data['verify_by'] = verifyBy;
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
    this.updatedAt,
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

class Pagination {
  int? totalItems;
  int? currentPage;
  int? totalPages;
  int? itemPerPage;

  Pagination({this.totalItems, this.currentPage, this.totalPages, this.itemPerPage});

  Pagination.fromJson(Map<String, dynamic> json) {
    totalItems = json['total_items'];
    currentPage = json['current_page'];
    totalPages = json['total_pages'];
    itemPerPage = json['item_per_page'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total_items'] = totalItems;
    data['current_page'] = currentPage;
    data['total_pages'] = totalPages;
    data['item_per_page'] = itemPerPage;
    return data;
  }
}