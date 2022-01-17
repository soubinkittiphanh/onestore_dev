import 'package:onestore/config/host_con.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:onestore/models/product.dart';

class ProductHelper {
  static List<Product> _loadProduct = [];
  static Future<List<Product>> fetchProcuctAPI() async {
    var url = Uri.parse(hostname + 'product_f');

    // Await the http get response, then decode the json-formatted response.
    print("Loading...");
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body) as List;

      _loadProduct = jsonResponse.map((el) {
        print("XXXXXX: " + el["img_name"].toString());
        //Check if image is null then so app not crash
        String imageName = el["img_name"].toString();
        var imagePath = hostname + 'uploads/${el["img_name"]}';
        if (imageName.contains('No image')) {
          imagePath = 'No image';
        }
        return Product(
          proId: el['pro_id'],
          categName: el["categ_name"],
          proCatID: el["pro_category"].toString(),
          proName: el["pro_name"],
          proPrice: (el["pro_price"]).toDouble(),
          proDesc: el["pro_desc"],
          proStatus: el["pro_status"],
          proImagePath: imagePath,
          proCategory: el["categ_name"],
          stock: el["card_count"],
          saleCount: el["sale_count"],
        );
      }).toList();
      print(jsonResponse);
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
    return _loadProduct;
  }
}
    // void _product() async {
    //   List<Product> loadProduct = await ProductHelper.fetchProcuctAPI();
    //   productPrd.addProduct(loadProduct);
    // }
          // ListView.builder(
      //   scrollDirection: Axis.horizontal,
      //   itemCount: _onlineData.length,
      //   itemBuilder: (ctx, idx) => CircleAvatar(
      //     child: Text('fd'),
      //   ),
      // ),