// import 'package:flutter/material.dart';
// import 'package:onestore/models/inbox_message.dart';
// import 'package:onestore/service/user_inbox_service.dart';

// class InboxMessageProvider extends ChangeNotifier {
//   List<InboxMessage> _loadMessage = [];
//   Future<void> setloadMessage(id) async {
//     _loadMessage = await UserInboxService.getInbox(id);
//     notifyListeners();
//   }

//   List<InboxMessage> get loadMessage {
//     return _loadMessage;
//   }

//   void setMessageAsRead(id) {
//     UserInboxService.markReaded(_loadMessage[id].messageBody);
//     _loadMessage.elementAt(id).isRead = true;
//     notifyListeners();
//   }

//   int get ureadMessage {
//     final unlreadInbox =
//         _loadMessage.where((element) => element.isRead == false);
//     return unlreadInbox.length;
//   }
// }
