import 'dart:convert';

RefreshTokenModel refreshTokenModelFromJson(String str) =>
    RefreshTokenModel.fromJson(json.decode(str));

class RefreshTokenModel {
  RefreshTokenModel({
    required this.data,
  });

  final RefreshToken data;

  factory RefreshTokenModel.fromJson(Map<String, dynamic> json) =>
      RefreshTokenModel(
        data: RefreshToken.fromJson(json['data']),
      );
}

class RefreshToken {
  RefreshToken({
    required this.accessToken,
    required this.refreshToken,
  });

  final String accessToken;
  final String refreshToken;

  factory RefreshToken.fromJson(Map<String, dynamic> json) => RefreshToken(
        accessToken: json['access_token'] ?? '',
        refreshToken: json['refresh_token'] ?? '',
      );
}
