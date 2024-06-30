import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinbox/flutter_spinbox.dart';
import 'package:get/get.dart';
import 'package:jadehro_app/Common/Controller/common_controller.dart';
import 'package:jadehro_app/Common/Widgets/alert_dialog_widget.dart';
import 'package:jadehro_app/Common/Widgets/app_bar_widget.dart';
import 'package:jadehro_app/Common/Widgets/location.dart';
import 'package:jadehro_app/Common/Widgets/text_field_widget.dart';
import 'package:jadehro_app/Config/constant.dart';
import 'package:jadehro_app/Passenger/Controller/passenger_trip_controller.dart';
import 'package:open_street_map_search_and_pick/open_street_map_search_and_pick.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Common/Widgets/button_widget.dart';

class TravelDetailPassengerView extends StatelessWidget {
  const TravelDetailPassengerView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(
        backgroundColor: Constants.passengerColor,
        title: "جزئیات سفر",
      ),
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
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.all(25),
              child: Column(
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
                              color: Constants.passengerColor,
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
                              color: Constants.passengerColor,
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
                            text1: "ظرفیت",
                            text2: CommonController
                                .to.tripDetailData.remainingCapacity
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
                            text2:
                                CommonController.to.tripDetailData.moneyType ==
                                        1
                                    ? 'رایگان'
                                    : 'توافقی',
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
                    margin: const EdgeInsets.symmetric(horizontal: 12),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Constants.passengerColor),
                    ),
                    child: SizedBox(
                      width: Get.width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "توضیحات",
                            style: TextStyle(
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
      floatingActionButton: Container(
        padding: const EdgeInsets.fromLTRB(24, 0, 24, 12),
        color: Constants.backgroundColor,
        child: SizedBox(
          height: 50,
          width: Get.width,
          child: ElevatedButtonWidget(
            backgroundColor: Constants.passengerColor,
            onPressed: () async {
              final SharedPreferences preferences =
                  await SharedPreferences.getInstance();
              await preferences.setInt(
                  "tripId", CommonController.to.tripDetailData.id);

              final bool isTokenExist = preferences.getString("token") != null;
              if (isTokenExist) {
                paasengerRequestBottomSheet(Get.arguments);
              } else {
                Get.toNamed('/RegisterPassengerView');
              }
            },
            child: const Text(
              'درخواست به راننده',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  void paasengerRequestBottomSheet(int tripId) {
    Get.bottomSheet(
      SizedBox(
        height: Get.height * 0.7,
        child: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "درخواست به راننده",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                  IconButton(
                    onPressed: () => Get.back(),
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "آدرس مبدا: ",
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Expanded(
                        child: TextFormFieldWidget(
                          maxLines: 2,
                          suffixIcon: InkWell(
                            onTap: () async {
                              PickedData? pickedData =
                                  await pickLocationBottomSheet();
                              if (pickedData != null) {
                                PassengerTripController.to.sourcePath.text =
                                    '${pickedData.address['city'] ?? ''}, '
                                    '${pickedData.address['neighbourhood'] ?? ''}, '
                                    '${pickedData.address['road'] ?? ''}, '
                                    '${pickedData.address['amenity'] ?? ''}';

                                PassengerTripController.to.sourceLatitude =
                                    pickedData.latLong.latitude;
                                PassengerTripController.to.sourceLongitude =
                                    pickedData.latLong.longitude;
                              } else {
                                // snackBarWidget(
                                //     messageText: 'خطایی رخ داده است',
                                //     type: SnackBarWidgetType.failure);
                              }
                            },
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Icon(Icons.location_on,
                                    color: Constants.passengerColor),
                                SizedBox(
                                  width: 4,
                                ),
                                Text(
                                  'انتخاب از روی نقشه',
                                  style: TextStyle(
                                      color: Constants.passengerColor,
                                      fontSize: 10),
                                ),
                                SizedBox(
                                  width: 8,
                                )
                              ],
                            ),
                          ),
                          suffixIconConstraints:
                              const BoxConstraints(maxWidth: 120),
                          controller: PassengerTripController.to.sourcePath,
                          labelText: 'محدوده آدرس',
                          enabled: true,
                          readOnly: false,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "آدرس مقصد: ",
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Expanded(
                        child: TextFormFieldWidget(
                          maxLines: 2,
                          suffixIcon: InkWell(
                            onTap: () async {
                              PickedData? pickedData =
                                  await pickLocationBottomSheet();
                              if (pickedData != null) {
                                PassengerTripController
                                        .to.destinationPath.text =
                                    '${pickedData.address['city'] ?? ''}, '
                                    '${pickedData.address['neighbourhood'] ?? ''}, '
                                    '${pickedData.address['road'] ?? ''}, '
                                    '${pickedData.address['amenity'] ?? ''}';
                                PassengerTripController.to.destinationLatitude =
                                    pickedData.latLong.latitude;
                                PassengerTripController
                                        .to.destinationLongitude =
                                    pickedData.latLong.longitude;
                              } else {
                                // snackBarWidget(
                                //     messageText: 'خطایی رخ داده است',
                                //     type: SnackBarWidgetType.failure);
                              }
                            },
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Icon(Icons.location_on,
                                    color: Constants.passengerColor),
                                SizedBox(
                                  width: 4,
                                ),
                                Text(
                                  'انتخاب از روی نقشه',
                                  style: TextStyle(
                                      color: Constants.passengerColor,
                                      fontSize: 10),
                                ),
                                SizedBox(
                                  width: 8,
                                )
                              ],
                            ),
                          ),
                          suffixIconConstraints:
                              const BoxConstraints(maxWidth: 120),
                          controller:
                              PassengerTripController.to.destinationPath,
                          labelText: 'محدوده آدرس',
                          enabled: true,
                          readOnly: false,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "ظرفیت درخواستی: ",
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      Obx(
                        () => SizedBox(
                          width: 200,
                          height: 50,
                          child: SpinBox(
                            iconColor:
                                const WidgetStatePropertyAll(Colors.grey),
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                borderSide: BorderSide(
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                            min: 1,
                            max: PassengerTripController.to.spinMax.value
                                .toDouble(),
                            value: PassengerTripController.to.spinValue.value
                                .toDouble(),
                            onChanged: (value) {
                              PassengerTripController.to.reqCapacity =
                                  value.toInt();
                              PassengerTripController.to.spinValue.value =
                                  value.toInt();
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "توضیحات: ",
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      TextFormFieldWidget(
                        controller: PassengerTripController.to.descriptionReq,
                        maxLines: 5,
                        labelText: 'توضیحات',
                      )
                    ],
                  ),
                ],
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButtonWidget(
                  onPressed: () {
                    secondaryAlert(
                        Get.context!,
                        'ارسال درخواست',
                        AlertType.warning,
                        'آیا از ارسال درخواست خود اطمینان دارید؟',
                        "خیر",
                        "بله", () {
                      Get.back();
                    }, () {
                      Get.back();
                      Get.back();
                      PassengerTripController.to.sendRequestPassenger(tripId);
                    }, buttonColor: Constants.passengerColor);
                  },
                  fixedSize: Size(Get.width, 55),
                  backgroundColor: Constants.passengerColor,
                  child: const Text("ارسال درخواست")),
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
                color: Constants.passengerColor,
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
