class CartItem {
  final int proId;
  final int qty;
  final double priceTotal;
  final double priceRetail;
  final double price;
  CartItem({
    required this.proId,
    required this.qty,
    required this.price,
    required this.priceTotal,
    required this.priceRetail,
  });
  Map toJson() => {
        'product_id': proId,
        'product_amount': qty,
        'product_price': price,
        'order_price_total': priceTotal,
        'product_price_retail': priceRetail,
      };
}
