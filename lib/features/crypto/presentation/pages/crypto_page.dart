import 'package:flutter/material.dart';
import '../../../../core/di/injection.dart';
import '../../data/services/crypto_service.dart';
import '../../domain/models/crypto_model.dart';

class CryptoPage extends StatefulWidget {
  const CryptoPage({super.key});

  @override
  State<CryptoPage> createState() => _CryptoPageState();
}

class _CryptoPageState extends State<CryptoPage> {
  List<CryptoModel> cryptos = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchCrypto();
  }

  Future<void> fetchCrypto() async {
    final data = await sl<CryptoService>().getCrypto();
    setState(() {
      cryptos = data;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Crypto")),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: cryptos.length,
              itemBuilder: (context, index) {
                final c = cryptos[index];
                return ListTile(
                  title: Text("${c.name} (${c.symbol.toUpperCase()})"),
                  subtitle: Text("\$${c.price}"),
                );
              },
            ),
    );
  }
}