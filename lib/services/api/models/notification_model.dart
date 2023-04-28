class NotificationModel {
  NotificationData? notificationData;

  NotificationModel({
    this.notificationData,
});
}

class NotificationData {
  String type;
  DateTime date;
  String title;
  String? subtitle;
  int? total;

  NotificationData({
    required this.type,
    required this.date,
    required this.title,
    this.subtitle,
    this.total,
  });
}