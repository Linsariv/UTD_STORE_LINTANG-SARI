// lib/features/crypto/domain/models/crypto_model.dart
class CryptoModel {
  final String? name;
  final String? symbol;
  final double? currentPrice;
  final int? marketCapRank;

  CryptoModel({
    this.name,
    this.symbol,
    this.currentPrice,
    this.marketCapRank,
  });

  factory CryptoModel.fromJson(Map<String, dynamic> json) {
    return CryptoModel(
      name: json['name'],
      symbol: json['symbol'],
      currentPrice: (json['current_price'] as num?)?.toDouble(),
      marketCapRank: json['market_cap_rank'],
    );
  }
}