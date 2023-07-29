class NetworkResponce {
  final int statusCode;
  final bool isSuccess;
  final Map<String, dynamic>? body;
  const NetworkResponce(this.isSuccess, this.statusCode, this.body, );
}
