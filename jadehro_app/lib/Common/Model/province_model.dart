import 'dart:convert';

BaseListModel baseListModelFromJson(String str) =>
    BaseListModel.fromJson(json.decode(str));

class BaseListModel {
  final List<BaseListData> data;

  BaseListModel({
    required this.data,
  });

  factory BaseListModel.fromJson(Map<String, dynamic> json) => BaseListModel(
        data: List<BaseListData>.from(
            json["data"].map((x) => BaseListData.fromJson(x))),
      );
}

class BaseListData {
  final int id;
  final String name;

  BaseListData({
    required this.id,
    required this.name,
  });

  factory BaseListData.fromJson(Map<String, dynamic> json) => BaseListData(
        id: json["id"] ?? 0,
        name: json["name"] ?? '',
      );
}
