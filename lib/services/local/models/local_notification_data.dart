class LocalNotificationData {
  String type;
  DateTime date;
  String title;
  String? subtitle;
  int? total;

  LocalNotificationData({
    required this.type,
    required this.date,
    required this.title,
    this.subtitle,
    this.total,
  });
}