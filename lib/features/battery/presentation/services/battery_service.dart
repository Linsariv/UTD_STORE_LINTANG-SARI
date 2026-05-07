// lib/features/battery/presentation/services/battery_service.dart
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';

class BatteryService {
  // 👇 SESUAIKAN CHANNEL dengan yang di MainActivity.kt
  static const MethodChannel _channel = MethodChannel('com.example.utdstore.lintang_sari/battery');

  static Future<int> getBatteryLevel() async {
    try {
      final int batteryLevel = await _channel.invokeMethod('getBatteryLevel');
      return batteryLevel;
    } on PlatformException catch (e) {
      debugPrint("Error getting battery level: ${e.message}");
      return -1;
    }
  }

  static Future<void> showToast(String message) async {
    try {
      await _channel.invokeMethod('showToast', {'message': message});
    } on PlatformException catch (e) {
      debugPrint("Error showing toast: ${e.message}");
    }
  }
}