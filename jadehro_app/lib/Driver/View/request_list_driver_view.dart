import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jadehro_app/Common/Model/trip_request_model.dart';
import 'package:jadehro_app/Common/Widgets/alert_dialog_widget.dart';
import 'package:jadehro_app/Common/Widgets/app_bar_widget.dart';

import 'package:jadehro_app/Common/Widgets/travel_card_driver_widget.dart';
import 'package:jadehro_app/Config/constant.dart';
import 'package:jadehro_app/Driver/Controller/driver_controller.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../../Common/Widgets/button_widget.dart';
import '../../Common/Widgets/filters_widget.dart';

class RequestsListDriverView extends StatelessWidget {
  const RequestsListDriverView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: appBarWidget(
          title: 'لیست درخواست ها',
          backgroundColor: Constants.driverColor,
        ),
        body: FutureBuilder(
          future: DriverController.to.getDriverRequestList(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 4),
                    child: Row(children: [
                      const Text(
                        'فیلترها: ',
                      ),
                      Expanded(
                          child: FilterChipWidget(
                        everyCall: () async {
                          DriverController.to.driverReqTripList.clear();
                          await DriverController.to.getDriverRequestList();
                        },
                        onSelected: () {
                          if (selectedIdFilter.value == -1) {
                            DriverController.to.statusFilter = 0;
                          } else {
                            DriverController.to.statusFilter =
                                selectedIdFilter.value;
                          }
                        },
                        items: const {
                          "در حال انتظار": 1,
                          "تایید شده": 2,
                          "رد شده": 3,
                          "لغو شده": 4
                        },
                      ))
                    ]),
                  ),
                  Expanded(
                    child: (DriverController.to.driverReqTripList.isEmpty)
                        ? const Center(
                            child: Text("آیتمی برای نمایش وجود ندارد."))
                        : Obx(() => ListView.builder(
                              shrinkWrap: true,
                              itemCount:
                                  DriverController.to.driverReqTripList.length,
                              itemBuilder: (context, index) {
                                final TripReqData tripReqData = DriverController
                                    .to.driverReqTripList[index];
                                return Container(
                                  margin: const EdgeInsets.all(8),
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 16),
                                  decoration: defaultBoxDeco,
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 16.0),
                                            child: Row(
                                              children: [
                                                const Text(
                                                  'نام و نام خانوادگی: ',
                                                  style: TextStyle(
                                                      color: Colors.grey),
                                                ),
                                                Text(tripReqData.userFullName)
                                              ],
                                            ),
                                          ),
                                          Container(
                                            alignment: Alignment.center,
                                            width: 80,
                                            height: 35,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    const BorderRadius.only(
                                                        bottomRight:
                                                            Radius.circular(16),
                                                        topRight:
                                                            Radius.circular(
                                                                16)),
                                                color: (tripReqData.status == 1
                                                        ? Colors.amber
                                                        : tripReqData.status ==
                                                                2
                                                            ? Colors
                                                                .green.shade800
                                                            : tripReqData
                                                                        .status ==
                                                                    3
                                                                ? Colors.red
                                                                    .shade800
                                                                : Colors.red)
                                                    .withOpacity(0.2)),
                                            child: Text(
                                              tripReqData.status == 1
                                                  ? "در حال انتظار"
                                                  : tripReqData.status == 2
                                                      ? "تایید شده"
                                                      : tripReqData.status == 3
                                                          ? "رد شده"
                                                          : "لغو شده",
                                              style: TextStyle(
                                                  color: tripReqData.status == 1
                                                      ? Colors.amber
                                                      : tripReqData.status == 2
                                                          ? Colors
                                                              .green.shade800
                                                          : tripReqData
                                                                      .status ==
                                                                  3
                                                              ? Colors
                                                                  .red.shade800
                                                              : Colors.red,
                                                  fontSize: 12),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                const Text(
                                                  'حدود آدرس: ',
                                                  style: TextStyle(
                                                      color: Colors.grey),
                                                ),
                                                const SizedBox(
                                                  width: 4,
                                                ),
                                                Text(tripReqData.address)
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                const Text(
                                                  'تعداد صندلی درخواستی: ',
                                                  style: TextStyle(
                                                      color: Colors.grey),
                                                ),
                                                Text(tripReqData.personCount
                                                    .toString()),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      Container(
                                        padding: const EdgeInsets.all(12),
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 16),
                                        decoration: BoxDecoration(
                                          color: Colors.grey.withOpacity(0.1),
                                          borderRadius: const BorderRadius.all(
                                            Radius.circular(16),
                                          ),
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              'توضیحات',
                                              style:
                                                  TextStyle(color: Colors.grey),
                                            ),
                                            const SizedBox(
                                              height: 8,
                                            ),
                                            Text(tripReqData.reqDescription)
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 12,
                                      ),
                                      Visibility(
                                        visible: tripReqData.status == 1,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 16.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              ElevatedButtonWidget(
                                                onPressed: () {
                                                  secondaryAlert(
                                                      context,
                                                      'هشدار',
                                                      AlertType.warning,
                                                      'آیا از تایید سفر اطمینان دارید؟',
                                                      "خیر",
                                                      "بله", () {
                                                    Get.back();
                                                  }, () async {
                                                    await DriverController.to
                                                        .driverAccept(
                                                            tripReqData.id);
                                                  });
                                                },
                                                backgroundColor:
                                                    Constants.driverColor,
                                                child:
                                                    const Text("تایید مسافر "),
                                              ),
                                              ElevatedButtonWidget(
                                                onPressed: () {
                                                  secondaryAlert(
                                                      context,
                                                      'هشدار',
                                                      AlertType.warning,
                                                      'آیا از رد سفر اطمینان دارید؟',
                                                      "خیر",
                                                      "بله", () {
                                                    Get.back();
                                                  }, () async {
                                                    await DriverController.to
                                                        .driverReject(
                                                            tripReqData.id);
                                                  });
                                                },
                                                backgroundColor: Colors.red,
                                                child: const Text("رد درخواست"),
                                              )
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              },
                            )),
                  )
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
