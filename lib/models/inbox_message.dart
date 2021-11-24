class InboxMessage {
  final String orderId;
  final String messageBody;
  final String date;
  bool isRead;
  InboxMessage({
    required this.orderId,
    required this.messageBody,
    required this.date,
    this.isRead = true,
  });
}
