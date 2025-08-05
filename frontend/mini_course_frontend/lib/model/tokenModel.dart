class TokenModel {
  final String accessToken;
  final String refreshToken;

  TokenModel({required this.accessToken, required this.refreshToken});

  factory TokenModel.fromJson(Map<String, dynamic> data) => TokenModel(
        accessToken: data['access'],
        refreshToken: data['refresh'],
      );
}
