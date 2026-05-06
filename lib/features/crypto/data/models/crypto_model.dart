class CryptoModel {
  final String name;
  final String symbol;
  final double price;
  final String image;

  CryptoModel({
    required this.name,
    required this.symbol,
    required this.price,
    required this.image,
  });

  factory CryptoModel.fromJson(Map<String, dynamic> json) {
    return CryptoModel(
      name: json['name'] ?? '',
      symbol: json['symbol'] ?? '',
      price: (json['current_price'] as num).toDouble(),
      image: json['image'] ?? '',
    );
  }
}