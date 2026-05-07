// lib/features/product/data/repositories/product_repository_impl.dart
import 'package:dio/dio.dart';
import '../models/product_model.dart';
import '../../domain/entities/product.dart';
import '../../domain/repositories/product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  final Dio dio;

  ProductRepositoryImpl(this.dio);

  @override
  Future<List<Product>> getProducts() async {
    final response = await dio.get('https://fakestoreapi.com/products');

    List data = response.data;

    // 🔥 LOGIKA NIM - GANTI dengan digit terakhir NIM Anda!
    final int lastDigit = 7; // Contoh (ganjil)
    final String promoText = lastDigit % 2 == 1 ? " [Diskon 10%]" : " [Promo Ongkir]";

    return data.map((json) {
      final product = ProductModel.fromJson(json);
      return ProductModel(
        id: product.id,
        title: "${product.title}$promoText",  // 👈 Promo ditambahkan di sini
        price: product.price,
        image: product.image,
      );
    }).toList();
  }
}