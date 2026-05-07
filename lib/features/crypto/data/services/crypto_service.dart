import 'package:dio/dio.dart';
import '../../domain/models/crypto_model.dart';
import 'package:utd_store_lintang_sari/features/crypto/domain/services/crypto_tax_service.dart';

class CryptoService {
  final Dio dio;

  CryptoService(this.dio);

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

  Future<int> calculateTax() async {
    // GANTI dengan 2 digit terakhir NIM Anda!
    // Contoh NIM: 2022001234 → 34
    final int twoDigitNim = 34; // 👈 GANTI INI!
    
    final int loopCount = twoDigitNim * 10000000;
    
    final result = await CryptoTaxService.calculateTaxInBackground(loopCount);
    
    return result;
  }
}