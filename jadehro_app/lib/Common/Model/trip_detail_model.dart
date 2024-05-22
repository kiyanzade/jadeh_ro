import 'dart:convert';

TripDetailModel tripDetailModelFromJson(String str) =>
    TripDetailModel.fromJson(json.decode(str));

class TripDetailModel {
  final TripDetailData data;

  TripDetailModel({
    required this.data,
  });

  factory TripDetailModel.fromJson(Map<String, dynamic> json) =>
      TripDetailModel(
        data: TripDetailData.fromJson(json["data"]),
      );
}

class TripDetailData {
  final int id;
  final int capacity;
  final int moneyType;
  final String moveDateTime;
  final String description;
  final int carModelId;
  final String carModelName;
  final String carBrandName;
  final int sourceId;
  final String sourceName;
  final int destinationId;
  final String destinationName;
  final String createdDateTime;

  TripDetailData({
    
    required this.id,
    required this.capacity,
    required this.moneyType,
    required this.moveDateTime,
    required this.description,
    required this.carModelId,
    required this.carModelName,
    required this.carBrandName,
    required this.sourceId,
    required this.sourceName,
    required this.destinationId,
    required this.destinationName,
    required this.createdDateTime,
  });

  factory TripDetailData.fromJson(Map<String, dynamic> json) => TripDetailData(
        id: json["id"] ?? 0,
        capacity: json["capacity"] ?? 0,
        moneyType: json["moneyType"] ?? 0,
        moveDateTime: json["moveDateTime"] ?? '',
        description: json["description"] ?? '',
        carModelId: json["carModelId"] ?? 0,
        carModelName: json["carModelName"] ?? '',
        carBrandName: json["carBrandName"] ?? '',
        sourceId: json["sourceId"] ?? 0,
        sourceName: json["sourceName"] ?? '',
        destinationId: json["destinationId"] ?? 0,
        destinationName: json["destinationName"] ?? '',
        createdDateTime: json["createdDateTime"] ?? '',
      );
}
