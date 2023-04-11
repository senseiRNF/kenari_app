class LocalLoanData {
  String? memberId;
  double submissionAmount;
  double adminFeePercentage;
  double monthlyInterestPercentage;
  int period;

  LocalLoanData({
    required this.memberId,
    required this.submissionAmount,
    required this.adminFeePercentage,
    required this.monthlyInterestPercentage,
    required this.period,
  });
}