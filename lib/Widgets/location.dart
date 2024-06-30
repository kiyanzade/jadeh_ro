import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:jadehro_app/Config/constant.dart';
import 'package:latlong2/latlong.dart';
import 'package:open_street_map_search_and_pick/open_street_map_search_and_pick.dart';

class FlutterMapLoc extends StatelessWidget {
  final LatLng latLong;

  const FlutterMapLoc({super.key, required this.latLong});
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: FlutterMap(
            // ignore: deprecated_member_use
            options: MapOptions(
              initialCenter: latLong,
              initialZoom: 15.0,
              maxZoom: 18,
              minZoom: 6,
            ),
            mapController: MapController(),

            children: [
              TileLayer(
                urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                subdomains: const ['a', 'b', 'c'],

                // attributionBuilder: (_) {
                //   return Text("© OpenStreetMap contributors");
                // },
              ),
              MarkerLayer(
                markers: [
                  Marker(
                    width: 80.0,
                    height: 80.0,
                    point: latLong,
                    child: const Icon(
                      Icons.location_on,
                      color: Constants.driverColor,
                      size: 40,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

Future<PickedData?> pickLocationBottomSheet() async {
  PickedData? pickedData;
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
                hintText: 'جستجوی موقعیت',
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

void showMapLocation(LatLng latlng) {
  Get.bottomSheet(
    SizedBox(
      height: Get.height * 0.7,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 8, 12, 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'موقعیت مکانی',
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
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: FlutterMapLoc(
                latLong: latlng,
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
}
