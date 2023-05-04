class TransactionOrderModel {
  int? status;
  List<TransactionOrderData>? transactionOrderData;

  TransactionOrderModel({this.status, this.transactionOrderData});

  TransactionOrderModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      transactionOrderData = <TransactionOrderData>[];
      json['data'].forEach((v) {
        transactionOrderData!.add(TransactionOrderData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (transactionOrderData != null) {
      data['data'] = transactionOrderData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TransactionOrderData {
  String? sId;
  String? transactionNo;
  String? paymentMethod;
  String? status;
  Member? member;
  Address? address;
  List<OrderDetails>? orderDetails;
  String? transactionDate;
  String? totalAmount;
  String? createdAt;
  String? updatedAt;
  int? iV;
  String? cancelledDate;

  TransactionOrderData({
    this.sId,
    this.transactionNo,
    this.paymentMethod,
    this.status,
    this.member,
    this.address,
    this.orderDetails,
    this.transactionDate,
    this.totalAmount,
    this.createdAt,
    this.updatedAt,
    this.iV,
    this.cancelledDate,
  });

  TransactionOrderData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    transactionNo = json['transaction_no'];
    paymentMethod = json['payment_method'];
    status = json['status'];
    member =
    json['member'] != null ? Member.fromJson(json['member']) : null;
    address =
    json['address'] != null ? Address.fromJson(json['address']) : null;
    if (json['orderDetails'] != null) {
      orderDetails = <OrderDetails>[];
      json['orderDetails'].forEach((v) {
        orderDetails!.add(OrderDetails.fromJson(v));
      });
    }
    transactionDate = json['transaction_date'];
    totalAmount = json['total_amount'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    cancelledDate = json['cancelled_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['transaction_no'] = transactionNo;
    data['payment_method'] = paymentMethod;
    data['status'] = status;
    if (member != null) {
      data['member'] = member!.toJson();
    }
    if (address != null) {
      data['address'] = address!.toJson();
    }
    if (orderDetails != null) {
      data['orderDetails'] = orderDetails!.map((v) => v.toJson()).toList();
    }
    data['transaction_date'] = transactionDate;
    data['total_amount'] = totalAmount;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    data['cancelled_date'] = cancelledDate;
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

class OrderDetails {
  String? sId;
  String? price;
  String? varianName;
  String? varian;
  Product? product;
  String? order;
  String? qty;
  String? subTotal;
  String? totalDiscount;
  String? total;
  String? createdAt;
  String? updatedAt;
  int? iV;

  OrderDetails({
    this.sId,
    this.price,
    this.varianName,
    this.varian,
    this.product,
    this.order,
    this.qty,
    this.subTotal,
    this.totalDiscount,
    this.total,
    this.createdAt,
    this.updatedAt,
    this.iV,
  });

  OrderDetails.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    price = json['price'];
    varianName = json['varian_name'];
    varian = json['varian'];
    product =
    json['product'] != null ? Product.fromJson(json['product']) : null;
    order = json['order'];
    qty = json['qty'];
    subTotal = json['sub_total'];
    totalDiscount = json['total_discount'];
    total = json['total'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['price'] = price;
    data['varian_name'] = varianName;
    data['varian'] = varian;
    if (product != null) {
      data['product'] = product!.toJson();
    }
    data['order'] = order;
    data['qty'] = qty;
    data['sub_total'] = subTotal;
    data['total_discount'] = totalDiscount;
    data['total'] = total;
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
  String? address;
  bool? isPreOrder;
  List<Varians>? varians;
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
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    data['promo_price'] = promoPrice;
    return data;
  }
}

class Varians {
  String? sId;
  String? price;
  String? name1;
  String? name2;
  String? stock;
  bool? isStockAlwaysAvailable;
  String? varianType1;
  String? varianType2;
  String? createdAt;
  String? updatedAt;
  int? iV;
  String? promoPrice;
  bool? isPromo;

  Varians({
    this.sId,
    this.price,
    this.name1,
    this.name2,
    this.stock,
    this.isStockAlwaysAvailable,
    this.varianType1,
    this.varianType2,
    this.createdAt,
    this.updatedAt,
    this.iV,
    this.promoPrice,
    this.isPromo,
  });

  Varians.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    price = json['price'];
    name1 = json['name1'];
    name2 = json['name2'];
    stock = json['stock'];
    isStockAlwaysAvailable = json['is_stock_always_available'];
    varianType1 = json['varianType1'];
    varianType2 = json['varianType2'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    promoPrice = json['promo_price'];
    isPromo = json['is_promo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['price'] = price;
    data['name1'] = name1;
    data['name2'] = name2;
    data['stock'] = stock;
    data['is_stock_always_available'] = isStockAlwaysAvailable;
    data['varianType1'] = varianType1;
    data['varianType2'] = varianType2;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    data['promo_price'] = promoPrice;
    data['is_promo'] = isPromo;
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