class Product {
  final int proId;
  final String proCategory;
  final String proName;
  final double proPrice;
  final String proDesc;
  final int proStatus;
  final String proImagePath;
  final String categName;

  Product({
    required this.proId,
    required this.proName,
    required this.proDesc,
    required this.proPrice,
    required this.proCategory,
    required this.proStatus,
    this.proImagePath = '',
    required this.categName,
  });
}
