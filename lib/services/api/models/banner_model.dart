class BannerModel {
  int? status;
  List<BannerData>? bannerData;
  Pagination? pagination;

  BannerModel({this.status, this.bannerData, this.pagination});

  BannerModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      bannerData = <BannerData>[];
      json['data'].forEach((v) {
        bannerData!.add(BannerData.fromJson(v));
      });
    }
    pagination = json['pagination'] != null
        ? Pagination.fromJson(json['pagination'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (bannerData != null) {
      data['data'] = bannerData!.map((v) => v.toJson()).toList();
    }
    if (pagination != null) {
      data['pagination'] = pagination!.toJson();
    }
    return data;
  }
}

class BannerData {
  String? sId;
  String? title;
  String? type;
  bool? status;
  List<Products>? products;
  String? createdAt;
  BannerImage? bannerImage;
  String? updatedAt;
  String? deletedAt;
  int? iV;

  BannerData({
    this.sId,
    this.title,
    this.type,
    this.status,
    this.products,
    this.createdAt,
    this.bannerImage,
    this.updatedAt,
    this.iV,
    this.deletedAt,
  });

  BannerData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    type = json['type'];
    status = json['status'];
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(Products.fromJson(v));
      });
    }
    createdAt = json['createdAt'];
    bannerImage = json['image'] != null ? BannerImage.fromJson(json['image']) : null;
    updatedAt = json['updatedAt'];
    deletedAt = json['deletedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['title'] = title;
    data['type'] = type;
    data['status'] = status;
    if (products != null) {
      data['products'] = products!.map((v) => v.toJson()).toList();
    }
    data['createdAt'] = createdAt;
    if (bannerImage != null) {
      data['image'] = bannerImage!.toJson();
    }
    data['updatedAt'] = updatedAt;
    data['deletedAt'] = deletedAt;
    data['__v'] = iV;
    return data;
  }
}

class Products {
  String? sId;
  String? name;
  String? description;
  String? price;
  String? stock;
  bool? isStockAlwaysAvailable;
  String? productCategory;
  String? company;
  String? address;
  bool? isPreOrder;
  List<String>? varians;
  List<Images>? images;
  // List<Null>? tipeVarian;
  bool? isCompleted;
  bool? status;
  bool? isPromo;
  bool? isRecomendation;
  // Null? member;
  String? verifyAt;
  String? verifyBy;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  int? iV;
  String? promoPrice;

  Products({
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
    // this.member,
    this.verifyAt,
    this.verifyBy,
    this.createdAt,
    this.updatedAt,
    this.iV,
    this.promoPrice,
    this.deletedAt,
  });

  Products.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    description = json['description'];
    price = json['price'];
    stock = json['stock'];
    isStockAlwaysAvailable = json['is_stock_always_available'];
    productCategory = json['productCategory'];
    company = json['company'];
    address = json['address'];
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
    // member = json['member'];
    verifyAt = json['verify_at'];
    verifyBy = json['verify_by'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    deletedAt = json['deletedAt'];
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
    data['address'] = address;
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
    // data['member'] = member;
    data['verify_at'] = verifyAt;
    data['verify_by'] = verifyBy;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['deletedAt'] = deletedAt;
    data['__v'] = iV;
    data['promo_price'] = promoPrice;
    return data;
  }
}

class Images {
  String? sId;
  String? filename;
  String? url;
  bool? primary;
  String? product;
  String? deletedAt;
  int? iV;

  Images({
    this.sId,
    this.filename,
    this.url,
    this.primary,
    this.product,
    this.deletedAt,
    this.iV,
  });

  Images.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    filename = json['filename'];
    url = json['url'];
    primary = json['primary'];
    product = json['product'];
    deletedAt = json['deletedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['filename'] = filename;
    data['url'] = url;
    data['primary'] = primary;
    data['product'] = product;
    data['deletedAt'] = deletedAt;
    data['__v'] = iV;
    return data;
  }
}

class BannerImage {
  String? sId;
  String? filename;
  String? url;
  bool? primary;
  String? banner;
  String? deletedAt;
  int? iV;

  BannerImage({
    this.sId,
    this.filename,
    this.url,
    this.primary,
    this.banner,
    this.deletedAt,
    this.iV,
  });

  BannerImage.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    filename = json['filename'];
    url = json['url'];
    primary = json['primary'];
    banner = json['banner'];
    deletedAt = json['deletedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['filename'] = filename;
    data['url'] = url;
    data['primary'] = primary;
    data['banner'] = banner;
    data['deletedAt'] = deletedAt;
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