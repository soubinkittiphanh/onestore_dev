// import 'dart:developer';

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:loader_overlay/loader_overlay.dart';
// import 'package:onestore/getxcontroller/message_controller.dart';
// import 'package:onestore/models/inbox_message.dart';
// import 'package:onestore/providers/user_credental_provider.dart';
// import 'package:onestore/service/user_inbox_service.dart';
// import 'package:onestore/widgets/message_card.dart';
// import 'package:provider/provider.dart';

// class InboxScreen extends StatelessWidget {
//   const InboxScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     // final userInbxService = UserInboxService();
//     final messageController = Get.put(MessageController());
//     // final inboxProvider = Provider.of<InboxMessageProvider>(context);
//     final userCredentialProvider = Provider.of<UserCredentialProvider>(context);
//     List<InboxMessage> messageData = messageController.loadMessage;
//     Future<void> _messageFetch() async {
//       context.loaderOverlay.show();
//       final messageData =
//           await UserInboxService.getInbox(userCredentialProvider.userId);
//       log("message: " + messageData.length.toString());
//       messageController.setloadMessage(messageData);
//       context.loaderOverlay.hide();
//     }

//     return LoaderOverlay(
//       child: Container(
//         color: Colors.white70,
//         child: Column(
//           children: [
//             Row(
//               children: [
//                 IconButton(
//                   iconSize: 45,
//                   onPressed: _messageFetch,
//                   icon: const Icon(Icons.refresh, color: Colors.red),
//                   splashColor: Colors.blue,
//                 ),
//                 Text(
//                   "Refresh Count: " + messageData.length.toString(),
//                 )
//               ],
//             ),
//             Flexible(
//               child: GetBuilder<MessageController>(
//                 builder: (_) {
//                   return ListView.builder(
//                     itemBuilder: (ctx, i) => MessageCard(
//                       messageData: messageData[i],
//                       idx: i,
//                     ),
//                     itemCount: messageData.length,
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
