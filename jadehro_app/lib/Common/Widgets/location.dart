import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jadehro_app/Config/constant.dart';
import 'package:open_street_map_search_and_pick/open_street_map_search_and_pick.dart';

Future<PickedData?> pickLocationBottomSheet() async {
  PickedData ? pickedData;
  await Get.bottomSheet(
    // TODO bottom sheet custom height
    SizedBox(
      height: Get.height * 0.8,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 8, 12, 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'انتخاب موقعیت مکانی',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                IconButton(
                  onPressed: () => Get.back(),
                  icon: const Icon(Icons.close),
                )
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(8.0),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(32),
                  topRight: Radius.circular(32),
                ),
              ),
              child: OpenStreetMapSearchAndPick(
                buttonColor: Constants.passengerColor,
                buttonText: 'انتخاب موقعیت مکانی',
                locationPinText: '',
                
                baseUri: 'https://nominatim.openstreetmap.org',
                locationPinIconColor: Constants.passengerColor,
                onPicked: (pickData) {
                  Get.back();
                   pickedData = pickData;
                },
              ),
            ),
          ),
        ],
      ),
    ),
    enableDrag: true,
    isDismissible: true,
    isScrollControlled: true,
    backgroundColor: Constants.backgroundColor,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
    elevation: 0,
  );
  return pickedData;
}
