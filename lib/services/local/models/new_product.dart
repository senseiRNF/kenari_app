class NewProduct {
  String type;
  String name;
  List<String>? variant;
  List<int> price;
  List<int> stock;
  List<String?> imagePath;

  NewProduct({
    required this.type,
    required this.name,
    this.variant,
    required this.price,
    required this.stock,
    required this.imagePath,
  });
}