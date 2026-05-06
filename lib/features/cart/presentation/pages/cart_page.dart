// Di Cart Page Anda (misal cart_page.dart)

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:utd_store_lintang_sari/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:utd_store_lintang_sari/features/cart/domain/models/cart_model.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
      ),
      body: BlocBuilder<CartCubit, List<CartModel>>(
        builder: (context, cartItems) {
          if (cartItems.isEmpty) {
            return const Center(
              child: Text('Your cart is empty'),
            );
          }

          // Hitung total
          final total = cartItems.fold(
            0.0,
            (sum, item) => sum + (item.price * item.quantity),
          );

          return Column(
            children: [
              // ✅ Pakai Expanded + ListView untuk item cart
              Expanded(
                child: ListView.builder(
                  itemCount: cartItems.length,
                  itemBuilder: (context, index) {
                    final item = cartItems[index];
                    return CartItemCard(item: item);
                  },
                ),
              ),
              
              // ✅ Bottom section (total + checkout button) - FIXED, tidak ikut scroll
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade300,
                      offset: const Offset(0, -2),
                      blurRadius: 4,
                    ),
                  ],
                ),
                child: SafeArea(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Total',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                          Text(
                            'Rp ${total.toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      ElevatedButton(
                        onPressed: () {
                          // Proses checkout
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          foregroundColor: Colors.white,
                        ),
                        child: const Text('Checkout'),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

// Widget untuk item cart dengan plus/minus
class CartItemCard extends StatelessWidget {
  final CartModel item;
  
  const CartItemCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Gambar produk
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                item.image,
                width: 70,
                height: 70,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 70,
                    height: 70,
                    color: Colors.grey.shade200,
                    child: const Icon(Icons.image_not_supported),
                  );
                },
              ),
            ),
            
            const SizedBox(width: 12),
            
            // Info produk
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  if (item.promoText != null) ...[
                    Text(
                      item.promoText!,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.green.shade700,
                      ),
                    ),
                    const SizedBox(height: 2),
                  ],
                  Text(
                    'Rp ${item.price.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 8),
                  
                  // ✅ Plus/Minus buttons dengan quantity (FIXED POSITION)
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () {
                          if (item.quantity > 1) {
                            context.read<CartCubit>().updateQuantity(
                              item.id,
                              item.quantity - 1,
                            );
                          } else {
                            context.read<CartCubit>().removeFromCart(item.id);
                          }
                        },
                        icon: const Icon(Icons.remove, size: 18),
                        constraints: const BoxConstraints(minWidth: 32),
                        style: IconButton.styleFrom(
                          backgroundColor: Colors.grey.shade200,
                          padding: EdgeInsets.zero,
                        ),
                      ),
                      Container(
                        width: 40,
                        alignment: Alignment.center,
                        child: Text(
                          item.quantity.toString(),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          context.read<CartCubit>().updateQuantity(
                            item.id,
                            item.quantity + 1,
                          );
                        },
                        icon: const Icon(Icons.add, size: 18),
                        constraints: const BoxConstraints(minWidth: 32),
                        style: IconButton.styleFrom(
                          backgroundColor: Colors.grey.shade200,
                          padding: EdgeInsets.zero,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            // Hapus icon
            IconButton(
              onPressed: () {
                context.read<CartCubit>().removeFromCart(item.id);
              },
              icon: const Icon(Icons.delete_outline, size: 20),
              color: Colors.red,
            ),
          ],
        ),
      ),
    );
  }
}