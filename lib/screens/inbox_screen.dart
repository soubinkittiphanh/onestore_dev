import 'package:flutter/material.dart';
import 'package:onestore/providers/inbox_message_provider.dart';
import 'package:onestore/widgets/message_item_detail.dart';
import 'package:provider/provider.dart';

class InboxScreen extends StatefulWidget {
  const InboxScreen({Key? key}) : super(key: key);

  @override
  State<InboxScreen> createState() => _InboxScreenState();
}

class _InboxScreenState extends State<InboxScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final inboxProvider = Provider.of<InboxMessageProvider>(context);
    final messageData = inboxProvider.loadMessage;
    return Container(
      color: Colors.white70,
      child: Column(
        children: [
          Row(
            children: [
              IconButton(
                onPressed: () {
                  inboxProvider.setloadMessage('1000');
                },
                icon: Icon(Icons.downhill_skiing),
              ),
              Text(
                "Count: " + messageData.length.toString(),
              )
            ],
          ),
          Flexible(
            child: ListView.builder(
              itemBuilder: (ctx, i) => Card(
                elevation: 0.1,
                child: Container(
                  //color: Colors.grey,
                  margin: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    border: Border.all(width: 0.1, color: Colors.red),
                    // color: Colors.blue,
                    borderRadius: BorderRadius.all(
                      Radius.circular(30),
                    ),
                  ),
                  child: ListTile(
                    title: Text(
                      'ວັນທີ: ' +
                          messageData[i].date.toString().substring(0, 10) +
                          ' ເວລາ: ' +
                          messageData[i].date.toString().substring(11, 19),
                      style: TextStyle(fontFamily: "noto san lao"),
                    ),
                    subtitle: Text(
                      "ລະຫັດອໍເດີ: " + messageData[i].orderId,
                      style: const TextStyle(
                        fontFamily: "noto san lao",
                        color: Colors.black,
                      ),
                    ),
                    trailing: IconButton(
                      icon: Icon(
                        messageData[i].isRead
                            ? Icons.mark_email_read_outlined
                            : Icons.mark_email_unread_outlined,
                        color: Colors.red,
                      ),
                      onPressed: () {
                        inboxProvider.setMessageAsRead(i);
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (ctx) =>
                                MessageItemDetail(inboxmessage: messageData[i]),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
              itemCount: messageData.length,
            ),
          ),
        ],
      ),
    );
  }
}
