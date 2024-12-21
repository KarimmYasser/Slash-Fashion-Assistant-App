import 'package:flutter/material.dart';

import '../constants.dart';
import '../models/cart_item.dart';

class CartItemCard extends StatelessWidget {
  const CartItemCard({
    super.key,
    required this.item,
  });

  final CartItem item;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: Sizes.cardElevation,
      margin: const EdgeInsets.symmetric(
          vertical: Sizes.cardVerticalMargin,
          horizontal: Sizes.cardHorizontalMargin),
      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(Sizes.cardRadiusLg),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            ClipRRect(
              borderRadius:
                  BorderRadius.circular(Sizes.cardRadiusSm),
              child: Image.network(
                item.imageUrl,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Quantity: ${item.quantity}',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 8),
                  if (item.discount > 0)
                    Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Discount: ${item.discount}%',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.red[700],
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Text(
                              'EGP ${(item.price * item.quantity).toStringAsFixed(2)}',
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                                decoration: TextDecoration
                                    .lineThrough,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'EGP ${(item.price * (1 - item.discount / 100) * item.quantity).toStringAsFixed(2)}',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.green[700],
                              ),
                            ),
                          ],
                        )
                      ],
                    )
                  else
                    Text(
                      'EGP ${(item.price * item.quantity).toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.green[700],
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
