import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants.dart';
import 'checkout_screen.dart';
import 'controllers/cart_controller.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final CartController controller = Get.put(CartController());
    controller.fetchCartItems();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else if (controller.cartItems.isEmpty) {
          return const Center(child: Text('Your cart is empty'));
        } else {
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: controller.cartItems.length,
                  itemBuilder: (context, index) {
                    final item = controller.cartItems[index];
                    return ListTile(
                      leading: Image.network(item.imageUrl,
                          width: 50, height: 50, fit: BoxFit.cover),
                      title: Text(
                        item.name,
                        overflow: TextOverflow.ellipsis,
                      ),
                      subtitle: Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.remove),
                            onPressed: () => controller.decreaseQuantity(item),
                          ),
                          Text('${item.quantity}'),
                          IconButton(
                            icon: const Icon(Icons.add),
                            onPressed: () => controller.increaseQuantity(item),
                          ),
                          const Spacer(),
                          Text(
                              'EGP ${(item.price * item.quantity).toStringAsFixed(2)}'),
                        ],
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () => controller.removeItem(item),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Total: EGP ${controller.totalPrice.toStringAsFixed(2)}',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(Sizes.spaceBtwItems),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: controller.cartItems.isEmpty
                        ? null
                        : () => Get.to(() => CheckoutScreen(
                              totalPrice: controller.totalPrice.value,
                              cartItems: controller.cartItems
                                  .map((item) => {
                                        'name': item.name,
                                        'price': item.price,
                                        'quantity': item.quantity,
                                        'imageUrl': item.imageUrl,
                                      })
                                  .toList(),
                            )),
                    child: const Text('Checkout'),
                  ),
                ),
              ),
            ],
          );
        }
      }),
    );
  }
}
