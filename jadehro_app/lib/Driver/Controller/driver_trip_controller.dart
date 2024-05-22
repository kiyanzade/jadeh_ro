import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jadehro_app/Common/Widgets/snack_bar_widget.dart';
import 'package:jadehro_app/Config/api_client_config.dart';

import '../../Common/Model/trip_list_model.dart';
import '../Model/driver_info_model.dart';

class DriverTripController extends GetxController {
  final ApiClient apiClient = ApiClient();
  static DriverTripController get to =>
      Get.put<DriverTripController>(DriverTripController());
  List<TripListData> driverTripList = <TripListData>[].obs;
  final TextEditingController tripSearchController = TextEditingController();
  RxInt selectedMoneyType = 1.obs;
  int filterMoneyType = 0;
  int selectedCarBrand = 0;
  int selectedSourceProvinceId = 0;
  int selectedDestinationProvinceId = 0;
  int selectedSourceCityId = 0;
  int selectedDestinationCityId = 0;
  int selectedCapacity = 1;
  int tripListIndex = 0;
  RxInt spinValue = 1.obs;
  RxInt spinMax = 4.obs;
  final TextEditingController selectedFromDateController =
      TextEditingController();
  final TextEditingController selectedDescription = TextEditingController();

  DriverInfoData driverInfoData = DriverInfoData(fullName: '', phoneNumber: '');

  RxInt selectedCarType = 1.obs;
  RxString selectedBrand = ''.obs;
  RxString selectedModel = ''.obs;
  RxString selectedSourceProvince = ''.obs;
  RxString selectedSourceCity = ''.obs;
  RxString selectedDestinationProvince = ''.obs;
  RxString selectedDestinationCity = ''.obs;

  Future<void> addTripForDriver() async {
    final String response = await apiClient.httpResponse(
      urlPath: 'Trip/Add',
      httpMethod: HttpMethod.post,
      body: {
        "capacity": selectedCapacity,
        "moneyType": selectedMoneyType.value,
        "moveDateTime": selectedFromDateController.text,
        "description": selectedDescription.text,
        "carModel": int.parse(selectedModel.value),
        "carBrandId": selectedCarBrand,
        "sourceId": selectedSourceCityId,
        "destinationId": selectedDestinationCityId
      },
      needLoading: true,
    );
    if (response.isNotEmpty) {
      Get.offAllNamed('MainScreenDriverView');
      snackBarWidget(
          messageText: 'سفر شما با موفقیت ثبت شد.',
          type: SnackBarWidgetType.success);
    }
  }

  Future<void> editTripForDriver() async {
    final String response = await apiClient.httpResponse(
      urlPath: 'Trip/Edit',
      httpMethod: HttpMethod.put,
      body: {
        "id": 0,
        "isActive": true,
        "capacity": 0,
        "moneyType": 1,
        "moveDateTime": "2023-08-15T07:50:49.489Z",
        "description": "string",
        "carModelId": 0,
        "sourceId": 0,
        "destinationId": 0
      },
      needLoading: true,
    );
    if (response.isNotEmpty) {
      snackBarWidget(
          messageText: 'سفر شما با موفقیت ویرایش شد.',
          type: SnackBarWidgetType.success);
    }
  }

  Future<void> deleteTripForDriver({required int tripId}) async {
    final String response = await apiClient.httpResponse(
      urlPath: 'Trip/Delete/$tripId',
      httpMethod: HttpMethod.put,
      needLoading: true,
    );
    if (response.isNotEmpty) {
      driverTripList.clear();
      tripListIndex = 0;
      await getDriverTripList();
      Get.back();
      snackBarWidget(
          messageText: 'سفر شما با موفقیت لغو شد.',
          type: SnackBarWidgetType.success);
    }
  }

  Future<void> getDriverTripList() async {
    final String response = await apiClient.httpResponse(
      urlPath: 'Trip/Driver?index=$tripListIndex&count=5',
      httpMethod: HttpMethod.get,
    );
    if (response.isNotEmpty) {
      final TripListModel result = tripListModelFromJson(response);
      driverTripList.addAll(result.data);
    }
  }

  Future<void> getDriverInfo({required int tripId}) async {
    final String response = await apiClient.httpResponse(
      urlPath: 'Trip/SeenDriverInfo?tripId=$tripId',
      httpMethod: HttpMethod.get,
    );
    if (response.isNotEmpty) {
      final DriverInfoModel result = driverInfoModelFromJson(response);
      driverInfoData = result.data;
    }
  }
}
