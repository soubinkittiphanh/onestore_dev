class UserInfo {
  final String userName;
  final String token;
  final double balance;
  final String userId;
  final String phone;
  final String email;
  UserInfo({
    required this.userName,
    required this.token,
    this.balance = 0.0,
    required this.userId,
    required this.phone,
    required this.email,
  });
}
