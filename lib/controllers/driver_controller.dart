import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:jadehro_app/controllers/common_controller.dart';
import 'package:jadehro_app/models/driver_info_model.dart';
import 'package:jadehro_app/models/trip_list_model.dart';
import 'package:jadehro_app/models/trip_request_model.dart';

import 'package:jadehro_app/widgets/snack_bar_widget.dart';
import 'package:jadehro_app/Config/api_client_config.dart';
import 'package:persian_number_utility/persian_number_utility.dart';


class DriverController extends GetxController {
  final ApiClient apiClient = ApiClient();
  static DriverController get to => Get.put<DriverController>(DriverController());
  List<TripListData> driverTripList = <TripListData>[].obs;
  RxList<TripReqData> driverReqTripList = <TripReqData>[].obs;
  final TextEditingController tripSearchController = TextEditingController();
  RxInt selectedMoneyType = 1.obs;
  int filterMoneyType = 0;
  int selectedCarBrand = 0;
  int statusFilter = 0;
  int selectedSourceProvinceId = 0;
  int selectedDestinationProvinceId = 0;
  int selectedSourceCityId = 0;
  int selectedDestinationCityId = 0;
  int selectedCapacity = 1;
  int tripListIndex = 0;
  int tripIdForRequest = 0;
  RxInt spinValue = 1.obs;
  RxInt spinMax = 4.obs;
  final TextEditingController selectedFromDateController = TextEditingController();
  final TextEditingController selectedDescription = TextEditingController();

  final TextEditingController money = TextEditingController();
  final TextEditingController acceptOrRejectDescription = TextEditingController();

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
        "money": money.text.replaceFirst('تومان', ''),
        "destinationId": selectedDestinationCityId
      },
      needLoading: true,
    );
    if (response.isNotEmpty) {
      Get.offAllNamed('MainScreenDriverView');
      snackBarWidget(messageText: 'سفر شما با موفقیت ثبت شد.', type: SnackBarWidgetType.success);
    }
  }

  Future<void> editTripForDriver() async {
    EasyLoading.show();
    final String response = await apiClient.httpResponse(
      urlPath: 'Trip/Edit',
      httpMethod: HttpMethod.put,
      body: {
        "id": CommonController.to.tripDetailData.id,
        "capacity": selectedCapacity,
        "moneyType": selectedMoneyType.value,
        "moveDateTime": selectedFromDateController.text,
        "description": selectedDescription.text,
        "carModel": int.parse(selectedModel.value),
        "sourceId": selectedSourceCityId,
        "carBrandId": selectedCarBrand,
        "destinationId": selectedDestinationCityId
      },
    );
    EasyLoading.dismiss();
    if (response.isNotEmpty) {
      Get.offAllNamed('MainScreenDriverView');
      snackBarWidget(messageText: 'سفر شما با موفقیت ویرایش شد.', type: SnackBarWidgetType.success);
    }
  }

  Future<void> cancelTripForDriver({required int tripId}) async {
    final String response = await apiClient.httpResponse(
      urlPath: 'Trip/Cancel/$tripId',
      httpMethod: HttpMethod.put,
      needLoading: true,
    );
    if (response.isNotEmpty) {
      driverTripList.clear();
      tripListIndex = 0;
      await getDriverTripList();
      Get.back();
      snackBarWidget(messageText: 'سفر شما با موفقیت لغو شد.', type: SnackBarWidgetType.success);
    }
  }

  Future<void> finishTripForDriver({required int tripId}) async {
    //TODO
    final String response = await apiClient.httpResponse(
      urlPath: 'Trip/Finish/$tripId',
      httpMethod: HttpMethod.put,
      needLoading: true,
    );
    if (response.isNotEmpty) {
      driverTripList.clear();
      tripListIndex = 0;
      await getDriverTripList();
      Get.back();
      snackBarWidget(messageText: 'سفر شما با موفقیت لغو شد.', type: SnackBarWidgetType.success);
    }
  }

  Future<void> getDriverTripList({bool paginate = true}) async {
   if(paginate || driverTripList.isEmpty){

   }
    final String response = await apiClient.httpResponse(
      urlPath: 'Trip/Driver?index=$tripListIndex&count=5',
      httpMethod: HttpMethod.get,
    );
    if (response.isNotEmpty) {
      final TripListModel result = tripListModelFromJson(response);
      driverTripList.addAll(result.data);
    }
  }

  Future<void> getDriverRequestList() async {
    final String response = await apiClient.httpResponse(
      urlPath: 'Trip/$tripIdForRequest/Requests?status=$statusFilter&index=0&count=50',
      httpMethod: HttpMethod.get,
    );
    if (response.isNotEmpty) {
      final TripReqModel result = tripReqModelFromJson(response);
      driverReqTripList.value = result.data;
    }
  }

  Future<void> driverReject(int tripId) async {
    final String response = await apiClient.httpResponse(
        urlPath: 'Trip/RejectRequest',
        httpMethod: HttpMethod.put,
        body: {'id': tripId, 'acceptOrRejectDescription': acceptOrRejectDescription.text});
    if (response.isNotEmpty) {
      Get.back();
      Get.back();
      await getDriverRequestList();
      snackBarWidget(messageText: 'درخواست سفر با موفقیت رد شد.', type: SnackBarWidgetType.success);
    }
  }

  Future<void> driverAccept(int tripId) async {
    final String response = await apiClient.httpResponse(
        urlPath: 'Trip/AcceptRequest',
        httpMethod: HttpMethod.put,
        body: {'id': tripId, 'acceptOrRejectDescription': acceptOrRejectDescription.text});
    if (response.isNotEmpty) {
      Get.back();
      Get.back();
      await getDriverRequestList();
      snackBarWidget(messageText: 'درخواست سفر با موفقیت تایید شد.', type: SnackBarWidgetType.success);
    }
  }

  Future<void> initialEditTravelData() async {
    await CommonController.to.getProvinceList();
    await CommonController.to.getCarBrandsByCarType();

    selectedBrand.value = CommonController.to.tripDetailData.carBrandName;
    selectedModel.value = CommonController.to.tripDetailData.carModelName.toString();
    selectedCapacity = CommonController.to.tripDetailData.capacity;
    spinValue.value = CommonController.to.tripDetailData.capacity;

    selectedSourceCityId = CommonController.to.tripDetailData.sourceId;
    selectedDestinationCityId = CommonController.to.tripDetailData.destinationId;

    selectedSourceProvinceId = int.parse(CommonController.to.tripDetailData.sourceId.toString().substring(0, 2));

    selectedDestinationProvinceId =
        int.parse(CommonController.to.tripDetailData.destinationId.toString().substring(0, 2));

    selectedSourceProvince.value =
        CommonController.to.provinceList.firstWhere((provinceData) => provinceData.id == selectedSourceProvinceId).name;

    selectedDestinationProvince.value = CommonController.to.provinceList
        .firstWhere((provinceData) => provinceData.id == selectedDestinationProvinceId)
        .name;
    selectedCarBrand =
        CommonController.to.carBrandList.firstWhere((carBrandData) => carBrandData.name == selectedBrand.value).id;

    selectedSourceCity.value = CommonController.to.tripDetailData.sourceName;
    selectedDestinationCity.value = CommonController.to.tripDetailData.destinationName;
    selectedMoneyType.value = CommonController.to.tripDetailData.moneyType;
    money.text = "${CommonController.to.tripDetailData.money.toString().seRagham()} تومان";
    selectedFromDateController.text = CommonController.to.tripDetailData.moveDateTime;
    selectedDescription.text = CommonController.to.tripDetailData.description;
  }
}
