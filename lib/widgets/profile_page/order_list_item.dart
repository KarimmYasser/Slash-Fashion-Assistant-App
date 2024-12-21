import 'package:fashion_assistant/constants.dart';
import 'package:fashion_assistant/utils/http/http_client.dart';
import 'package:fashion_assistant/utils/popups/loaders.dart';
import 'package:fashion_assistant/widgets/common/rounded_container.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';

import '../../models/orders_list.dart';

class OrderListItems extends StatefulWidget {
  final List<OrderListItem> ordersData;

  const OrderListItems({super.key, required this.ordersData});

  @override
  State<OrderListItems> createState() => _OrderListItemsState();
}

class _OrderListItemsState extends State<OrderListItems> {
  @override
  Widget build(BuildContext context) {
    Color getStatusColor(String status) {
      switch (status) {
        case 'CANCELLED':
          return Colors.red;
        case 'PENDING':
          return OurColors.primaryColor;
        default:
          return Colors.green;
      }
    }

    return ListView.separated(
      shrinkWrap: true,
      itemCount: widget.ordersData.length,
      separatorBuilder: (_, __) => const SizedBox(height: Sizes.spaceBtwItems),
      itemBuilder: (_, index) {
        final order = widget.ordersData[index];
        return Dismissible(
          key: Key(order.order.toString()),
          direction: DismissDirection.endToStart,
          confirmDismiss: (direction) async {
            await showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('Confirm Cancel'),
                  content:
                      const Text('Are you sure you want to cancel this order?'),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(false),
                      child: const Text('No'),
                    ),
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(true),
                      child: const Text('Yes'),
                    ),
                  ],
                );
              },
            );
            try {
              HttpHelper.post('api/order/update-order-status', {
                'orderId': order.order,
                'status': 'CANCELLED',
              });
              setState(() {
                order.status = 'CANCELLED';
              });
            } catch (e) {
              String errorMessage = e.toString();
              if (errorMessage.startsWith('Exception: ')) {
                errorMessage = errorMessage.replaceFirst('Exception: ', '');
              }
              Loaders.errorSnackBar(
                  title: 'Failed to Cancel Order', message: errorMessage);
            }
            return false;
          },
          background: Container(
            color: Colors.red,
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: const Icon(Icons.delete, color: Colors.white),
          ),
          child: RoundedContainer(
            showBorder: true,
            backgroundColor: OurColors.light,
            height: null,
            width: double.infinity,
            padding: const EdgeInsets.all(Sizes.md),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                //first row
                Row(
                  children: [
                    const Icon(Iconsax.ship, size: 20),
                    const SizedBox(width: Sizes.spaceBtwItems / 2),
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            order.status,
                            style: Theme.of(context).textTheme.bodyLarge!.apply(
                                color: getStatusColor(order.status),
                                fontWeightDelta: 1),
                          ),
                          Text(
                            DateFormat('dd MMMM yyyy')
                                .format(DateTime.parse(order.date)),
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: Sizes.spaceBtwItems),
                //second row
                Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          const Icon(Iconsax.tag, size: 20),
                          const SizedBox(width: Sizes.spaceBtwItems / 2),
                          Expanded(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Order',
                                  style:
                                      Theme.of(context).textTheme.labelMedium,
                                ),
                                Text(
                                  order.order,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .apply(fontSizeDelta: -4),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: Sizes.spaceBtwItems),
                    Expanded(
                      child: Row(
                        children: [
                          const Icon(Iconsax.calendar, size: 20),
                          const SizedBox(width: Sizes.spaceBtwItems / 2),
                          Expanded(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Shipping Date',
                                  style:
                                      Theme.of(context).textTheme.labelMedium,
                                ),
                                Text(
                                  DateFormat('dd MMMM yyyy').format(
                                      DateTime.parse(order.shippingDate)
                                          .add(const Duration(days: 7))),
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .apply(fontSizeDelta: -4),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: Sizes.spaceBtwItems),
                //third row
                Row(
                  children: [
                    const Icon(Iconsax.dollar_circle, size: 20),
                    const SizedBox(width: Sizes.spaceBtwItems / 2),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Total Cost',
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                        Text(
                          'EGP ${order.totalCost.toStringAsFixed(2)}',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .apply(fontSizeDelta: -4),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
