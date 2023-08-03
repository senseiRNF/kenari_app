import 'package:image_picker/image_picker.dart';

class MediaProductData {
  String? url;
  String? sId;
  XFile? xFile;

  MediaProductData({
    this.url,
    this.sId,
    this.xFile,
  });
}

class FormSellerProductData {
  String name;
  String productCategoryId;
  String description;
  String price;
  String stock;
  bool isAlwaysAvailable;
  bool isPreorder;
  String addressId;
  List items;
  List<MediaProductData> files;

  FormSellerProductData({
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