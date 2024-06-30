import 'dart:convert';

DriverInfoModel driverInfoModelFromJson(String str) =>
    DriverInfoModel.fromJson(json.decode(str));

class DriverInfoModel {
  final DriverInfoData data;

  DriverInfoModel({
    required this.data,
  });

  factory DriverInfoModel.fromJson(Map<String, dynamic> json) =>
      DriverInfoModel(
        data: DriverInfoData.fromJson(json["data"]),
      );
}

class DriverInfoData {
  final String fullName;
  final String phoneNumber;

  DriverInfoData({
    required this.fullName,
    required this.phoneNumber,
  });

  factory DriverInfoData.fromJson(Map<String, dynamic> json) => DriverInfoData(
        fullName: json["fullName"] ?? '',
        phoneNumber: json["phoneNumber"] ?? '',
      );
}
