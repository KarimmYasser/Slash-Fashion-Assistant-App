class OrderListItem {
  final String status;
  final String date;
  final String order;
  final String shippingDate;
  final double totalCost;

  OrderListItem({
    required this.status,
    required this.date,
    required this.order,
    required this.shippingDate,
    required this.totalCost,
  });
}