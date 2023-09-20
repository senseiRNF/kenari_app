class NotificationModel {
  int? status;
  List<NotificationData>? notificationData;

  NotificationModel({this.status, this.notificationData});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      notificationData = <NotificationData>[];
      json['data'].forEach((v) {
        notificationData!.add(NotificationData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (notificationData != null) {
      data['data'] = notificationData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class NotificationData {
  String? sId;
  String? menu;
  String? model;
  String? parent;
  String? member;
  String? title;
  String? content;
  String? type;
  String? deletedAt;
  String? createdAt;
  String? openAt;
  String? updatedAt;
  int? iV;

  NotificationData({
    this.sId,
    this.menu,
    this.model,
    this.parent,
    this.member,
    this.title,
    this.content,
    this.type,
    this.deletedAt,
    this.createdAt,
    this.openAt,
    this.updatedAt,
    this.iV,
  });

  NotificationData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    menu = json['menu'];
    model = json['model'];
    parent = json['parent'];
    member = json['member'];
    title = json['title'];
    content = json['content'];
    type = json['type'];
    deletedAt = json['deletedAt'];
    createdAt = json['createdAt'];
    openAt = json['openAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['menu'] = menu;
    data['model'] = model;
    data['parent'] = parent;
    data['member'] = member;
    data['title'] = title;
    data['content'] = content;
    data['type'] = type;
    data['deletedAt'] = deletedAt;
    data['createdAt'] = createdAt;
    data['openAt'] = openAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}