import 'package:fashion_assistant/widgets/common/appbar.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';
import '../../widgets/profile_page/order_list_item.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appbar(
        title: Text(
          'My Orders',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        showBackButton: true,
      ),
      body: const Padding(
        padding: EdgeInsets.all(Sizes.defaultSpace),
        child: OrderListItems(),
      ),
    );
  }
}
