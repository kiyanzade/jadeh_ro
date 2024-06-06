import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jadehro_app/Config/api_client_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Common/Model/trip_list_model.dart';

class PassengerTripController extends GetxController {
  final ApiClient apiClient = ApiClient();
  static PassengerTripController get to =>
      Get.put<PassengerTripController>(PassengerTripController(),
          permanent: true);
  RxList<TripListData> passengerTripList = <TripListData>[].obs;
  final TextEditingController tripSearchController = TextEditingController();
  RxInt selectedMoneyType = 0.obs;
  int selectedCarBrand = 0;
  int selectedSourceProvinceId = 0;
  int selectedDestinationProvinceId = 0;
  int selectedSourceId = 0;
  int selectedDestinationId = 0;
  int selectedCapacity = 4;
  int tripListIndex = 0;
  String selectedFromDate = '';
  RxString selectedBrand = 'همه ماشین‌ها'.obs;
  RxString selectedSourceCity = ''.obs;
  RxString selectedDestinationProvince = 'همه استان‌ها'.obs;
  RxString selectedSourceProvince = ''.obs;
  RxString selectedDestinationCity = ''.obs;

  final TextEditingController selectedFromDateController =
      TextEditingController();

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
}
