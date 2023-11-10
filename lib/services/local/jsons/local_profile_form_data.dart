import 'package:image_picker/image_picker.dart';

class MediaProfileData {
  String? url;
  String? sId;
  XFile? xFile;

  MediaProfileData({
    this.url,
    this.sId,
    this.xFile,
  });
}

class LocalProfileFormData {
  String? name;
  String? email;
  String? phone;
  MediaProfileData? profileImage;

  LocalProfileFormData({
    this.name,
    this.email,
    this.phone,
    this.profileImage,
  });
}