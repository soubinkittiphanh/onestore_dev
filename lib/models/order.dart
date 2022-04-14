class Order {
  final String orderId;
  final String orderDate;
  final int userId;
  final int prodId;
  final int qty;
  final double price;
  final double total;
  final String proName;
  final double proDiscount;
  Order(
    this.orderId,
    this.orderDate,
    this.userId,
    this.prodId,
    this.qty,
    this.price,
    this.total,
    this.proName,
    this.proDiscount,
  );
}
