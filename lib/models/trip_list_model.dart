import 'dart:convert';

TripListModel tripListModelFromJson(String str) =>
    TripListModel.fromJson(json.decode(str));

class TripListModel {
  final List<TripListData> data;

  TripListModel({
    required this.data,
  });

  factory TripListModel.fromJson(Map<String, dynamic> json) => TripListModel(
        data: List<TripListData>.from(
            json["data"].map((x) => TripListData.fromJson(x))),
      );
}

class TripListData {
  final int id;
  final int capacity;
  final int moneyType;
  final String moveDateTime;
  final String description;
  final int carModel;
  final String carBrandName;
  final int sourceId;
  final int money;
  final String sourceName;
  final int destinationId;
  final int tripStatus;
  final String destinationName;
  final String createdDateTime;
  final bool haveNewReq;

  TripListData({
    required this.id,
    required this.money,
    required this.haveNewReq,
    required this.tripStatus,
    required this.capacity,
    required this.moneyType,
    required this.moveDateTime,
    required this.description,
    required this.carModel,
    required this.carBrandName,
    required this.sourceId,
    required this.sourceName,
    required this.destinationId,
    required this.destinationName,
    required this.createdDateTime,
  });

  factory TripListData.fromJson(Map<String, dynamic> json) => TripListData(
        id: json["id"] ?? 0,
        money: json["money"] ?? 0,
        tripStatus: json["status"] ?? 0,
        capacity: json["capacity"],
        moneyType: json["moneyType"],
        moveDateTime: json["moveDateTime"] ?? "",
        description: json["description"] ?? "",
        carModel: json["carModel"],
        carBrandName: json["carBrandName"] ?? "",
        sourceId: json["sourceId"],
        sourceName: json["sourceName"] ?? "",
        destinationId: json["destinationId"],
        haveNewReq: json["haveNewReq"] ?? false,
        destinationName: json["destinationName"] ?? "",
        createdDateTime: json["createdDateTime"] ?? "",
      );
}
