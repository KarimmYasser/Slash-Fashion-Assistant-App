import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../constants.dart';
import '../../utils/popups/loaders.dart';

class CheckoutScreen extends StatelessWidget {
  final double totalPrice;
  final List<Map<String, dynamic>> cartItems;

  const CheckoutScreen({
    super.key,
    required this.totalPrice,
    required this.cartItems,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(Sizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Total: EGP ${totalPrice.toStringAsFixed(2)}',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: Sizes.spaceBtwSections),
            Text(
              'Cart Items',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: cartItems.length,
                itemBuilder: (context, index) {
                  final item = cartItems[index];
                  return ListTile(
                    leading: Image.network(
                      item['imageUrl'],
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                    title: Text(item['name']),
                    subtitle: Text('Quantity: ${item['quantity']}'),
                    trailing: Text(
                      'EGP ${(item['price'] * item['quantity']).toStringAsFixed(2)}',
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: Sizes.spaceBtwSections),
            Text(
              'Payment Method',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            ListTile(
              title: const Text('Cash on Delivery'),
              leading: Radio(
                value: 'cod',
                groupValue: 'cod',
                onChanged: (value) {},
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(Sizes.defaultSpace),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Get.back();
                    Loaders.successSnackBar(
                      title: 'Congrats',
                      message: 'Order placed successfully!',
                    );
                  },
                  child: const Text('Confirm Order'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}