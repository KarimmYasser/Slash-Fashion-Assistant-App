import 'package:get/get.dart';

import '../../../models/cart_item.dart';
import '../../../utils/http/http_client.dart';
import '../../../utils/popups/loaders.dart';

class CartController extends GetxController {
  var cartItems = <CartItem>[].obs;
  var totalPrice = 0.0.obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchCartItems();
  }

  Future<void> fetchCartItems() async {
    try {
      clearCart();
      isLoading = true.obs;
      final response = await HttpHelper.get('api/cart');
      final List<dynamic> fetchedItems = response["cart"]["items"];
      final List<CartItem> loadedItems = fetchedItems
          .map((row) => CartItem(
                name: row['product']['product']['name'] as String,
                price: (row['product']['product']['price'] as num).toDouble(),
                discount:
                    (row['product']['product']['discount'] as num).toDouble(),
                quantity: row['quantity'],
                imageUrl: row['product']['product']['image'] as String,
                id: row['id'] as String,
              ))
          .toList();
      cartItems.assignAll(loadedItems);
    } catch (e) {
      Loaders.errorSnackBar(title: 'Error', message: e.toString());
    } finally {
      isLoading.value = false;
    }
    updateCart();
  }

  void addItem(CartItem item) {
    cartItems.add(item);
    updateCart();
  }

  void removeItem(CartItem item) async {
    try {
      await HttpHelper.delete('api/cart/remove/${item.id}', {'id': item.id});
      cartItems.remove(item);
    } catch (e) {
      Loaders.errorSnackBar(title: 'Failed to remove', message: e.toString());
    }
    updateCart();
  }

  void clearCart() {
    cartItems.clear();
    updateCart();
  }

  void updateCart() {
    // Update the total price and other necessary states
    totalPrice.value = calculateTotalPrice();
    // Notify listeners to update the UI
    update();
  }

  double calculateTotalPrice() {
    double total = 0.0;
    for (var item in cartItems) {
      total += item.price * (1 - item.discount / 100) * item.quantity;
    }
    return total;
  }
}
