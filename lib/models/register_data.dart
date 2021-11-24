class RegisterData {
  final String custName;
  final String custTel;
  final String custEmail;
  final String custPassword;
  final String custGameId;
  RegisterData({
    required this.custName,
    this.custEmail = '',
    this.custGameId = '',
    required this.custPassword,
    this.custTel = '',
  });
}
