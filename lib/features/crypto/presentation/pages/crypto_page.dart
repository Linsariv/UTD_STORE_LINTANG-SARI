// lib/features/crypto/presentation/pages/crypto_page.dart
import 'package:flutter/material.dart';
import '../../../../core/di/injection.dart';
import '../../data/services/crypto_service.dart';
import '../../data/services/bitcoin_websocket.dart'; // 👈 IMPORT BARU
import '../../domain/models/crypto_model.dart';

class CryptoPage extends StatefulWidget {
  const CryptoPage({super.key});

  @override
  State<CryptoPage> createState() => _CryptoPageState();
}

class _CryptoPageState extends State<CryptoPage> {
  List<CryptoModel> cryptos = [];
  bool isLoading = true;
  
  // 👈 VARIABLE BARU UNTUK BITCOIN & ISOLATE
  double bitcoinPrice = 0;
  bool isCalculating = false;
  late BitcoinWebSocketService _webSocket;

  @override
  void initState() {
    super.initState();
    fetchCrypto();
    
    // 👈 INISIALISASI WEBSOCKET BITCOIN
    _webSocket = BitcoinWebSocketService();
    _webSocket.connect((price) {
      if (mounted) {
        setState(() {
          bitcoinPrice = price;
        });
      }
    });
  }

  @override
  void dispose() {
    _webSocket.disconnect(); // 👈 CLOSE WEBSOCKET
    super.dispose();
  }

  Future<void> fetchCrypto() async {
    final data = await sl<CryptoService>().getCrypto();
    if (mounted) {
      setState(() {
        cryptos = data;
        isLoading = false;
      });
    }
  }

  // 👈 FUNGSI UNTUK KALKULASI PAJAK DENGAN ISOLATE
  Future<void> _calculateTax() async {
    setState(() {
      isCalculating = true;
    });

    // Tampilkan snackbar bahwa proses berjalan
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Menghitung pajak kripto... (UI tidak akan freeze)'),
        duration: Duration(milliseconds: 1500),
      ),
    );

    try {
      final result = await sl<CryptoService>().calculateTax();
      
      if (mounted) {
        // Tampilkan hasil
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Hasil Kalkulasi Pajak'),
            content: Text('Hasil perhitungan: $result\n\nLooping: 34 x 10.000.000 = 340.000.000 kali'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e'), backgroundColor: Colors.red),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          isCalculating = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Crypto Hub"),
        actions: [
          // 👈 TOMBOL KALKULASI PAJAK
          IconButton(
            icon: isCalculating
                ? const SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Icon(Icons.calculate),
            onPressed: isCalculating ? null : _calculateTax,
            tooltip: 'Kalkulasi Pajak Kripto',
          ),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                // 👈 CARD HARGA BITCOIN REAL-TIME
                Container(
                  margin: const EdgeInsets.all(16),
                  padding: const EdgeInsets.all(16),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFFF7931A), Color(0xFFFFA940)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.orange.withAlpha(77),  // 0.3 * 255 = 76.5 ≈ 77
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          Icon(Icons.currency_bitcoin, color: Colors.white, size: 28),
                          SizedBox(width: 8),
                          Text(
                            'BITCOIN REAL-TIME',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(
                        '\$${bitcoinPrice.toStringAsFixed(2)}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Last update: ${DateTime.now().hour.toString().padLeft(2, '0')}:${DateTime.now().minute.toString().padLeft(2, '0')}:${DateTime.now().second.toString().padLeft(2, '0')}',
                        style: const TextStyle(color: Colors.white70, fontSize: 11),
                      ),
                    ],
                  ),
                ),
                
                // 👈 LIST CRYPTO LAINNYA
                Expanded(
                  child: ListView.builder(
                    itemCount: cryptos.length,
                    itemBuilder: (context, index) {
                      final c = cryptos[index];
                      return ListTile(
                        leading: const Icon(Icons.currency_bitcoin, color: Colors.orange),
                        title: Text(
                          "${c.name} (${c.symbol?.toUpperCase() ?? 'N/A'})",
                          style: const TextStyle(fontWeight: FontWeight.w500),
                        ),
                        subtitle: Text("Market Cap Rank: ${c.marketCapRank ?? '-'}"),
                        trailing: Text(
                          "\$${c.currentPrice?.toStringAsFixed(2) ?? '0'}",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.green,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}