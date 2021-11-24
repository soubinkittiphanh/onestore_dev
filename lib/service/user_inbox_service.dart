import 'dart:convert' as convert;
import 'dart:developer';
import 'dart:math';

import 'package:http/http.dart' as http;
import 'package:onestore/config/host_con.dart';
import 'package:onestore/models/inbox_message.dart';

class UserInboxService {
  static List<InboxMessage> _message = [];
  static bool isRead = false;
  static Future<List<InboxMessage>> getInbox(
    String id,
  ) async {
    final url = Uri.parse(Hostname + "user_inbox_f")
        .resolveUri(Uri(queryParameters: {"cust_id": id}));
    final response = await http.get(url);
    if (response.statusCode == 200) {
      print("REPONES 200");
      var jsonResponse = convert.jsonDecode(response.body) as List;
      _message = jsonResponse.map((el) {
        isRead = !isRead;
        return InboxMessage(
          orderId: el["card_order_id"].toString(),
          messageBody: el["card_code"].toString(),
          date: el["processing_date"].toString(),
          isRead: el["mark_readed"] == 1 ? true : false,
        );
      }).toList();
      print("Message len: " + _message.length.toString());

      return _message;
    } else {
      print("ERROR: ====> " + response.body);
      return _message;
    }
  }

  static Future<void> markReaded(card_number) async {
    final url = Uri.parse(Hostname + "user_inbox_markreaded_u");
    final response = await http.post(
      url,
      body: convert.json.encode({
        "card_number": card_number,
      }),
      headers: {
        "accept": "application/json",
        "content-type": "application/json",
      },
    );
    if (response.statusCode == 200) {
      print(response.body);
    } else {
      print("Fail: " + response.body);
    }
  }
}
