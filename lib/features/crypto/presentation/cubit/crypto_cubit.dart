import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/services/crypto_service.dart';
import '../../domain/models/crypto_model.dart';
import 'package:utd_store_lintang_sari/core/network/dio_client.dart'; // Pastikan file ini berisi variabel 'dio'

class CryptoCubit extends Cubit<List<CryptoModel>> {
  final CryptoService _service;

  // Gunakan variabel 'dio' global yang sudah kamu buat sebelumnya
  CryptoCubit()
      : _service = CryptoService(dio), 
        super([]);

  Future<void> fetchCrypto() async {
    try {
      final data = await _service.getCrypto();
      emit(data);
    } catch (e) {
      // Sebaiknya tambahkan state Error, tapi untuk sementara emit list kosong
      emit([]);
    }
  }
}