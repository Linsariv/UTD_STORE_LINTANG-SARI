import 'package:dio/dio.dart';
import 'package:utd_store_lintang_sari/core/network/dio_client.dart';
import 'package:utd_store_lintang_sari/features/crypto/domain/models/crypto_model.dart';

class CryptoService {
  Future<List<CryptoModel>> getCrypto() async {
    final response = await dio.get(
      '/coins/markets',
      queryParameters: {
        'vs_currency': 'usd',
      },
    );

    final List data = response.data;

    return data.map((e) => CryptoModel.fromJson(e)).toList();
  }
}