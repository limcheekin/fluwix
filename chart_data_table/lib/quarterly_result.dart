class QuarterlyResult {
  DateTime dateAnnounced;
  DateTime financialYearEnd;
  int quarter;
  DateTime quarterEnd;
  int quarterProfit;
  int quarterRevenue;

  QuarterlyResult({
    required this.dateAnnounced,
    required this.financialYearEnd,
    required this.quarter,
    required this.quarterEnd,
    required this.quarterProfit,
    required this.quarterRevenue,
  });

  double get quarterProfitMargin {
    return quarterProfit / quarterRevenue;
  }

  static QuarterlyResult fromJson(Map<String, dynamic> json) {
    final nullDate = DateTime.utc(1970, 1, 1);
    return QuarterlyResult(
        dateAnnounced: json['dateAnnounced'] != null
            ? DateTime.parse(json['dateAnnounced'])
            : nullDate,
        financialYearEnd: json['financialYearEnd'] != null
            ? DateTime.parse(json['financialYearEnd'])
            : nullDate,
        quarter: json['quarter'] ?? 0,
        quarterEnd: json['quarterEnd'] != null
            ? DateTime.parse(json['quarterEnd'])
            : nullDate,
        quarterProfit: json['quarterProfit'] ?? 0,
        quarterRevenue: json['quarterRevenue'] ?? 0);
  }

  Map toJson() {
    final data = {};
    data['dateAnnounced'] = dateAnnounced.toString();
    data['financialYearEnd'] = financialYearEnd.toString();
    data['quarter'] = quarter;
    data['quarterEnd'] = quarterEnd.toString();
    data['quarterProfit'] = quarterProfit;
    data['quarterRevenue'] = quarterRevenue;
    return data;
  }
}
