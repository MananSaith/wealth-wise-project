class ChartData {
  final List<List<double>> prices;

  ChartData({required this.prices});

  factory ChartData.fromJson(Map<String, dynamic> json) {
    List<List<double>> parsedPrices =
    (json['prices'] as List).map<List<double>>((e) => [e[0].toDouble(), e[1].toDouble()]).toList();
    return ChartData(prices: parsedPrices);
  }
}
