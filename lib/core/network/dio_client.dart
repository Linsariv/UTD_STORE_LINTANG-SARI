import 'package:dio/dio.dart';
import 'package:utd_store_lintang_sari/core/network/dio_interceptor.dart';

// Buat fungsi penyedia Dio
Dio createDio() {
  final dio = Dio(
    BaseOptions(
      baseUrl: 'https://api.coingecko.com/api/v3/',
      connectTimeout: const Duration(seconds: 5), // Bonus: tambahkan timeout agar tidak kuning
      receiveTimeout: const Duration(seconds: 3),
    ),
  );

  // Tambahkan interceptor secara terpisah
  dio.interceptors.add(DioInterceptor());

  return dio;
}

// Inisialisasi variabel
final Dio dio = createDio();