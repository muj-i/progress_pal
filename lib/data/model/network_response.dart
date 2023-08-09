class NetworkResponse {
  final int statusCode;
  final bool isSuccess;
  final Map<String, dynamic>? body;
  
  const NetworkResponse(
    this.isSuccess,
    this.statusCode,
    this.body,
  );
}
