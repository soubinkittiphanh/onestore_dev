import "dart:developer";

class CartItem {
  int proId;
  int qty;
  double priceTotal;
  double priceRetail;
  double price;
  double discountPercent;
  CartItem({
    required this.proId,
    required this.qty,
    required this.price,
    required this.priceTotal,
    required this.priceRetail,
    required this.discountPercent,
  });
  Map toJson() {
    log("Price: " + price.toString());
    log("Retail: " + priceRetail.toString());
    return {
      "product_id": proId,
      "product_amount": qty,
      "product_price": (100 * price) / (100 - discountPercent),
      "order_price_total": priceTotal,
      "product_price_retail": priceRetail,
      "product_discount": discountPercent,
    };
  }
}
