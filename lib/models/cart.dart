class CartItem {
  final int proId;
  final int qty;
  final double price;
  final double priceTotal;
  CartItem(
    this.proId,
    this.qty,
    this.price,
    this.priceTotal,
  );
  Map toJson() => {
        'product_id': proId,
        'product_amount': qty,
        'product_price': price,
        'order_price_total': priceTotal,
      };
}
