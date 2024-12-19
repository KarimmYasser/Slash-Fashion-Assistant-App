class CartItem {
  final String name;
  final double price;
  int quantity;
  final String imageUrl;
  final String id;

  CartItem({
    required this.name,
    required this.price,
    required this.quantity,
    required this.imageUrl,
    required this.id,
  });
}
