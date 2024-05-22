import 'dart:convert';

TokenModel tokenModelFromJson(String str) =>
    TokenModel.fromJson(json.decode(str));

class TokenModel {
  final TokenData data;

  TokenModel({
    required this.data,
  });

  factory TokenModel.fromJson(Map<String, dynamic> json) => TokenModel(
        data: TokenData.fromJson(json["data"]),
      );
}

class TokenData {
  final String accessToken;
  final String refreshToken;

  TokenData({
    required this.accessToken,
    required this.refreshToken,
  });

  factory TokenData.fromJson(Map<String, dynamic> json) => TokenData(
        accessToken: json["access_token"] ?? '',
        refreshToken: json["refresh_token"] ?? '',
      );
}
