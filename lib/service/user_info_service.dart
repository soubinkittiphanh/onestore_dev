import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:onestore/config/host_con.dart';

class UserInfService {
  static Future<String> username(id, name) async {
    final url = Uri.parse(Hostname + "username_e");
    final response = await http.post(url,
        body: jsonEncode({"user_id": id, "user_name": name}),
        headers: {
          "accept": "application/json",
          "content-type": "application/json",
        });
    if (response.statusCode == 200) {
      return response.body;
    } else {
      log("ERROR: ====> " + response.body);

      return response.body;
    }
  }

  static Future<String> usertel(id, tel) async {
    final url = Uri.parse(Hostname + "usertel_e");
    final response = await http.post(url,
        body: jsonEncode({"user_id": id, "user_phone": tel}),
        headers: {
          "accept": "application/json",
          "content-type": "application/json",
        });
    if (response.statusCode == 200) {
      return response.body;
    } else {
      log("ERROR: ====> " + response.body);
      return response.body;
    }
  }

  static Future<String> userpass(id, pass) async {
    final url = Uri.parse(Hostname + "userpass_e");
    final response = await http.post(url,
        body: jsonEncode({"user_id": id, "user_password": pass}),
        headers: {
          "accept": "application/json",
          "content-type": "application/json",
        });
    if (response.statusCode == 200) {
      return response.body;
    } else {
      log("ERROR: ====> " + response.body);
      return response.body;
    }
  }

  static Future<String> useremail(id, mail) async {
    final url = Uri.parse(Hostname + "useremail_e");
    final response = await http.post(url,
        body: jsonEncode({"user_id": id, "user_email": mail}),
        headers: {
          "accept": "application/json",
          "content-type": "application/json",
        });
    if (response.statusCode == 200) {
      return response.body;
    } else {
      log("ERROR: ====> " + response.body);
      return response.body;
    }
  }
}
