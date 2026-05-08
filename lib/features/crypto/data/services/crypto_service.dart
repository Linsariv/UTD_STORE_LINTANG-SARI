import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../../domain/models/crypto_model.dart';
import '../../domain/services/crypto_tax_service.dart';

class CryptoService {
  final Dio dio;

  CryptoService(this.dio);

  // Get list of cryptocurrencies
  Future<List<CryptoModel>> getCrypto() async {
    final response = await dio.get(
      'https://api.coingecko.com/api/v3/coins/markets',
      queryParameters: {
        'vs_currency': 'usd',
      },
    );

    final List data = response.data;
    return data
        .map((e) => CryptoModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  // Get single Bitcoin price (for fallback polling)
  Future<double> getBitcoinPrice() async {
    try {
      final response = await dio.get(
        'https://api.coingecko.com/api/v3/simple/price',
        queryParameters: {
          'ids': 'bitcoin',
          'vs_currencies': 'usd',
        },
      );
      return response.data['bitcoin']['usd'].toDouble();
    } catch (e) {
      debugPrint('Error fetching bitcoin price: $e');
      return 0.0;
    }
  }

  // Calculate tax with Isolate
  Future<int> calculateTax() async {
    final int twoDigitNim = 12; // Ganti dengan 2 digit terakhir NIM Anda
    final int loopCount = twoDigitNim * 10000000;
    
    final result = await CryptoTaxService.calculateTaxInBackground(loopCount);
    return result;
  }
}