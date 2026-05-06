import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:utd_store_lintang_sari/core/di/injection.dart';
import 'package:utd_store_lintang_sari/features/splash/domain/services/splash_service.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  @override
  void initState() {
    super.initState();
    start();
  }

  Future<void> start() async {
    final service = sl<SplashService>();
    await service.startDelay();

    if (mounted) {
      context.go('/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          "Lintang\nNIM: 20123012", // ganti sesuai NIM kamu
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}