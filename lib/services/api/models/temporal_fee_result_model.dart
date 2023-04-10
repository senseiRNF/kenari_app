class TemporalFeeResultModel {
  int? status;
  String? message;
  TemporalFeeResultData? temporalFeeResultData;

  TemporalFeeResultModel({this.status, this.message, this.temporalFeeResultData});

  TemporalFeeResultModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    temporalFeeResultData = json['data'] != null ? TemporalFeeResultData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (temporalFeeResultData != null) {
      data['data'] = temporalFeeResultData!.toJson();
    }
    return data;
  }
}

class TemporalFeeResultData {
  String? jumlahIuran;
  String? jangkaWaktu;
  String? imbalHasil;
  String? tanggalMulai;
  String? tanggalPencairan;
  String? metodePembayaran;
  String? saldoAkhir;
  String? pertumbuhanSaldo;
  Member? member;
  bool? statusPencairan;
  String? sId;
  String? createdAt;
  String? updatedAt;
  int? iV;

  TemporalFeeResultData({
    this.jumlahIuran,
    this.jangkaWaktu,
    this.imbalHasil,
    this.tanggalMulai,
    this.tanggalPencairan,
    this.metodePembayaran,
    this.saldoAkhir,
    this.pertumbuhanSaldo,
    this.member,
    this.statusPencairan,
    this.sId,
    this.createdAt,
    this.updatedAt,
    this.iV,
  });

  TemporalFeeResultData.fromJson(Map<String, dynamic> json) {
    jumlahIuran = json['jumlah_iuran'];
    jangkaWaktu = json['jangka_waktu'];
    imbalHasil = json['imbal_hasil'];
    tanggalMulai = json['tanggal_mulai'];
    tanggalPencairan = json['tanggal_pencairan'];
    metodePembayaran = json['metode_pembayaran'];
    saldoAkhir = json['saldo_akhir'];
    pertumbuhanSaldo = json['pertumbuhan_saldo'];
    member =
    json['member'] != null ? Member.fromJson(json['member']) : null;
    statusPencairan = json['status_pencairan'];
    sId = json['_id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['jumlah_iuran'] = jumlahIuran;
    data['jangka_waktu'] = jangkaWaktu;
    data['imbal_hasil'] = imbalHasil;
    data['tanggal_mulai'] = tanggalMulai;
    data['tanggal_pencairan'] = tanggalPencairan;
    data['metode_pembayaran'] = metodePembayaran;
    data['saldo_akhir'] = saldoAkhir;
    data['pertumbuhan_saldo'] = pertumbuhanSaldo;
    if (member != null) {
      data['member'] = member!.toJson();
    }
    data['status_pencairan'] = statusPencairan;
    data['_id'] = sId;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}

class Member {
  String? sId;
  String? name;
  String? phoneNumber;
  String? email;
  String? password;
  String? status;
  String? company;
  String? user;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Member({
    this.sId,
    this.name,
    this.phoneNumber,
    this.email,
    this.password,
    this.status,
    this.company,
    this.user,
    this.createdAt,
    this.updatedAt,
    this.iV,
  });

  Member.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    phoneNumber = json['phone_number'];
    email = json['email'];
    password = json['password'];
    status = json['status'];
    company = json['company'];
    user = json['user'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    data['phone_number'] = phoneNumber;
    data['email'] = email;
    data['password'] = password;
    data['status'] = status;
    data['company'] = company;
    data['user'] = user;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}