class LocalTemporalFeeData {
  String? memberId;
  int amount;
  int period;
  double profit;
  DateTime startDate;
  DateTime disbursementDate;
  String paymentMethod;

  LocalTemporalFeeData({
    required this.memberId,
    required this.amount,
    required this.period,
    required this.profit,
    required this.startDate,
    required this.disbursementDate,
    required this.paymentMethod,
  });
}