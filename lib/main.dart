import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/router/router.dart';
import 'core/di/injection.dart';

// cubit import
import 'features/product/presentation/cubit/product_cubit.dart';
import 'features/cart/presentation/cubit/cart_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init(); // init DI

  runApp(const MyAppRoot());
}

class MyAppRoot extends StatelessWidget {
  const MyAppRoot({super.key});

  @override
  Widget build(BuildContext context) {
return MultiBlocProvider(
  providers: [
    BlocProvider(create: (_) => sl<ProductCubit>()),
    BlocProvider(create: (_) => sl<CartCubit>()),
  ],
  child: const MyApp(),
);
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
    );
  }
}