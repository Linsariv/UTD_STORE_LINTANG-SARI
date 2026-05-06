import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

// BOOKMARK
import '../../features/bookmark/data/models/bookmark_model.dart';
import '../../features/bookmark/data/datasources/bookmark_local_datasource.dart';

// CRYPTO
import '../../features/crypto/data/services/crypto_service.dart';

// SPLASH
import '../../features/splash/domain/services/splash_service.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // ======================
  // DIO
  // ======================
  sl.registerLazySingleton<Dio>(() {
    final dio = Dio();

    dio.interceptors.add(
      LogInterceptor(
        request: true,
        requestBody: true,
        responseBody: true,
        error: true,
      ),
    );

    return dio;
  });

  // ======================
  // SPLASH
  // ======================
  sl.registerLazySingleton(() => SplashService());

  // ======================
  // CRYPTO
  // ======================
  sl.registerLazySingleton(() => CryptoService(sl()));

  // ======================
  // ISAR (BOOKMARK)
  // ======================
  final dir = await getApplicationDocumentsDirectory();

  final isar = await Isar.open(
    [BookmarkModelSchema],
    directory: dir.path,
  );

  sl.registerLazySingleton<Isar>(() => isar);

  // ======================
  // BOOKMARK DATA SOURCE
  // ======================
  sl.registerLazySingleton<BookmarkLocalDataSource>(
    () => BookmarkLocalDataSource(sl()),
  );
}