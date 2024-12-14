import 'package:fashion_assistant/constants.dart';
import 'package:fashion_assistant/widgets/common/rounded_container.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';

import '../../models/orders_list.dart';

class OrderListItems extends StatelessWidget {
  final List<OrderListItem> ordersData;

  const OrderListItems({super.key, required this.ordersData});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: ordersData.length,
      separatorBuilder: (_, __) => const SizedBox(height: Sizes.spaceBtwItems),
      itemBuilder: (_, index) {
        final order = ordersData[index];
        return RoundedContainer(
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
                  const Icon(Iconsax.ship),
                  const SizedBox(width: Sizes.spaceBtwItems / 2),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          order.status,
                          style: Theme.of(context).textTheme.bodyLarge!.apply(
                              color: OurColors.primaryColor,
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
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Iconsax.arrow_right_34,
                      size: Sizes.iconSm,
                    ),
                  )
                ],
              ),
              const SizedBox(height: Sizes.spaceBtwItems),
              //second row
              Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        const Icon(Iconsax.tag),
                        const SizedBox(width: Sizes.spaceBtwItems / 2),
                        Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Order',
                                style: Theme.of(context).textTheme.labelMedium,
                              ),
                              Text(
                                order.order,
                                style: Theme.of(context).textTheme.titleMedium,
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
                        const Icon(Iconsax.calendar),
                        const SizedBox(width: Sizes.spaceBtwItems / 2),
                        Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Shipping Date',
                                style: Theme.of(context).textTheme.labelMedium,
                              ),
                              Text(
                                DateFormat('dd MMMM yyyy').format(
                                    DateTime.parse(order.shippingDate)
                                        .add(const Duration(days: 7))),
                                style: Theme.of(context).textTheme.titleMedium,
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
                  const Icon(Iconsax.dollar_circle),
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
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
