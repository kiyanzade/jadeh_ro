import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jadehro_app/Common/Controller/common_controller.dart';
import '../../Config/constant.dart';
import '../Model/trip_list_model.dart';

class TravelCard extends StatelessWidget {
  final TripListData travelModel;
  const TravelCard({super.key, required this.travelModel});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        await CommonController.to.getTripDetail(tripId: travelModel.id);
        Get.toNamed('/TravelDetailPassengerView');
      },
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.fromLTRB(10, 8, 10, 0),
            padding: const EdgeInsets.all(16),
            decoration: defaultBoxDeco,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "${travelModel.carBrandName} - مدل ${travelModel.carModel}",
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    Text(travelModel.moveDateTime)
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "مبدا",
                          style: TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                        Text(
                          travelModel.sourceName,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        )
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Text(
                          "مقصد",
                          style: TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                        Text(travelModel.destinationName,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16))
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 14),
            child: DottedLine(
              dashColor: Colors.grey,
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(10, 0, 10, 8),
            padding: const EdgeInsets.all(16),
            decoration: defaultBoxDeco,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Text(
                      "صندلی خالی:",
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(
                      travelModel.capacity.toString(),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Text(
                  travelModel.moneyType == 1 ? "صلواتی" : "توافقی",
                  style: const TextStyle(
                      color: Constants.passengerColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

final defaultBoxDeco = BoxDecoration(
  boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 5)],
  borderRadius: BorderRadius.circular(12),
  color: Colors.white,
);
