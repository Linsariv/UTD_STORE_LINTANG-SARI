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

    return data.map((json) {
      final product = ProductModel.fromJson(json);

      // 🔥 LOGIKA NIM (GENAP → Promo Ongkir)
      return ProductModel(
        id: product.id,
        title: "${product.title} [Promo Ongkir]",
        price: product.price,
        image: product.image,
      );
    }).toList();
  }
}