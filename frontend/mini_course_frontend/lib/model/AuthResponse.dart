class AuthResponse {
  final int statusCode;
  final String? message;
  final Object? data;
  AuthResponse({required this.statusCode, this.message, this.data});
}
