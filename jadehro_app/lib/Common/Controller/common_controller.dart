import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:jadehro_app/Config/api_client_config.dart';
import 'package:jadehro_app/Passenger/Controller/passenger_trip_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Driver/Controller/driver_controller.dart';
import '../Model/province_model.dart';
import '../Model/trip_detail_model.dart';
import '../Model/trip_list_model.dart';
import '../Model/user_info_model.dart';

class CommonController extends GetxController {
  final ApiClient apiClient = ApiClient();
  static CommonController get to =>
      Get.put<CommonController>(CommonController());
  RxList<BaseListData> provinceList = <BaseListData>[].obs;
  RxList<BaseListData> sourceCityList = <BaseListData>[].obs;
  RxList<BaseListData> destinationCityList = <BaseListData>[].obs;

  RxList<BaseListData> filterSourceCityList = <BaseListData>[].obs;
  RxList<BaseListData> filterDestinationCityList = <BaseListData>[].obs;

  RxList<BaseListData> carBrandList = <BaseListData>[].obs;
  RxList<TripListData> tripList = <TripListData>[].obs;
  int selectedProvinceId = 0;
  TripDetailData tripDetailData = TripDetailData(
      id: 0,
      capacity: 0,
      moneyType: 0,
      money: 0,
      moveDateTime: '',
      description: '',
      carModelId: 0,
      carModelName:0,
      sourceId: 0,
      sourceName: '',
      destinationId: 0,
      destinationName: '',
      createdDateTime: '',
      carBrandName: '',
      fillCapacity: 0,
      remainingCapacity: 0);

  final TextEditingController provinceListSearch = TextEditingController();
  final TextEditingController cityListSearch = TextEditingController();
  final TextEditingController carBrandSearch = TextEditingController();

  UserInfoData userInfoData = UserInfoData(
    id: 0,
    userName: '',
    fullName: '',
    phoneNumber: '',
    isSuspended: false,
  );

  Future<void> getProvinceList() async {
    EasyLoading.show();
    final String response = await apiClient.httpResponse(
      urlPath: 'Common/Province',
      httpMethod: HttpMethod.get,
      needToken: false,
    );
    if (response.isNotEmpty) {
      final BaseListModel result = baseListModelFromJson(response);
      provinceList.value = result.data;
    }
    EasyLoading.dismiss();
  }

  Future<void> getCityListBySourceProvince() async {
    EasyLoading.show();
    final String response = await apiClient.httpResponse(
      urlPath:
          'Common/CountryDivisionByProvince/${DriverController.to.selectedSourceProvinceId}',
      httpMethod: HttpMethod.get,
      needToken: false,
    );
    if (response.isNotEmpty) {
      final BaseListModel result = baseListModelFromJson(response);
      sourceCityList.value = result.data;
    }
    EasyLoading.dismiss();
  }

  Future<void> getCityListByDestinationProvince() async {
    EasyLoading.show();
    final String response = await apiClient.httpResponse(
      urlPath:
          'Common/CountryDivisionByProvince/${DriverController.to.selectedDestinationProvinceId}',
      httpMethod: HttpMethod.get,
      needToken: false,
    );
    if (response.isNotEmpty) {
      final BaseListModel result = baseListModelFromJson(response);
      destinationCityList.value = result.data;
    }
    EasyLoading.dismiss();
  }

  Future<void> getCityListBySourceProvinceForFilter() async {
    EasyLoading.show();
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    final int selectedSourceProvinceId =
        preferences.getInt('selectedSourceProvinceId') ?? 0;
    final String response = await apiClient.httpResponse(
      urlPath: 'Common/CountryDivisionByProvince/$selectedSourceProvinceId',
      httpMethod: HttpMethod.get,
      needToken: false,
    );
    if (response.isNotEmpty) {
      final BaseListModel result = baseListModelFromJson(response);
      filterSourceCityList.value = result.data;
    }
    EasyLoading.dismiss();
  }

  Future<void> getCityListByDestinationProvinceForFilter() async {
    EasyLoading.show();
    final String response = await apiClient.httpResponse(
      urlPath:
          'Common/CountryDivisionByProvince/${PassengerTripController.to.selectedDestinationProvinceId}',
      httpMethod: HttpMethod.get,
      needToken: false,
    );
    if (response.isNotEmpty) {
      final BaseListModel result = baseListModelFromJson(response);
      filterDestinationCityList.value = result.data;
    }
    EasyLoading.dismiss();
  }

  Future<void> getCarBrandsByCarType() async {
    EasyLoading.show();
    final String response = await apiClient.httpResponse(
      urlPath: 'Trip/CarBrands/${DriverController.to.selectedCarType.value}',
      httpMethod: HttpMethod.get,
      needToken: false,
    );
    if (response.isNotEmpty) {
      final BaseListModel result = baseListModelFromJson(response);
      carBrandList.value = result.data;
    }
    EasyLoading.dismiss();
  }

  Future<void> getTripDetail({required int tripId}) async {
    EasyLoading.show();
    final String response = await apiClient.httpResponse(
      urlPath: 'Trip/$tripId',
      httpMethod: HttpMethod.get,
      needToken: false,
    );
    if (response.isNotEmpty) {
      final TripDetailModel result = tripDetailModelFromJson(response);
      tripDetailData = result.data;
    }
    EasyLoading.dismiss();
  }

  Future<void> getUserInfo() async {
    final String response = await apiClient.httpResponse(
      urlPath: 'User/Profile',
      httpMethod: HttpMethod.get,
      needToken: false,
    );
    if (response.isNotEmpty) {
      final UserInfoModel result = userInfoModelFromJson(response);
      userInfoData = result.data;
    }
  }
}
