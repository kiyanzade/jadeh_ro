import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:jadehro_app/Common/Widgets/app_bar_widget.dart';
import 'package:jadehro_app/Config/constant.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../../Common/Controller/common_controller.dart';
import '../../Common/Widgets/alert_dialog_widget.dart';
import '../../Common/Widgets/button_widget.dart';
import '../../Config/api_client_config.dart';
import '../Controller/driver_controller.dart';

class TravelDetailDriverView extends StatelessWidget {
  const TravelDetailDriverView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(
          title: "جزئیات سفر", backgroundColor: Constants.driverColor),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: 24,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 24, bottom: 10),
              child: Row(
                children: [
                  const Text(
                    "شماره پیگیری: ",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    CommonController.to.tripDetailData.id.toString(),
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(0, 25, 25, 25),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                width: 30,
                                height: 30,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Constants.driverColor,
                                ),
                                child: const Icon(
                                  Icons.my_location,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                              Container(
                                height: 50,
                                width: 2,
                                color: Colors.black12,
                              ),
                              Container(
                                width: 30,
                                height: 30,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Constants.driverColor,
                                ),
                                child: const Icon(
                                  Icons.place,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "مبدا",
                                  style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  CommonController.to.tripDetailData.sourceName,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Container(
                                  color: Colors.black12,
                                  height: 2,
                                  width: 220,
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                const Text(
                                  "مقصد",
                                  style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  CommonController
                                      .to.tripDetailData.destinationName,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Container(
                        alignment: Alignment.center,
                        width: 150,
                        height: 40,
                        decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                                bottomRight: Radius.circular(16),
                                topRight: Radius.circular(16)),
                            color: Constants.driverColor.withOpacity(0.3)),
                        child: Text(
                          "${CommonController.to.tripDetailData.remainingCapacity}/${CommonController.to.tripDetailData.capacity} :ظرفیت باقی مانده",
                          style: const TextStyle(
                              color: Constants.driverColor,
                              fontSize: 12,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          LBox(
                            text1: "تاریخ حرکت",
                            text2:
                                CommonController.to.tripDetailData.moveDateTime,
                            icon: Icons.timelapse_rounded,
                            border: true,
                          ),
                          LBox(
                            text1: "ظرفیت کل",
                            text2: CommonController.to.tripDetailData.capacity
                                .toString(),
                            icon: Icons.person,
                            border: true,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          LBox(
                            text1: "مدل ماشین",
                            text2:
                                CommonController.to.tripDetailData.carBrandName,
                            icon: Icons.time_to_leave,
                            border: true,
                          ),
                          LBox(
                            text1: "قیمت",
                            text2: CommonController
                                        .to.tripDetailData.moneyType ==
                                    1
                                ? 'رایگان'
                                : CommonController
                                            .to.tripDetailData.moneyType ==
                                        2
                                    ? 'توافقی'
                                    : '${CommonController.to.tripDetailData.money.toString().seRagham()} تومان',
                            icon: Icons.wallet,
                            border: true,
                          ),
                        ],
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 35, right: 12),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Constants.driverColor),
                    ),
                    child: SizedBox(
                      width: Get.width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            CommonController
                                    .to.tripDetailData.description.isEmpty
                                ? 'توضیحات'
                                : CommonController
                                    .to.tripDetailData.description,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 14),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            CommonController.to.tripDetailData.description,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 42,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.fromLTRB(0, 0, 24, 12),
              height: 60,
              child: ElevatedButtonWidget(
                  onPressed: () async {
                    secondaryAlert(
                        buttonColor: Constants.driverColor,
                        context,
                        'اتمام سفر',
                        AlertType.warning,
                        "آیا از اتمام سفر خود اطمینان دارید؟",
                        'خیر',
                        "بله", () {
                      Get.back();
                    }, () async {
                      await DriverController.to.cancelTripForDriver(
                          tripId: CommonController.to.tripDetailData.id);
                    });
                  },
                  backgroundColor: Constants.driverColor,
                  child: const Text('اتمام سفر')),
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(24, 0, 24, 12),
            color: Constants.backgroundColor,
            height: 60,
            width: Get.width / 3,
            child: ElevatedButtonWidget(
              backgroundColor: Colors.red.shade800,
              onPressed: () async {
                secondaryAlert(
                  buttonColor: Constants.driverColor,
                  context,
                  'هشدار!',
                  AlertType.warning,
                  'آیا لغو سفر خود اطمینان دارید؟',
                  'خیر',
                  'بله',
                  () {
                    Get.back();
                  },
                  () async {
                    Get.back();
                    await DriverController.to.cancelTripForDriver(
                        tripId: CommonController.to.tripDetailData.id);
                  },
                );
              },
              child: showLoading.value
                  ? const SpinKitThreeBounce(
                      color: Colors.white,
                      size: 24.0,
                    )
                  : const Text(
                      'لغو',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class LBox extends StatelessWidget {
  final String text1;
  final String text2;
  final IconData icon;
  final bool border;
  const LBox({
    super.key,
    required this.text1,
    required this.text2,
    required this.icon,
    required this.border,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        alignment: Alignment.center,
        height: 70,
        width: 140,
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: 30,
              height: 30,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Constants.driverColor,
              ),
              child: Icon(
                icon,
                color: Colors.white,
                size: 20,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  text1,
                  style: const TextStyle(
                    color: Colors.black54,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 2,
                ),
                Text(
                  text2,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}


            // Row(
            //   children: [
            //     Expanded(
            //       child: SizedBox(
            //         height: 50,
            //         child: ElevatedButtonWidget(
            //           backgroundColor: Constants.driverColor,
            //           onPressed: () {},
            //           child: const Text(
            //             'ویرایش',
            //             style: TextStyle(
            //               fontSize: 14,
            //               fontWeight: FontWeight.bold,
            //             ),
            //           ),
            //         ),
            //       ),
            //     ),
            //     const SizedBox(
            //       width: 20,
            //     ),
            //     Obx(
            //       () => Expanded(
            //         child: SizedBox(
            //           height: 50,
            //           child: ElevatedButtonWidget(
            //             backgroundColor: Colors.red.shade800,
            //             onPressed: () async {
            //               secondaryAlert(
            //                 buttonColor: Constants.driverColor,
            //                 context,
            //                 'هشدار!',
            //                 AlertType.warning,
            //                 'آیا لغو سفر خود اطمینان دارید؟',
            //                 'خیر',
            //                 'بله',
            //                 () {
            //                   Get.back();
            //                 },
            //                 () async {
            //                   Get.back();
            //                   await DriverTripController.to.deleteTripForDriver(
            //                       tripId:
            //                           CommonController.to.tripDetailData.id);
            //                 },
            //               );
            //             },
            //             child: showLoading.value
            //                 ? const SpinKitThreeBounce(
            //                     color: Colors.white,
            //                     size: 24.0,
            //                   )
            //                 : const Text(
            //                     'لغو',
            //                     style: TextStyle(
            //                         fontSize: 14, fontWeight: FontWeight.bold),
            //                   ),
            //           ),
            //         ),
            //       ),
            //     ),
            //   ],
            // ),
