import 'dart:convert' as convert;
import 'dart:developer';
import 'dart:math';

import 'package:http/http.dart' as http;
import 'package:onestore/config/host_con.dart';
import 'package:onestore/models/register_data.dart';

class RegisterService {
  Future registerCustomer(RegisterData cus) async {
    final url = Uri.parse(Hostname + "register_i");
    final respones = await http.post(url,
        body: convert.json.encode({
          "cust_name": cus.custName,
          "cust_pass": cus.custPassword,
          "cust_phone": cus.custTel,
          "cust_email": cus.custEmail,
          "cust_gameId": cus.custGameId,
        }),
        headers: {
          "accept": "application/json",
          "content-type": "application/json",
        });
    if (respones.statusCode == 200) {
      if (respones.body.contains("completed")) {
        //Transaction complete

        return 200;
      } else {
        //Transaction fail
        print("Server error: " + respones.body);
        return 503;
      }
    } else {
      // Network problem
      return 404;
    }
  }
}
