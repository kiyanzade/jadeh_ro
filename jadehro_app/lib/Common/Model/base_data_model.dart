import 'dart:convert';

BaseDataModel baseDataModelFromJson(String str) =>
    BaseDataModel.fromJson(json.decode(str));

class BaseDataModel {
  BaseDataModel({
    required this.isSuccess,
    required this.statusCode,
    required this.message,
  });

  bool isSuccess;
  int statusCode;
  String message;

  factory BaseDataModel.fromJson(Map<String, dynamic> json) => BaseDataModel(
        isSuccess: json['isSuccess'] ?? false,
        statusCode: json['statusCode'] ?? 0,
        message: json['message'] ?? '',
      );
}
