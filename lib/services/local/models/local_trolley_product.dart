import 'package:kenari_app/services/api/models/product_model.dart';

class LocalTrolleyProduct {
  bool isSelected;
  ProductData productData;
  int qty;

  LocalTrolleyProduct({
    required this.isSelected,
    required this.productData,
    required this.qty,
  });
}