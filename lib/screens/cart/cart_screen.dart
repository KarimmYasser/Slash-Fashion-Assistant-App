import 'package:fashion_assistant/utils/popups/loaders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants.dart';
import '../../widgets/cart_item_card.dart';
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
                    return Dismissible(
                      key: Key(item.id.toString()),
                      direction: DismissDirection.endToStart,
                      confirmDismiss: (direction) async {
                        return await showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text('Confirm'),
                              content: const Text(
                                  'Are you sure you want to delete this item?'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop(false);
                                  },
                                  child: const Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop(true);
                                  },
                                  child: const Text('Delete'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      onDismissed: (direction) {
                        controller.removeItem(item);
                        Loaders.successSnackBar(
                            title: 'Item removed', message: item.name);
                      },
                      background: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Colors.red.shade400, Colors.red.shade900],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                        ),
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.symmetric(
                            horizontal: Sizes.defaultSpace),
                        child: const Icon(Icons.delete, color: OurColors.white),
                      ),
                      child: CartItemCard(item: item),
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
                                        'discount': item.discount,
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
