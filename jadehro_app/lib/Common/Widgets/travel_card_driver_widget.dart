import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Config/constant.dart';
import '../Controller/common_controller.dart';
import '../Model/trip_list_model.dart';

class TravelCardDriver extends StatelessWidget {
  final TripListData travelData;
  const TravelCardDriver({
    super.key,
    required this.travelData,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        await CommonController.to.getTripDetail(tripId: travelData.id);
        Get.toNamed('/TravelDetailDriverView');
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
                  children: [
                    Text(
                      "${travelData.carBrandName} - مدل ${travelData.carModel}",
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    Text(travelData.moveDateTime)
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "مبدا",
                            style: TextStyle(color: Colors.grey, fontSize: 12),
                          ),
                          Text(
                            travelData.sourceName,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          )
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Text(
                          "مقصد",
                          style: TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                        Text(travelData.destinationName,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16))
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
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
                          travelData.capacity.toString(),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Text(
                      travelData.moneyType == 1
                          ? "رایگان"
                          : travelData.moneyType == 2
                              ? "توافقی"
                              : '15000 تومان',
                      style: const TextStyle(
                        color: Constants.driverColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

final defaultBoxDeco = BoxDecoration(
  boxShadow: [
    BoxShadow(
      color: Colors.black.withOpacity(0.1),
      blurRadius: 5,
    ),
  ],
  borderRadius: BorderRadius.circular(12),
  color: Colors.white,
);
