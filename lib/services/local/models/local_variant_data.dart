import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kenari_app/services/api/models/variant_type_model.dart';

class Subvariant {
  String name;
  bool isSelected;

  Subvariant({
    required this.name,
    required this.isSelected,
  });
}

class SelectedVariant {
  VariantTypeData variantType;
  List<Subvariant> subvariantList;

  SelectedVariant({
    required this.variantType,
    required this.subvariantList,
  });
}

class CompleteVariant {
  String name;
  TextEditingController priceController;
  int price;
  TextEditingController stockController;
  int stock;
  bool isAlwaysAvailable;

  CompleteVariant({
    required this.name,
    required this.priceController,
    required this.price,
    required this.stockController,
    required this.stock,
    required this.isAlwaysAvailable,
  });
}

class UpdateVariantData {
  String name;
  String productCategoryId;
  String description;
  String price;
  String stock;
  bool isAlwaysAvailable;
  bool isPreorder;
  String addressId;
  List items;
  List<XFile> files;

  UpdateVariantData({
    required this.name,
    required this.productCategoryId,
    required this.description,
    required this.price,
    required this.stock,
    required this.isAlwaysAvailable,
    required this.isPreorder,
    required this.addressId,
    required this.items,
    required this.files,
  });
}