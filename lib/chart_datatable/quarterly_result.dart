class QuarterlyResult {
  DateTime dateAnnounced;
  DateTime financialYearEnd;
  int quarter;
  DateTime quarterEnd;
  int quarterProfit;
  int quarterRevenue;

  QuarterlyResult({
    this.dateAnnounced,
    this.financialYearEnd,
    this.quarter,
    this.quarterEnd,
    this.quarterProfit,
    this.quarterRevenue,
  });

  QuarterlyResult.fromJson(Map<String, dynamic> json) {
    dateAnnounced = json['dateAnnounced'] != null
        ? DateTime.parse(json['dateAnnounced'])
        : null;
    financialYearEnd = json['financialYearEnd'] != null
        ? DateTime.parse(json['financialYearEnd'])
        : null;
    quarter = json['quarter'];
    quarterEnd =
        json['quarterEnd'] != null ? DateTime.parse(json['quarterEnd']) : null;
    quarterProfit = json['quarterProfit'];
    quarterRevenue = json['quarterRevenue'];
  }

  Map toJson() {
    final data = {};
    data['dateAnnounced'] = dateAnnounced?.toString();
    data['financialYearEnd'] = financialYearEnd?.toString();
    data['quarter'] = quarter;
    data['quarterEnd'] = quarterEnd?.toString();
    data['quarterProfit'] = quarterProfit;
    data['quarterRevenue'] = quarterRevenue;
    return data;
  }
}
