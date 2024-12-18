import 'package:get/get.dart';

import '../../../models/cart_item.dart';
import '../../../utils/http/http_client.dart';
import '../../../utils/popups/loaders.dart';

class CartController extends GetxController {
  var cartItems = <CartItem>[].obs;
  var isLoading = true.obs;

  double get totalPrice =>
      cartItems.fold(0, (sum, item) => sum + item.price * item.quantity);

  @override
  void onInit() {
    super.onInit();
    fetchCartItems();
  }

  Future<void> fetchCartItems() async {
    try {
      final response = await HttpHelper.get('api/cart');
      final List<dynamic> fetchedItems = response["items"];
      final List<CartItem> loadedItems = fetchedItems
          .map((row) => CartItem(
                name: row['product']['product']['name'] as String,
                price: (row['product']['product']['price'] as num).toDouble(),
                quantity: row['quantity'],
                imageUrl: row['product']['product']['image'] as String,
              ))
          .toList();
      cartItems.assignAll(loadedItems);
    } catch (e) {
      Loaders.errorSnackBar(title: 'Error', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  void addItem(CartItem item) {
    cartItems.add(item);
  }

  void removeItem(CartItem item) {
    cartItems.remove(item);
  }

  void clearCart() {
    cartItems.clear();
  }
}
