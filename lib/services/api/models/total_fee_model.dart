class TotalFeeModel {
  int? status;
  TotalFeeData? totalFeeData;

  TotalFeeModel({this.status, this.totalFeeData});

  TotalFeeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    totalFeeData = json['data'] != null ? TotalFeeData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (totalFeeData != null) {
      data['data'] = totalFeeData!.toJson();
    }
    return data;
  }
}

class TotalFeeData {
  int? totalIuranWajib;
  int? totalIuranBerjangka;

  TotalFeeData({this.totalIuranWajib, this.totalIuranBerjangka});

  TotalFeeData.fromJson(Map<String, dynamic> json) {
    totalIuranWajib = json['total_iuran_wajib'];
    totalIuranBerjangka = json['total_iuran_berjangka'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total_iuran_wajib'] = totalIuranWajib;
    data['total_iuran_berjangka'] = totalIuranBerjangka;
    return data;
  }
}