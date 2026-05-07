// lib/features/crypto/domain/services/crypto_tax_service.dart
import 'package:flutter/foundation.dart';

class CryptoTaxService {
  static Future<int> calculateTaxInBackground(int loopCount) async {
    return await compute(_heavyCalculation, loopCount);
  }

  static int _heavyCalculation(int count) {
    int sum = 0;
    for (int i = 0; i < count; i++) {
      sum += i;
    }
    return sum;
  }
}