import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/di/injection.dart';

import '../cubit/product_cubit.dart';
import '../cubit/product_state.dart';
import 'package:go_router/go_router.dart';

import 'package:utd_store_lintang_sari/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:utd_store_lintang_sari/features/cart/domain/models/cart_model.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<ProductCubit>()..fetchProducts(),
      child: Scaffold(
appBar: AppBar(
  title: const Text("Product"),
actions: [
  IconButton(
    icon: const Icon(Icons.currency_bitcoin),
    onPressed: () {
      context.go('/crypto');
    },
  ),

  BlocBuilder<CartCubit, List<CartModel>>(
    builder: (context, state) {
      return Stack(
        children: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              context.go('/cart');
            },
          ),
          if (state.isNotEmpty)
            Positioned(
              right: 0,
              child: CircleAvatar(
                radius: 8,
                backgroundColor: Colors.red,
                child: Text(
                  state.length.toString(),
                  style: const TextStyle(fontSize: 10),
                ),
              ),
            ),
        ],
      );
    },
  ),

            IconButton(
              icon: const Icon(Icons.battery_6_bar),
              onPressed: () {
                context.go('/battery');
              },
              tooltip: 'Cek Baterai',
            ),
],
),
        body: BlocBuilder<ProductCubit, ProductState>(
          builder: (context, state) {
            if (state is ProductLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is ProductLoaded) {
              return ListView.builder(
                itemCount: state.products.length,
                itemBuilder: (context, index) {
                  final p = state.products[index];

return Card(
  margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
  child: Padding(
    padding: const EdgeInsets.all(10),
    child: Row(
      children: [
        Image.network(
          p.image,
          width: 60,
          height: 60,
          fit: BoxFit.cover,
        ),

        const SizedBox(width: 10),

Expanded(
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        p.title,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      const SizedBox(height: 5),
      Text(
        "Rp ${p.price}",
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
    ],
  ),
),

    IconButton(
      icon: const Icon(Icons.favorite_border),
      iconSize: 20,
      padding: EdgeInsets.zero,
      constraints: const BoxConstraints(),
      onPressed: () {
        context.read<CartCubit>().addToCart(
          CartModel(
            id: p.id,
            title: p.title,
            price: p.price,
            image: p.image,
          ),
            );
          },
        ),
      ],
    ),
  ),
);
                },
              );
            }

            if (state is ProductError) {
              return Center(child: Text(state.message));
            }

            return const SizedBox();
          },
        ),
      ),
    );
  }
}