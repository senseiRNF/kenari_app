class LoanModel {
  int? status;
  List<LoanData>? loanData;

  LoanModel({this.status, this.loanData});

  LoanModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      loanData = <LoanData>[];
      json['data'].forEach((v) {
        loanData!.add(LoanData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (loanData != null) {
      data['data'] = loanData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LoanData {
  String? sId;
  String? jumlahPinjamanPengajuan;
  String? biayaAdminPersen;
  String? biayaAdminAmount;
  String? jumlahPinjamanDiterima;
  String? pokokBulanan;
  String? bungaBulanan;
  String? bayarBulanan;
  String? jangkaWaktu;
  String? jatuhTempo;
  Member? member;
  List<PeminjamanDetails>? peminjamanDetails;
  bool? status;
  String? createdAt;
  String? updatedAt;
  int? iV;

  LoanData({
    this.sId,
    this.jumlahPinjamanPengajuan,
    this.biayaAdminPersen,
    this.biayaAdminAmount,
    this.jumlahPinjamanDiterima,
    this.pokokBulanan,
    this.bungaBulanan,
    this.bayarBulanan,
    this.jangkaWaktu,
    this.jatuhTempo,
    this.member,
    this.peminjamanDetails,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.iV,
  });

  LoanData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    jumlahPinjamanPengajuan = json['jumlah_pinjaman_pengajuan'];
    biayaAdminPersen = json['biaya_admin_persen'];
    biayaAdminAmount = json['biaya_admin_amount'];
    jumlahPinjamanDiterima = json['jumlah_pinjaman_diterima'];
    pokokBulanan = json['pokok_bulanan'];
    bungaBulanan = json['bunga_bulanan'];
    bayarBulanan = json['bayar_bulanan'];
    jangkaWaktu = json['jangka_waktu'];
    jatuhTempo = json['jatuh_tempo'];
    member =
    json['member'] != null ? Member.fromJson(json['member']) : null;
    if (json['peminjamanDetails'] != null) {
      peminjamanDetails = <PeminjamanDetails>[];
      json['peminjamanDetails'].forEach((v) {
        peminjamanDetails!.add(PeminjamanDetails.fromJson(v));
      });
    }
    status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['jumlah_pinjaman_pengajuan'] = jumlahPinjamanPengajuan;
    data['biaya_admin_persen'] = biayaAdminPersen;
    data['biaya_admin_amount'] = biayaAdminAmount;
    data['jumlah_pinjaman_diterima'] = jumlahPinjamanDiterima;
    data['pokok_bulanan'] = pokokBulanan;
    data['bunga_bulanan'] = bungaBulanan;
    data['bayar_bulanan'] = bayarBulanan;
    data['jangka_waktu'] = jangkaWaktu;
    data['jatuh_tempo'] = jatuhTempo;
    if (member != null) {
      data['member'] = member!.toJson();
    }
    if (peminjamanDetails != null) {
      data['peminjamanDetails'] =
          peminjamanDetails!.map((v) => v.toJson()).toList();
    }
    data['status'] = status;
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
  List<String>? members;
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
    members = json['members'].cast<String>();
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
    data['members'] = members;
    data['addresses'] = addresses;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    data['phone'] = phone;
    return data;
  }
}

class PeminjamanDetails {
  String? sId;
  String? sequencePinjaman;
  String? jumlahBayar;
  String? jatuhTempo;
  bool? status;
  String? peminjaman;
  String? createdAt;
  String? updatedAt;
  int? iV;

  PeminjamanDetails({
    this.sId,
    this.sequencePinjaman,
    this.jumlahBayar,
    this.jatuhTempo,
    this.status,
    this.peminjaman,
    this.createdAt,
    this.updatedAt,
    this.iV,
  });

  PeminjamanDetails.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    sequencePinjaman = json['sequence_pinjaman'];
    jumlahBayar = json['jumlah_bayar'];
    jatuhTempo = json['jatuh_tempo'];
    status = json['status'];
    peminjaman = json['peminjaman'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['sequence_pinjaman'] = sequencePinjaman;
    data['jumlah_bayar'] = jumlahBayar;
    data['jatuh_tempo'] = jatuhTempo;
    data['status'] = status;
    data['peminjaman'] = peminjaman;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}