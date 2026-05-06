import 'package:dio/dio.dart';
import 'package:utd_store_lintang_sari/features/crypto/domain/models/crypto_model.dart';

class CryptoService {
  final Dio dio; // Gunakan Dio langsung, bukan DioClient

  CryptoService(this.dio);

  Future<List<CryptoModel>> getCrypto() async {
    try {
      // Sekarang langsung panggil dio.get (tanpa .dioClient)
      final response = await dio.get(
        '/coins/markets',
        queryParameters: {
          'vs_currency': 'usd',
        },
      );

      final List data = response.data as List;

      return data.map((e) => CryptoModel.fromJson(e as Map<String, dynamic>)).toList();
      
    } on DioException catch (e) {
      throw Exception('Gagal mengambil data crypto: ${e.message}');
    } catch (e) {
      throw Exception('Terjadi kesalahan: $e');
    }
  }
}