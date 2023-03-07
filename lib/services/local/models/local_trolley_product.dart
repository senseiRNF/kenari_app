import 'package:kenari_app/services/local/models/local_product_data.dart';

class LocalTrolleyProduct {
  bool isSelected;
  LocalProductData productData;
  int qty;

  LocalTrolleyProduct({
    required this.isSelected,
    required this.productData,
    required this.qty,
  });
}