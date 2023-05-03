import 'package:kenari_app/services/api/models/trolley_model.dart';

class LocalTrolleyProduct {
  bool isSelected;
  TrolleyData trolleyData;
  int qty;
  bool? canBeUpdated;

  LocalTrolleyProduct({
    required this.isSelected,
    required this.trolleyData,
    required this.qty,
    this.canBeUpdated,
  });
}