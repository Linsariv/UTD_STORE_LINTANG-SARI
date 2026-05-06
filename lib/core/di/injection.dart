import 'package:get_it/get_it.dart';
import 'package:utd_store_lintang_sari/features/splash/domain/services/splash_service.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerLazySingleton(() => SplashService());
}