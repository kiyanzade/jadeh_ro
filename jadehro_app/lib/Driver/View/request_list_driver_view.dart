import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jadehro_app/Common/Model/trip_request_model.dart';
import 'package:jadehro_app/Common/Widgets/alert_dialog_widget.dart';
import 'package:jadehro_app/Common/Widgets/app_bar_widget.dart';
import 'package:jadehro_app/Common/Widgets/location.dart';
import 'package:jadehro_app/Common/Widgets/text_field_widget.dart';
import 'package:jadehro_app/Common/Widgets/travel_card_driver_widget.dart';
import 'package:jadehro_app/Config/constant.dart';
import 'package:jadehro_app/Driver/Controller/driver_controller.dart';
import 'package:latlong2/latlong.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import '../../Common/Widgets/button_widget.dart';
import '../../Common/Widgets/filters_widget.dart';

class RequestsListDriverView extends StatefulWidget {
  const RequestsListDriverView({super.key});

  @override
  State<RequestsListDriverView> createState() => _RequestsListDriverViewState();
}

class _RequestsListDriverViewState extends State<RequestsListDriverView> {
  @override
  void dispose() {
    selectedIdFilter.value = -1;
    DriverController.to.statusFilter = 0;
    DriverController.to.acceptOrRejectDescription.clear();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: appBarWidget(
          title: 'لیست درخواست‌ها',
          backgroundColor: Constants.driverColor,
        ),
        body: FutureBuilder(
          future: DriverController.to.getDriverRequestList(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CupertinoActivityIndicator());
            } else {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
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
                            DriverController.to.statusFilter = selectedIdFilter.value;
                          }
                        },
                        items: const {"در حال انتظار": 1, "تایید شده": 2, "رد شده": 3, "لغو شده": 4},
                      ))
                    ]),
                  ),
                  Obx(
                    () => Expanded(
                      child: (DriverController.to.driverReqTripList.isEmpty)
                          ? const Center(child: Text("آیتمی برای نمایش وجود ندارد."))
                          : ListView.builder(
                              shrinkWrap: true,
                              itemCount: DriverController.to.driverReqTripList.length,
                              itemBuilder: (context, index) {
                                final TripReqData tripReqData = DriverController.to.driverReqTripList[index];
                                return Container(
                                  margin: const EdgeInsets.all(8),
                                  padding: const EdgeInsets.symmetric(vertical: 16),
                                  decoration: defaultBoxDeco,
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(right: 16.0),
                                            child: Row(
                                              children: [
                                                const Text(
                                                  'نام و نام خانوادگی: ',
                                                  style: TextStyle(color: Colors.grey),
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
                                                borderRadius: const BorderRadius.only(
                                                    bottomRight: Radius.circular(16), topRight: Radius.circular(16)),
                                                color: (tripReqData.status == 1
                                                        ? Colors.amber
                                                        : tripReqData.status == 2
                                                            ? Colors.green.shade800
                                                            : tripReqData.status == 3
                                                                ? Colors.red.shade800
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
                                                          ? Colors.green.shade800
                                                          : tripReqData.status == 3
                                                              ? Colors.red.shade800
                                                              : Colors.red,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                        child: Row(
                                          children: [
                                            const Text(
                                              'تعداد صندلی درخواستی: ',
                                              style: TextStyle(color: Colors.grey),
                                            ),
                                            Text(tripReqData.personCount.toString()),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                        child: Row(
                                          children: [
                                            const Text(
                                              'آدرس مبدا: ',
                                              style: TextStyle(color: Colors.grey),
                                            ),
                                            const SizedBox(
                                              width: 4,
                                            ),
                                            Text(tripReqData.sourcePath),
                                            Visibility(
                                              visible: tripReqData.sourceLatitude != 0,
                                              child: IconButton(
                                                onPressed: () {
                                                  showMapLocation(LatLng(tripReqData.sourceLatitude,
                                                      tripReqData.sourceLongitude),
                                                  );
                                                },
                                                icon: const Icon(
                                                  Icons.location_on,
                                                  color: Constants.driverColor,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            const Text(
                                              'آدرس مقصد: ',
                                              style: TextStyle(color: Colors.grey),
                                            ),
                                            Text(tripReqData.destinationPath),
                                            Visibility(
                                              visible: tripReqData.destinationLatitude != 0,
                                              child: IconButton(
                                                onPressed: () {
                                                 showMapLocation(LatLng(tripReqData.destinationLatitude,
                                                      tripReqData.destinationLongitude),
                                                  );
                                                },
                                                icon: const Icon(
                                                  Icons.location_on,
                                                  color: Constants.driverColor,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      Container(
                                        width: Get.width,
                                        padding: const EdgeInsets.all(12),
                                        margin: const EdgeInsets.symmetric(horizontal: 16),
                                        decoration: BoxDecoration(
                                          color: Colors.grey.withOpacity(0.1),
                                          borderRadius: const BorderRadius.all(
                                            Radius.circular(16),
                                          ),
                                        ),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              'توضیحات',
                                              style: TextStyle(color: Colors.grey),
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
                                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              ElevatedButtonWidget(
                                                onPressed: () {
                                                  Get.bottomSheet(
                                                    SizedBox(
                                                      height: Get.height * 0.3,
                                                      child: Column(
                                                        children: [
                                                          Padding(
                                                            padding: const EdgeInsets.symmetric(
                                                                horizontal: 16.0, vertical: 8.0),
                                                            child: Row(
                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                              children: [
                                                                const Text(
                                                                  "تایید درخواست",
                                                                  style: TextStyle(
                                                                      fontWeight: FontWeight.w600, fontSize: 16),
                                                                ),
                                                                IconButton(
                                                                  onPressed: () => Get.back(),
                                                                  icon: const Icon(Icons.close),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                                            child: SizedBox(
                                                              width: Get.width,
                                                              child: TextFormFieldWidget(
                                                                labelText: "توضیحات",
                                                                maxLines: 5,
                                                                controller:
                                                                    DriverController.to.acceptOrRejectDescription,
                                                              ),
                                                            ),
                                                          ),
                                                          const Spacer(),
                                                          Padding(
                                                            padding: const EdgeInsets.all(16.0),
                                                            child: ElevatedButtonWidget(
                                                                fixedSize: Size(Get.width, 55),
                                                                onPressed: () {
                                                                  secondaryAlert(
                                                                      context,
                                                                      'هشدار',
                                                                      AlertType.warning,
                                                                      'آیا از تایید مسافر اطمینان دارید؟',
                                                                      "خیر",
                                                                      "بله", () {
                                                                    Get.back();
                                                                  }, () async {
                                                                    await DriverController.to
                                                                        .driverAccept(tripReqData.id);
                                                                  }, buttonColor: Constants.driverColor);
                                                                },
                                                                backgroundColor: Constants.driverColor,
                                                                child: const Text("تایید مسافر")),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                    backgroundColor: Colors.white,
                                                    barrierColor: Colors.black.withOpacity(0.7),
                                                    shape: const RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.only(
                                                        topLeft: Radius.circular(10),
                                                        topRight: Radius.circular(10),
                                                      ),
                                                    ),
                                                    enableDrag: true,
                                                    isDismissible: true,
                                                    isScrollControlled: true,
                                                    elevation: 0,
                                                  );
                                                },
                                                backgroundColor: Constants.driverColor,
                                                child: const Text("تایید مسافر "),
                                              ),
                                              ElevatedButtonWidget(
                                                onPressed: () {
                                                  Get.bottomSheet(
                                                    SizedBox(
                                                      height: Get.height * 0.3,
                                                      child: Column(
                                                        children: [
                                                          Padding(
                                                            padding: const EdgeInsets.symmetric(
                                                                horizontal: 16.0, vertical: 8.0),
                                                            child: Row(
                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                              children: [
                                                                const Text(
                                                                  "رد درخواست",
                                                                  style: TextStyle(
                                                                      fontWeight: FontWeight.w600, fontSize: 16),
                                                                ),
                                                                IconButton(
                                                                  onPressed: () => Get.back(),
                                                                  icon: const Icon(Icons.close),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                                            child: SizedBox(
                                                              width: Get.width,
                                                              child: TextFormFieldWidget(
                                                                labelText: "توضیحات",
                                                                maxLines: 5,
                                                                controller:
                                                                    DriverController.to.acceptOrRejectDescription,
                                                              ),
                                                            ),
                                                          ),
                                                          const Spacer(),
                                                          Padding(
                                                            padding: const EdgeInsets.all(16),
                                                            child: ElevatedButtonWidget(
                                                                fixedSize: Size(Get.width, 55),
                                                                onPressed: () {
                                                                  secondaryAlert(context, 'هشدار', AlertType.warning,
                                                                      'آیا از رد سفر اطمینان دارید؟', "خیر", "بله", () {
                                                                    Get.back();
                                                                  }, () async {
                                                                    await DriverController.to
                                                                        .driverReject(tripReqData.id);
                                                                  }, buttonColor: Constants.driverColor);
                                                                },
                                                                backgroundColor: Constants.redColor,
                                                                child: const Text("رد درخواست")),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                    backgroundColor: Colors.white,
                                                    barrierColor: Colors.black.withOpacity(0.7),
                                                    shape: const RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.only(
                                                        topLeft: Radius.circular(10),
                                                        topRight: Radius.circular(10),
                                                      ),
                                                    ),
                                                    enableDrag: true,
                                                    isDismissible: true,
                                                    isScrollControlled: true,
                                                    elevation: 0,
                                                  );
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
                            ),
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
