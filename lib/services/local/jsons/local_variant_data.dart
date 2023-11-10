import 'package:flutter/material.dart';

class LocalTypeVariant {
  String typeVariantId;
  String typeVariantName;
  List<LocalVariantData> variantData;

  LocalTypeVariant({
    required this.typeVariantId,
    required this.typeVariantName,
    required this.variantData,
  });
}

class LocalVariantData {
  String? variantId;
  String name;
  int price;
  int stock;
  bool isAlwaysAvailable;

  LocalVariantData({
    this.variantId,
    required this.name,
    required this.price,
    required this.stock,
    required this.isAlwaysAvailable,
  });
}

class LocalSubVariantData {
  LocalVariantData variantData;
  TextEditingController priceController;
  TextEditingController stockController;

  LocalSubVariantData({
    required this.variantData,
    required this.priceController,
    required this.stockController,
  });
}