class TemporalFeeModel {
  int? status;
  List<TemporalFeeData>? temporalFeeData;

  TemporalFeeModel({this.status, this.temporalFeeData});

  TemporalFeeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      temporalFeeData = <TemporalFeeData>[];
      json['data'].forEach((v) {
        temporalFeeData!.add(TemporalFeeData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (temporalFeeData != null) {
      data['data'] = temporalFeeData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TemporalFeeData {
  String? sId;
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
  String? createdAt;
  String? updatedAt;
  int? iV;

  TemporalFeeData({
    this.sId,
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
    this.createdAt,
    this.updatedAt,
    this.iV,
  });

  TemporalFeeData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
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
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
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
  Company? company;
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
    company =
    json['company'] != null ? Company.fromJson(json['company']) : null;
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
    if (company != null) {
      data['company'] = company!.toJson();
    }
    data['user'] = user;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}

class Company {
  String? sId;
  String? name;
  String? code;
  String? totalMember;
  bool? status;
  List<Members>? members;
  List<String>? addresses;
  String? createdAt;
  String? updatedAt;
  int? iV;
  String? phone;

  Company({
    this.sId,
    this.name,
    this.code,
    this.totalMember,
    this.status,
    this.members,
    this.addresses,
    this.createdAt,
    this.updatedAt,
    this.iV,
    this.phone,
  });

  Company.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    code = json['code'];
    totalMember = json['total_member'];
    status = json['status'];
    if (json['members'] != null) {
      members = <Members>[];
      json['members'].forEach((v) {
        members!.add(Members.fromJson(v));
      });
    }
    addresses = json['addresses'].cast<String>();
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    data['code'] = code;
    data['total_member'] = totalMember;
    data['status'] = status;
    if (members != null) {
      data['members'] = members!.map((v) => v.toJson()).toList();
    }
    data['addresses'] = addresses;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    data['phone'] = phone;
    return data;
  }
}

class Members {
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

  Members({
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

  Members.fromJson(Map<String, dynamic> json) {
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