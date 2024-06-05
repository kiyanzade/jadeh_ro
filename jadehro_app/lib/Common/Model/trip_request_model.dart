import 'dart:convert';

TripReqModel tripReqModelFromJson(String str) =>
    TripReqModel.fromJson(json.decode(str));

class TripReqModel {
  final List<TripReqData> data;

  TripReqModel({
    required this.data,
  });

  factory TripReqModel.fromJson(Map<String, dynamic> json) => TripReqModel(
        data: List<TripReqData>.from(
            json["data"].map((x) => TripReqData.fromJson(x))),
      );
}

class TripReqData {
  final int id;
  final bool isActive;
  final int status;
  final String reqDateTime;
  final String address;
  final String acceptOrRejectDateTime;
  final int personCount;
  final String reqDescription;
  final String acceptOrRejectDescription;
  final String userFullName;
  final Trip trip;

  TripReqData({
    required this.id,
    required this.address,
    required this.isActive,
    required this.status,
    required this.reqDateTime,
    required this.acceptOrRejectDateTime,
    required this.personCount,
    required this.reqDescription,
    required this.acceptOrRejectDescription,
    required this.userFullName,
    required this.trip,
  });

  factory TripReqData.fromJson(Map<String, dynamic> json) => TripReqData(
        id: json["id"],
        isActive: json["isActive"],
        status: json["status"],
        reqDateTime: json["reqDateTime"],
        acceptOrRejectDateTime: json["acceptOrRejectDateTime"],
        personCount: json["personCount"],
        reqDescription: json["reqDescription"],
        acceptOrRejectDescription: json["acceptOrRejectDescription"],
        userFullName: json["userFullName"],
        address: json["address"] ?? "",
        trip: Trip.fromJson(json["trip"]),
      );
}

class Trip {
  final int id;
  final bool isActive;
  final int status;
  final int moneyType;
  final int money;
  final String moveDateTime;
  final String description;
  final bool isNewReq;
  final int capacity;
  final int fillCapacity;
  final int remainingCapacity;
  final int carModel;
  final int carBrandId;
  final String carBrandName;
  final int sourceId;
  final String sourceName;
  final int destinationId;
  final String destinationName;
  final String createdDateTime;

  Trip({
    required this.id,
    required this.isActive,
    required this.status,
    required this.moneyType,
    required this.money,
    required this.moveDateTime,
    required this.description,
    required this.isNewReq,
    required this.capacity,
    required this.fillCapacity,
    required this.remainingCapacity,
    required this.carModel,
    required this.carBrandId,
    required this.carBrandName,
    required this.sourceId,
    required this.sourceName,
    required this.destinationId,
    required this.destinationName,
    required this.createdDateTime,
  });

  factory Trip.fromJson(Map<String, dynamic> json) => Trip(
        id: json["id"],
        isActive: json["isActive"],
        status: json["status"],
        moneyType: json["moneyType"],
        money: json["money"],
        moveDateTime: json["moveDateTime"],
        description: json["description"],
        isNewReq: json["isNewReq"],
        capacity: json["capacity"],
        fillCapacity: json["fillCapacity"],
        remainingCapacity: json["remainingCapacity"],
        carModel: json["carModel"],
        carBrandId: json["carBrandId"],
        carBrandName: json["carBrandName"],
        sourceId: json["sourceId"],
        sourceName: json["sourceName"],
        destinationId: json["destinationId"],
        destinationName: json["destinationName"],
        createdDateTime: json["createdDateTime"],
      );
}
