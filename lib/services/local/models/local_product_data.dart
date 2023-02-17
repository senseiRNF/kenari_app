class LocalProductData {
  String type;
  String name;
  List<String>? variant;
  List<int> normalPrice;
  List<int> discountPrice;
  List<int> stock;
  List<String?> imagePath;

  LocalProductData({
    required this.type,
    required this.name,
    this.variant,
    required this.normalPrice,
    required this.discountPrice,
    required this.stock,
    required this.imagePath,
  });
}