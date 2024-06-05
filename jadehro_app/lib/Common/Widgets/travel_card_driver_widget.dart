import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jadehro_app/Common/Widgets/button_widget.dart';

import 'package:lottie/lottie.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
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
                          ),
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
                              : '${travelData.money.toString().seRagham()} تومان',
                      style: const TextStyle(
                        color: Constants.driverColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    const Text('وضعیت: '),
                    Text(
                      travelData.tripStatus == 1
                          ? "در انتظار مسافر"
                          : travelData.tripStatus == 2
                              ? "اتمام سفر"
                              : "لفو شده",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: travelData.tripStatus == 1
                            ? Colors.yellow.shade700
                            : travelData.tripStatus == 2
                                ? Constants.driverColor
                                : Colors.red,
                      ),
                    )
                  ],
                ),
                Divider(
                  color: Colors.grey.shade300,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButtonWidget(
                      onPressed: () {
                        Get.toNamed('/RequestsDriverView');
                      },
                      backgroundColor: Constants.driverColor,
                      child: const Text('درخواست‌ها'),
                    ),
                    Visibility(
                      visible: travelData.haveNewReq,
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: Colors.grey.shade100,
                        ),
                        child: Row(
                          children: [
                            Lottie.asset('assets/Images/bell.json', height: 20),
                            const Text("درخواست جدید"),
                          ],
                        ),
                      ),
                    ),
                  ],
                )
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
