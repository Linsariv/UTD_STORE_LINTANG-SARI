import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import '../../features/splash/domain/services/splash_service.dart';
import '../../features/product/data/repositories/product_repository_impl.dart';
import '../../features/product/domain/repositories/product_repository.dart';
import '../../features/product/presentation/cubit/product_cubit.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import '../../features/bookmark/data/models/bookmark_model.dart';
import '../../features/bookmark/data/datasources/bookmark_local_datasource.dart';
import '../../features/crypto/data/services/crypto_service.dart';
import '../../features/cart/presentation/cubit/cart_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // ======================
  // DIO (GLOBAL)
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

  // Splash Service
  sl.registerLazySingleton(() => SplashService());

// Product
sl.registerLazySingleton<ProductRepository>(
  () => ProductRepositoryImpl(sl())
);
sl.registerFactory<ProductCubit>(
  () => ProductCubit(sl())
);

  // ======================
  // CART
  // ======================
  sl.registerFactory(() => CartCubit());

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

  // Datasource
  sl.registerLazySingleton<BookmarkLocalDataSource>(
    () => BookmarkLocalDataSource(sl()),
  );
}