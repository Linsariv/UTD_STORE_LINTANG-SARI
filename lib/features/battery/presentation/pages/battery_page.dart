import 'package:flutter/material.dart';
import '../services/battery_service.dart';

class BatteryPage extends StatefulWidget {
  const BatteryPage({super.key});

  @override
  State<BatteryPage> createState() => _BatteryPageState();
}

class _BatteryPageState extends State<BatteryPage> {
  int _batteryLevel = -1;
  bool _isLoading = false;

  Future<void> _checkBattery() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final battery = await BatteryService.getBatteryLevel();
      
      // ✅ TAMBAHKAN mounted CHECK
      if (!mounted) return;
      
      setState(() {
        _batteryLevel = battery;
      });

      // Tampilkan native toast
      if (battery != -1) {
        await BatteryService.showToast('Baterai tersisa $battery%');
      } else {
        await BatteryService.showToast('Gagal membaca baterai');
      }
    } catch (e) {
      // ✅ TAMBAHKAN mounted CHECK
      if (!mounted) return;
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e'), backgroundColor: Colors.red),
      );
    } finally {
      // ✅ TAMBAHKAN mounted CHECK
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Baterai & Native Toast'),
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Icon baterai
              Icon(
                _batteryLevel >= 75
                    ? Icons.battery_full
                    : _batteryLevel >= 50
                        ? Icons.battery_6_bar
                        : _batteryLevel >= 20
                            ? Icons.battery_3_bar
                            : Icons.battery_alert,
                size: 80,
                color: _batteryLevel >= 20 ? Colors.green : Colors.red,
              ),
              
              const SizedBox(height: 24),
              
              // Persentase baterai
              if (_batteryLevel != -1) ...[
                Text(
                  '$_batteryLevel%',
                  style: const TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Sisa daya baterai HP Anda',
                  style: TextStyle(color: Colors.grey.shade600),
                ),
              ],
              
              if (_batteryLevel == -1 && !_isLoading) ...[
                const Text(
                  'Tekan tombol di bawah untuk membaca baterai',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey),
                ),
              ],
              
              if (_isLoading)
                const Padding(
                  padding: EdgeInsets.all(32.0),
                  child: CircularProgressIndicator(),
                ),
              
              const SizedBox(height: 48),
              
              // Tombol cek baterai
              ElevatedButton.icon(
                onPressed: _isLoading ? null : _checkBattery,
                icon: const Icon(Icons.battery_6_bar),
                label: const Text('Cek Baterai & Tampilkan Toast'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  minimumSize: const Size(double.infinity, 50),
                ),
              ),
              
              const SizedBox(height: 16),
              
              // Informasi
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    const Text(
                      '🔋 Native Feature',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '• Membaca baterai via MethodChannel (Kotlin native)\n'
                      '• Menampilkan Toast native Android\n'
                      '• Platform Channel - No 5 UTS',
                      style: TextStyle(color: Colors.grey.shade700, fontSize: 12),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}