class CartModel {
  final int id;
  final String title;
  final double price;
  final String image;
  final int quantity; // Tambahkan ini
  final String? promoText;

  CartModel({
    required this.id,
    required this.title,
    required this.price,
    required this.image,
    this.quantity = 1, // Default quantity = 1
    this.promoText,
  });

  // CopyWith method untuk update quantity
  CartModel copyWith({int? quantity}) {
    return CartModel(
      id: id,
      title: title,
      price: price,
      image: image,
      quantity: quantity ?? this.quantity,
      promoText: promoText,
    );
  }
}