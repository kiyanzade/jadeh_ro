import 'dart:convert';

UserInfoModel userInfoModelFromJson(String str) =>
    UserInfoModel.fromJson(json.decode(str));

class UserInfoModel {
  final UserInfoData data;

  UserInfoModel({
    required this.data,
  });

  factory UserInfoModel.fromJson(Map<String, dynamic> json) => UserInfoModel(
        data: UserInfoData.fromJson(json["data"]),
      );
}

class UserInfoData {
  final int id;
  final String userName;
  final String fullName;
  final String phoneNumber;
  final bool isSuspended;

  UserInfoData({
    required this.id,
    required this.userName,
    required this.fullName,
    required this.phoneNumber,
    required this.isSuspended,
  });

  factory UserInfoData.fromJson(Map<String, dynamic> json) => UserInfoData(
        id: json["id"] ?? 0,
        userName: json["userName"] ?? '',
        fullName: json["fullName"] ?? '',
        phoneNumber: json["phoneNumber"] ?? '',
        isSuspended: json["isSuspended"] ?? false,
      );
}
