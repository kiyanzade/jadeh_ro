import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jadehro_app/Config/constant.dart';
import 'package:jadehro_app/Driver/Controller/driver_trip_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher_string.dart';

import 'button_widget.dart';

void driverInfoDialog() async {
  final SharedPreferences preferences = await SharedPreferences.getInstance();
  final tripId = preferences.getInt("tripId");
  await DriverTripController.to.getDriverInfo(tripId: tripId!);
  Get.defaultDialog(
    title: 'مشخصات راننده',
    titleStyle: const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
    ),
    radius: 10,
    barrierDismissible: true,
    contentPadding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
    content: SingleChildScrollView(
      child: Column(
        children: <Widget>[
          // Row(
          //   children: [
          //     const Text(
          //       'نام:',
          //     ),
          //     const SizedBox(
          //       width: 8,
          //     ),
          //     Text(
          //       DriverTripController.to.driverInfoData.fullName,
          //       style: const TextStyle(
          //         fontWeight: FontWeight.bold,
          //       ),
          //     ),
          //   ],
          // ),
          // const SizedBox(
          //   height: 20,
          // ),
          Row(
            children: [
              const Text(
                'شماره تماس:',
              ),
              const SizedBox(
                width: 8,
              ),
              Text(
                DriverTripController.to.driverInfoData.phoneNumber,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButtonWidget(
                onPressed: () {
                  Get.back();
                },
                fixedSize: const Size(85, 35),
                backgroundColor: Colors.red.shade800,
                child: const Text(
                  'بستن',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                  textScaler: TextScaler.noScaling,
                ),
              ),
              ElevatedButtonWidget(
                onPressed: () {
                  launchUrlString(
                    "tel:${DriverTripController.to.driverInfoData.phoneNumber}",
                  );
                },
                fixedSize: const Size(85, 35),
                backgroundColor: Constants.passengerColor,
                child: const Text(
                  'تماس',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                  textScaler: TextScaler.noScaling,
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
