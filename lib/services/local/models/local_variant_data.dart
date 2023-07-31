import 'package:flutter/material.dart';
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