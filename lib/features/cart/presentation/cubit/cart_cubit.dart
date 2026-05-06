import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:utd_store_lintang_sari/features/cart/domain/models/cart_model.dart';

class CartCubit extends Cubit<List<CartModel>> {
  CartCubit() : super([]);

  // Method yang sudah ada (addToCart, removeFromCart, dll)
  
  void addToCart(CartModel item) {
    final existingIndex = state.indexWhere((product) => product.id == item.id);
    
    if (existingIndex != -1) {
      // Jika produk sudah ada, tambah quantity
      final updatedCart = List<CartModel>.from(state);
      final existingItem = updatedCart[existingIndex];
      updatedCart[existingIndex] = existingItem.copyWith(
        quantity: existingItem.quantity + 1,
      );
      emit(updatedCart);
    } else {
      // Jika produk belum ada, tambahkan dengan quantity 1
      emit([...state, item.copyWith(quantity: 1)]);
    }
  }

  void removeFromCart(int productId) {
    emit(state.where((item) => item.id != productId).toList());
  }

  // ✅ TAMBAHKAN METHOD INI:
  void updateQuantity(int productId, int newQuantity) {
    final updatedCart = state.map((item) {
      if (item.id == productId) {
        return item.copyWith(quantity: newQuantity);
      }
      return item;
    }).toList();
    
    emit(updatedCart);
  }

  // Optional: method untuk clear cart
  void clearCart() {
    emit([]);
  }
}