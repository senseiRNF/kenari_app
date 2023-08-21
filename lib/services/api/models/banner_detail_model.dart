class BannerDetailModel {
  int? status;
  BannerDetailData? bannerDetailData;

  BannerDetailModel({this.status, this.bannerDetailData});

  BannerDetailModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    bannerDetailData = json['data'] != null ? BannerDetailData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (bannerDetailData != null) {
      data['data'] = bannerDetailData!.toJson();
    }
    return data;
  }
}

class BannerDetailData {
  String? sId;
  String? title;
  String? type;
  String? textAnnouncement;
  bool? status;
  List<Products>? products;
  String? createdAt;
  BannerDetailImage? bannerDetailImage;
  String? updatedAt;
  String? deletedAt;
  int? iV;

  BannerDetailData({
    this.sId,
    this.title,
    this.type,
    this.textAnnouncement,
    this.status,
    this.products,
    this.createdAt,
    this.bannerDetailImage,
    this.updatedAt,
    this.deletedAt,
    this.iV,
  });

  BannerDetailData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    type = json['type'];
    textAnnouncement = json['text_announcement'];
    status = json['status'];
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(Products.fromJson(v));
      });
    }
    createdAt = json['createdAt'];
    bannerDetailImage = json['image'] != null ? BannerDetailImage.fromJson(json['image']) : null;
    updatedAt = json['updatedAt'];
    deletedAt = json['deletedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['title'] = title;
    data['type'] = type;
    data['text_announcement'] = textAnnouncement;
    data['status'] = status;
    if (products != null) {
      data['products'] = products!.map((v) => v.toJson()).toList();
    }
    data['createdAt'] = createdAt;
    if (bannerDetailImage != null) {
      data['image'] = bannerDetailImage!.toJson();
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
  List<Varians>? varians;
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
  int? totalDiscount;
  int? totalSell;

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
    this.deletedAt,
    this.iV,
    this.promoPrice,
    this.totalDiscount,
    this.totalSell,
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
    // member = json['member'];
    verifyAt = json['verify_at'];
    verifyBy = json['verify_by'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    deletedAt = json['deletedAt'];
    iV = json['__v'];
    promoPrice = json['promo_price'];
    totalDiscount = json['total_discount'];
    totalSell = json['total_sell'];
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
    // data['member'] = member;
    data['verify_at'] = verifyAt;
    data['verify_by'] = verifyBy;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['deletedAt'] = deletedAt;
    data['__v'] = iV;
    data['promo_price'] = promoPrice;
    data['total_discount'] = totalDiscount;
    data['total_sell'] = totalSell;
    return data;
  }
}

// class ProductCategory {
//   String? sId;
//   String? name;
//   bool? status;
//   String? createdAt;
//   int? iV;
//   String? updatedAt;
//
//   ProductCategory({
//     this.sId,
//     this.name,
//     this.status,
//     this.createdAt,
//     this.iV,
//     this.updatedAt,
//   });
//
//   ProductCategory.fromJson(Map<String, dynamic> json) {
//     sId = json['_id'];
//     name = json['name'];
//     status = json['status'];
//     createdAt = json['createdAt'];
//     iV = json['__v'];
//     updatedAt = json['updatedAt'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['_id'] = sId;
//     data['name'] = name;
//     data['status'] = status;
//     data['createdAt'] = createdAt;
//     data['__v'] = iV;
//     data['updatedAt'] = updatedAt;
//     return data;
//   }
// }

class Varians {
  String? sId;
  bool? isPromo;
  String? deletedAt;
  String? createdAt;
  String? price;
  String? stock;
  bool? isStockAlwaysAvailable;
  String? varianType1;
  String? name1;
  String? promoPrice;
  String? updatedAt;
  int? iV;

  Varians({
    this.sId,
    this.isPromo,
    this.deletedAt,
    this.createdAt,
    this.price,
    this.stock,
    this.isStockAlwaysAvailable,
    this.varianType1,
    this.name1,
    this.promoPrice,
    this.updatedAt,
    this.iV,
  });

  Varians.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    isPromo = json['is_promo'];
    deletedAt = json['deletedAt'];
    createdAt = json['createdAt'];
    price = json['price'];
    stock = json['stock'];
    isStockAlwaysAvailable = json['is_stock_always_available'];
    varianType1 = json['varianType1'];
    name1 = json['name1'];
    promoPrice = json['promo_price'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['is_promo'] = isPromo;
    data['deletedAt'] = deletedAt;
    data['createdAt'] = createdAt;
    data['price'] = price;
    data['stock'] = stock;
    data['is_stock_always_available'] = isStockAlwaysAvailable;
    data['varianType1'] = varianType1;
    data['name1'] = name1;
    data['promo_price'] = promoPrice;
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

class BannerDetailImage {
  String? sId;
  String? filename;
  String? url;
  bool? primary;
  String? deletedAt;
  int? iV;

  BannerDetailImage({
    this.sId,
    this.filename,
    this.url,
    this.primary,
    this.deletedAt,
    this.iV,
  });

  BannerDetailImage.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    filename = json['filename'];
    url = json['url'];
    primary = json['primary'];
    deletedAt = json['deletedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['filename'] = filename;
    data['url'] = url;
    data['primary'] = primary;
    data['deletedAt'] = deletedAt;
    data['__v'] = iV;
    return data;
  }
}