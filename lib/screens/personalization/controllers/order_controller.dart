import 'package:get/get.dart';

import '../../../models/orders_list.dart';
import '../../../utils/http/http_client.dart';
import '../../../utils/popups/loaders.dart';

class OrderController extends GetxController {
  var isLoading = true.obs;
  var orders = <OrderListItem>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchOrders();
  }

  Future<void> fetchOrders() async {
    try {
      final ordersData = await HttpHelper.get('api/order');
      final List<OrderListItem> fetchedOrders = (ordersData["orders"] as List)
          .map((row) => OrderListItem(
                status: row['order_status'] as String,
                date: row['created_at'] as String,
                order: row['id'] as String,
                shippingDate: row['created_at'] as String,
                totalCost: (row['total_cost'] as num).toDouble(),
              ))
          .toList();
      orders.assignAll(fetchedOrders);
    } catch (e) {
      Loaders.errorSnackBar(title: 'Oh Snap! ', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
