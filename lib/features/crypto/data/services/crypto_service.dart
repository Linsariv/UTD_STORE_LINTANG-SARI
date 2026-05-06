import 'package:dio/dio.dart';
import '../../domain/models/crypto_model.dart';

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
}