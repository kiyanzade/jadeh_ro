import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:jadehro_app/Common/Model/trip_request_model.dart';
import 'package:jadehro_app/Common/Widgets/snack_bar_widget.dart';
import 'package:jadehro_app/Config/api_client_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Common/Model/trip_list_model.dart';

class PassengerTripController extends GetxController {
  final ApiClient apiClient = ApiClient();
  static PassengerTripController get to =>
      Get.put<PassengerTripController>(PassengerTripController(),
          permanent: true); // TODO
  RxList<TripListData> passengerTripList = <TripListData>[].obs;
  final TextEditingController tripSearchController = TextEditingController();
  RxInt selectedMoneyType = 0.obs;
  int selectedCarBrand = 0;
  int selectedSourceProvinceId = 0;
  int selectedDestinationProvinceId = 0;
  int selectedSourceId = 0;
  int selectedDestinationId = 0;
  int selectedCapacity = 1;
  int reqStatusFilter = 0;
  int tripListIndex = 0;
  String selectedFromDate = '';
  RxString selectedBrand = 'همه ماشین‌ها'.obs;
  RxString selectedSourceCity = ''.obs;
  RxString selectedDestinationProvince = 'همه استان‌ها'.obs;
  RxString selectedSourceProvince = ''.obs;
  RxString selectedDestinationCity = ''.obs;

  RxList<TripReqData> passengerReqTripList = <TripReqData>[].obs;

  RxInt spinValue = 1.obs;
  RxInt spinMax = 4.obs;
  int reqCapacity = 4;

  double sourceLatitude = 0;
  double sourceLongitude = 0;
  double destinationLatitude = 0;
  double destinationLongitude = 0;

  final TextEditingController selectedFromDateController =
      TextEditingController();
  final TextEditingController sourcePath = TextEditingController();
  final TextEditingController destinationPath = TextEditingController();
  final TextEditingController descriptionReq = TextEditingController();

  Future<void> getPassengerTripList() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    final int selectedSourceProvinceId =
        preferences.getInt('selectedSourceProvinceId') ?? 0;
    final String response = await apiClient.httpResponse(
      urlPath:
          'Trip/Pending?Search=${tripSearchController.text}&MoneyType=${selectedMoneyType.value}&CarBrandId=$selectedCarBrand&SourceProvinceId=$selectedSourceProvinceId&DestinationProvinceId=$selectedDestinationProvinceId&SourceId=$selectedSourceId&DestinationId=$selectedDestinationId&Capacity=$selectedCapacity&FromDate=${selectedFromDateController.text}&index=$tripListIndex&count=5',
      httpMethod: HttpMethod.get,
      needToken: false,
    );
    if (response.isNotEmpty) {
      final TripListModel result = tripListModelFromJson(response);
      passengerTripList.addAll(result.data);
    }
  }

  Future<void> getPassengerTripRequestList() async {
    final String response = await apiClient.httpResponse(
      urlPath:
          'Trip/PassengerRequests?status=$reqStatusFilter&index=0&count=20',
      httpMethod: HttpMethod.get,
    );
    if (response.isNotEmpty) {
      final TripReqModel result = tripReqModelFromJson(response);
      passengerReqTripList.value = result.data;
    }
  }

  Future<void> cancelRequest(int tripId) async {
    EasyLoading.show();
    final String response = await apiClient.httpResponse(
      urlPath: 'Trip/CancelRequest?tripReqId=$tripId',
      httpMethod: HttpMethod.put,
    );
    EasyLoading.dismiss();
    if (response.isNotEmpty) {
      Get.back();
      snackBarWidget(
          messageText: 'لغو درخواست با موفقیت انجام شد.',
          type: SnackBarWidgetType.success);
      await getPassengerTripRequestList();
    }
  }

  Future<void> sendRequestPassenger(int tripId) async {
    EasyLoading.show();
    final String response = await apiClient.httpResponse(
      urlPath: 'Trip/SendRequest',
      httpMethod: HttpMethod.post,
      body: {
        "tripId": tripId,
        "personCount": reqCapacity,
        "reqDescription": descriptionReq.text,
        "sourcePath": sourcePath.text,
        "sourceLatitude": sourceLatitude,
        "sourceLongitude": sourceLongitude,
        "DestinationPath": destinationPath.text,
        "DestinationLatitude": destinationLatitude,
        "DestinationLongitude": destinationLongitude,
      },
    );
    EasyLoading.dismiss();
    if (response.isNotEmpty) {
      Get.back();
      snackBarWidget(
          messageText: 'ارسال درخواست با موفقیت انجام شد.',
          type: SnackBarWidgetType.success);
    }
    reqCapacity = 4; // TODO Define a separate controller for request
    sourcePath.clear();
    descriptionReq.clear();
    destinationPath.clear();
    sourceLatitude = 0;
    sourceLongitude = 0;
    destinationLatitude = 0;
    destinationLongitude = 0;
  }
}
