import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jadehro_app/Common/Model/province_model.dart';
import 'package:jadehro_app/Common/Widgets/app_bar_widget.dart';
import 'package:jadehro_app/Common/Widgets/text_field_widget.dart';
import 'package:jadehro_app/Config/constant.dart';
import 'package:jadehro_app/Passenger/Controller/passenger_trip_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Driver/Controller/driver_controller.dart';
import '../Controller/common_controller.dart';
import 'button_widget.dart';

class ProvinceListWidget extends StatelessWidget {
  const ProvinceListWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(
          title: 'انتخاب استان مقصد',
          backgroundColor: Constants.passengerColor),
      body: Padding(
        padding: const EdgeInsets.only(
          right: 12,
          left: 12,
          top: 12,
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 35,
                      child: TextFormFieldWidget(
                        labelText: 'جستجوی استان',
                        textAlign: TextAlign.right,
                        textDirection: TextDirection.ltr,
                        keyboardType: TextInputType.text,
                        controller: CommonController.to.provinceListSearch,
                        suffixIcon:
                            const Icon(Icons.search, color: Colors.grey),
                        onChanged: (value) async {
                          if (value.isEmpty) {
                            await CommonController.to.getProvinceList();
                          }
                        },
                        onTap: () {
                          CommonController.to.provinceListSearch.selection =
                              TextSelection.fromPosition(
                            TextPosition(
                              offset: CommonController
                                  .to.provinceListSearch.text.length,
                            ),
                          );
                          CommonController.to.provinceListSearch.clear();
                        },
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  ElevatedButtonWidget(
                    onPressed: () async {
                      await CommonController.to.getProvinceList();
                      CommonController.to.provinceList.value = CommonController
                          .to.provinceList
                          .where((element) => element.name.contains(
                              CommonController.to.provinceListSearch.text))
                          .toList();
                    },
                    fixedSize: const Size(90, 35),
                    backgroundColor: Constants.passengerColor,
                    child: const Text(
                      'جستجو',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                      textScaler: TextScaler.noScaling,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Obx(() => Expanded(
                  child: CommonController.to.provinceList.isNotEmpty
                      ? ListView.builder(
                          itemCount: CommonController.to.provinceList.length,
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            final BaseListData provinceData =
                                CommonController.to.provinceList[index];
                            return Padding(
                              padding: const EdgeInsets.all(4),
                              child: GestureDetector(
                                onTap: () async {
                                  final SharedPreferences preferences =
                                      await SharedPreferences.getInstance();
                                  await preferences.setInt(
                                      'selectedSourceProvinceId',
                                      provinceData.id);
                                  PassengerTripController
                                          .to.selectedSourceProvinceId =
                                      provinceData.id;
                                  Get.offAllNamed(
                                    '/MainScreenPassengerView',
                                  );
                                },
                                child: Container(
                                  padding: const EdgeInsets.only(right: 16),
                                  height: 60,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Colors.black12,
                                        blurRadius: 5,
                                        spreadRadius: 1,
                                      )
                                    ],
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      provinceData.name,
                                      textScaler: TextScaler.noScaling,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        )
                      : const Center(
                          child: Text('موردی برای نمایش وجود ندارد'),
                        ),
                )),
          ],
        ),
      ),
    );
  }
}

class ChangeProvinceListWidget extends StatelessWidget {
  const ChangeProvinceListWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(
          title: 'انتخاب استان', backgroundColor: Constants.passengerColor),
      body: Padding(
        padding: const EdgeInsets.only(
          right: 12,
          left: 12,
          top: 12,
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 35,
                      child: TextFormFieldWidget(
                        labelText: 'جستجوی استان',
                        textAlign: TextAlign.right,
                        textDirection: TextDirection.ltr,
                        keyboardType: TextInputType.text,
                        controller: CommonController.to.provinceListSearch,
                        suffixIcon:
                            const Icon(Icons.search, color: Colors.grey),
                        onChanged: (value) async {
                          if (value.isEmpty) {
                            await CommonController.to.getProvinceList();
                          }
                        },
                        onTap: () {
                          CommonController.to.provinceListSearch.selection =
                              TextSelection.fromPosition(
                            TextPosition(
                              offset: CommonController
                                  .to.provinceListSearch.text.length,
                            ),
                          );
                          CommonController.to.provinceListSearch.clear();
                        },
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  ElevatedButtonWidget(
                    onPressed: () async {
                      await CommonController.to.getProvinceList();
                      CommonController.to.provinceList.value = CommonController
                          .to.provinceList
                          .where((element) => element.name.contains(
                              CommonController.to.provinceListSearch.text))
                          .toList();
                    },
                    fixedSize: const Size(90, 35),
                    backgroundColor: Constants.passengerColor,
                    child: const Text(
                      'جستجو',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                      textScaler: TextScaler.noScaling,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Obx(() => Expanded(
                  child: CommonController.to.provinceList.isNotEmpty
                      ? ListView.builder(
                          itemCount: CommonController.to.provinceList.length,
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            final BaseListData provinceData =
                                CommonController.to.provinceList[index];
                            return Padding(
                              padding: const EdgeInsets.all(4),
                              child: GestureDetector(
                                onTap: () async {
                                  final SharedPreferences preferences =
                                      await SharedPreferences.getInstance();
                                  await preferences.setInt(
                                      'selectedSourceProvinceId',
                                      provinceData.id);
                                  PassengerTripController
                                          .to.selectedSourceProvinceId =
                                      provinceData.id;
                                  PassengerTripController.to.tripListIndex = 0;
                                  PassengerTripController.to.passengerTripList
                                      .clear();
                                  await PassengerTripController.to
                                      .getPassengerTripList();
                                  Get.back();
                                  Get.back();
                                },
                                child: Container(
                                  padding: const EdgeInsets.only(right: 16),
                                  height: 60,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Colors.black12,
                                        blurRadius: 5,
                                        spreadRadius: 1,
                                      )
                                    ],
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      provinceData.name,
                                      textScaler: TextScaler.noScaling,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        )
                      : const Center(
                          child: Text('موردی برای نمایش وجود ندارد'),
                        ),
                )),
          ],
        ),
      ),
    );
  }
}

class BrandListWidget extends StatelessWidget {
  const BrandListWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(
          title: 'انتخاب نوع خودرو', backgroundColor: Constants.driverColor),
      body: Padding(
        padding: const EdgeInsets.only(
          right: 12,
          left: 12,
          top: 12,
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 35,
                      child: TextFormFieldWidget(
                        labelText: 'جستجوی نوع خودرو',
                        textAlign: TextAlign.right,
                        textDirection: TextDirection.ltr,
                        keyboardType: TextInputType.text,
                        controller: CommonController.to.carBrandSearch,
                        suffixIcon:
                            const Icon(Icons.search, color: Colors.grey),
                        onChanged: (value) async {
                          if (value.isEmpty) {
                            await CommonController.to.getCarBrandsByCarType();
                          }
                        },
                        onTap: () {
                          CommonController.to.carBrandSearch.selection =
                              TextSelection.fromPosition(
                            TextPosition(
                              offset: CommonController
                                  .to.carBrandSearch.text.length,
                            ),
                          );
                          CommonController.to.carBrandSearch.clear();
                        },
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  ElevatedButtonWidget(
                    onPressed: () async {
                      await CommonController.to.getCarBrandsByCarType();
                      CommonController.to.carBrandList.value = CommonController
                          .to.carBrandList
                          .where((element) => element.name.contains(
                              CommonController.to.carBrandSearch.text))
                          .toList();
                    },
                    fixedSize: const Size(90, 35),
                    backgroundColor: Constants.driverColor,
                    child: const Text(
                      'جستجو',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                      textScaler: TextScaler.noScaling,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Obx(() => Expanded(
                  child: CommonController.to.carBrandList.isNotEmpty
                      ? ListView.builder(
                          itemCount: CommonController.to.carBrandList.length,
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            final BaseListData brandData =
                                CommonController.to.carBrandList[index];
                            return Padding(
                              padding: const EdgeInsets.all(4),
                              child: GestureDetector(
                                onTap: () {
                                  DriverController.to.selectedCarBrand =
                                      brandData.id;
                                  DriverController.to.selectedBrand.value =
                                      brandData.name;
                                  Get.back();
                                },
                                child: Container(
                                  padding: const EdgeInsets.only(right: 16),
                                  height: 60,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Colors.black12,
                                        blurRadius: 5,
                                        spreadRadius: 1,
                                      )
                                    ],
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      brandData.name,
                                      textScaler: TextScaler.noScaling,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        )
                      : const Center(
                          child: Text('موردی برای نمایش وجود ندارد'),
                        ),
                )),
          ],
        ),
      ),
    );
  }
}

class ModelListWidget extends StatelessWidget {
  const ModelListWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(
          title: 'انتخاب مدل خودرو', backgroundColor: Constants.driverColor),
      body: Padding(
          padding: const EdgeInsets.only(
            right: 12,
            left: 12,
            top: 12,
          ),
          child: Constants.modelList.isNotEmpty
              ? ListView.builder(
                  itemCount: Constants.modelList.length,
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(4),
                      child: GestureDetector(
                        onTap: () {
                          DriverController.to.selectedModel.value =
                              Constants.modelList.reversed.toList()[index];
                          Get.back();
                        },
                        child: Container(
                          padding: const EdgeInsets.only(right: 16),
                          height: 60,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 5,
                                spreadRadius: 1,
                              )
                            ],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              Constants.modelList.reversed.toList()[index],
                              textScaler: TextScaler.noScaling,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                )
              : const Center(
                  child: Text('موردی برای نمایش وجود ندارد'),
                )),
    );
  }
}

class AddTripSourceProvinceListWidget extends StatelessWidget {
  const AddTripSourceProvinceListWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(
          title: 'انتخاب استان', backgroundColor: Constants.driverColor),
      body: Padding(
        padding: const EdgeInsets.only(
          right: 12,
          left: 12,
          top: 12,
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 35,
                      child: TextFormFieldWidget(
                        labelText: 'جستجوی استان',
                        textAlign: TextAlign.right,
                        textDirection: TextDirection.ltr,
                        keyboardType: TextInputType.text,
                        controller: CommonController.to.provinceListSearch,
                        suffixIcon:
                            const Icon(Icons.search, color: Colors.grey),
                        onChanged: (value) async {
                          if (value.isEmpty) {
                            await CommonController.to.getProvinceList();
                          }
                        },
                        onTap: () {
                          CommonController.to.provinceListSearch.selection =
                              TextSelection.fromPosition(
                            TextPosition(
                              offset: CommonController
                                  .to.provinceListSearch.text.length,
                            ),
                          );
                          CommonController.to.provinceListSearch.clear();
                        },
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  ElevatedButtonWidget(
                    onPressed: () async {
                      await CommonController.to.getProvinceList();
                      CommonController.to.provinceList.value = CommonController
                          .to.provinceList
                          .where((element) => element.name.contains(
                              CommonController.to.provinceListSearch.text))
                          .toList();
                    },
                    fixedSize: const Size(90, 35),
                    backgroundColor: Constants.driverColor,
                    child: const Text(
                      'جستجو',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                      textScaler: TextScaler.noScaling,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Obx(() => Expanded(
                  child: CommonController.to.provinceList.isNotEmpty
                      ? ListView.builder(
                          itemCount: CommonController.to.provinceList.length,
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            final BaseListData provinceData =
                                CommonController.to.provinceList[index];
                            return Padding(
                              padding: const EdgeInsets.all(4),
                              child: GestureDetector(
                                onTap: () {
                                  DriverController.to.selectedSourceProvinceId =
                                      provinceData.id;
                                  DriverController.to.selectedSourceProvince
                                      .value = provinceData.name;
                                  Get.back();
                                },
                                child: Container(
                                  padding: const EdgeInsets.only(right: 16),
                                  height: 60,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Colors.black12,
                                        blurRadius: 5,
                                        spreadRadius: 1,
                                      )
                                    ],
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      provinceData.name,
                                      textScaler: TextScaler.noScaling,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        )
                      : const Center(
                          child: Text('موردی برای نمایش وجود ندارد'),
                        ),
                )),
          ],
        ),
      ),
    );
  }
}

class AddTripSourceCityListWidget extends StatelessWidget {
  const AddTripSourceCityListWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(
          title: 'انتخاب شهر', backgroundColor: Constants.driverColor),
      body: Padding(
        padding: const EdgeInsets.only(
          right: 12,
          left: 12,
          top: 12,
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 35,
                      child: TextFormFieldWidget(
                        labelText: 'جستجوی شهر',
                        textAlign: TextAlign.right,
                        textDirection: TextDirection.ltr,
                        keyboardType: TextInputType.text,
                        controller: CommonController.to.cityListSearch,
                        suffixIcon:
                            const Icon(Icons.search, color: Colors.grey),
                        onChanged: (value) async {
                          if (value.isEmpty) {
                            await CommonController.to
                                .getCityListBySourceProvince();
                          }
                        },
                        onTap: () {
                          CommonController.to.cityListSearch.selection =
                              TextSelection.fromPosition(
                            TextPosition(
                              offset: CommonController
                                  .to.cityListSearch.text.length,
                            ),
                          );
                          CommonController.to.cityListSearch.clear();
                        },
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  ElevatedButtonWidget(
                    onPressed: () async {
                      await CommonController.to.getCityListBySourceProvince();
                      CommonController.to.sourceCityList.value =
                          CommonController
                              .to.sourceCityList
                              .where((element) => element.name.contains(
                                  CommonController.to.cityListSearch.text))
                              .toList();
                    },
                    fixedSize: const Size(90, 35),
                    backgroundColor: Constants.driverColor,
                    child: const Text(
                      'جستجو',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                      textScaler: TextScaler.noScaling,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Obx(() => Expanded(
                  child: CommonController.to.sourceCityList.isNotEmpty
                      ? ListView.builder(
                          itemCount: CommonController.to.sourceCityList.length,
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            final BaseListData provinceData =
                                CommonController.to.sourceCityList[index];
                            return Padding(
                              padding: const EdgeInsets.all(4),
                              child: GestureDetector(
                                onTap: () {
                                  DriverController.to.selectedSourceCityId =
                                      provinceData.id;
                                  DriverController.to.selectedSourceCity.value =
                                      provinceData.name;
                                  Get.back();
                                },
                                child: Container(
                                  padding: const EdgeInsets.only(right: 16),
                                  height: 60,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Colors.black12,
                                        blurRadius: 5,
                                        spreadRadius: 1,
                                      )
                                    ],
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      provinceData.name,
                                      textScaler: TextScaler.noScaling,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        )
                      : const Center(
                          child: Text('موردی برای نمایش وجود ندارد'),
                        ),
                )),
          ],
        ),
      ),
    );
  }
}

class AddTripDestinationProvinceListWidget extends StatelessWidget {
  const AddTripDestinationProvinceListWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(
          title: 'انتخاب استان', backgroundColor: Constants.driverColor),
      body: Padding(
        padding: const EdgeInsets.only(
          right: 12,
          left: 12,
          top: 12,
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 35,
                      child: TextFormFieldWidget(
                        labelText: 'جستجوی استان',
                        textAlign: TextAlign.right,
                        textDirection: TextDirection.ltr,
                        keyboardType: TextInputType.text,
                        controller: CommonController.to.provinceListSearch,
                        suffixIcon:
                            const Icon(Icons.search, color: Colors.grey),
                        onChanged: (value) async {
                          if (value.isEmpty) {
                            await CommonController.to.getProvinceList();
                          }
                        },
                        onTap: () {
                          CommonController.to.provinceListSearch.selection =
                              TextSelection.fromPosition(
                            TextPosition(
                              offset: CommonController
                                  .to.provinceListSearch.text.length,
                            ),
                          );
                          CommonController.to.provinceListSearch.clear();
                        },
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  ElevatedButtonWidget(
                    onPressed: () async {
                      await CommonController.to.getProvinceList();
                      CommonController.to.provinceList.value = CommonController
                          .to.provinceList
                          .where((element) => element.name.contains(
                              CommonController.to.provinceListSearch.text))
                          .toList();
                    },
                    fixedSize: const Size(90, 35),
                    backgroundColor: Constants.driverColor,
                    child: const Text(
                      'جستجو',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                      textScaler: TextScaler.noScaling,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Obx(() => Expanded(
                  child: CommonController.to.provinceList.isNotEmpty
                      ? ListView.builder(
                          itemCount: CommonController.to.provinceList.length,
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            final BaseListData provinceData =
                                CommonController.to.provinceList[index];
                            return Padding(
                              padding: const EdgeInsets.all(4),
                              child: GestureDetector(
                                onTap: () {
                                  DriverController
                                          .to.selectedDestinationProvinceId =
                                      provinceData.id;
                                  DriverController
                                      .to
                                      .selectedDestinationProvince
                                      .value = provinceData.name;
                                  Get.back();
                                },
                                child: Container(
                                  padding: const EdgeInsets.only(right: 16),
                                  height: 60,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Colors.black12,
                                        blurRadius: 5,
                                        spreadRadius: 1,
                                      )
                                    ],
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      provinceData.name,
                                      textScaler: TextScaler.noScaling,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        )
                      : const Center(
                          child: Text('موردی برای نمایش وجود ندارد'),
                        ),
                )),
          ],
        ),
      ),
    );
  }
}

class AddTripDestinationCityListWidget extends StatelessWidget {
  const AddTripDestinationCityListWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(
          title: 'انتخاب شهر', backgroundColor: Constants.driverColor),
      body: Padding(
        padding: const EdgeInsets.only(
          right: 12,
          left: 12,
          top: 12,
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 35,
                      child: TextFormFieldWidget(
                        labelText: 'جستجوی شهر',
                        textAlign: TextAlign.right,
                        textDirection: TextDirection.ltr,
                        keyboardType: TextInputType.text,
                        controller: CommonController.to.cityListSearch,
                        suffixIcon:
                            const Icon(Icons.search, color: Colors.grey),
                        onChanged: (value) async {
                          if (value.isEmpty) {
                            await CommonController.to
                                .getCityListByDestinationProvince();
                          }
                        },
                        onTap: () {
                          CommonController.to.cityListSearch.selection =
                              TextSelection.fromPosition(
                            TextPosition(
                              offset: CommonController
                                  .to.cityListSearch.text.length,
                            ),
                          );
                          CommonController.to.cityListSearch.clear();
                        },
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  ElevatedButtonWidget(
                    onPressed: () async {
                      await CommonController.to
                          .getCityListByDestinationProvince();
                      CommonController.to.destinationCityList.value =
                          CommonController.to.destinationCityList
                              .where((element) => element.name.contains(
                                  CommonController.to.cityListSearch.text))
                              .toList();
                    },
                    fixedSize: const Size(90, 35),
                    backgroundColor: Constants.driverColor,
                    child: const Text(
                      'جستجو',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                      textScaler: TextScaler.noScaling,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Obx(() => Expanded(
                  child: CommonController.to.destinationCityList.isNotEmpty
                      ? ListView.builder(
                          itemCount:
                              CommonController.to.destinationCityList.length,
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            final BaseListData provinceData =
                                CommonController.to.destinationCityList[index];
                            return Padding(
                              padding: const EdgeInsets.all(4),
                              child: GestureDetector(
                                onTap: () {
                                  DriverController
                                          .to.selectedDestinationCityId =
                                      provinceData.id;
                                  DriverController.to.selectedDestinationCity
                                      .value = provinceData.name;
                                  Get.back();
                                },
                                child: Container(
                                  padding: const EdgeInsets.only(right: 16),
                                  height: 60,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Colors.black12,
                                        blurRadius: 5,
                                        spreadRadius: 1,
                                      )
                                    ],
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      provinceData.name,
                                      textScaler: TextScaler.noScaling,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        )
                      : const Center(
                          child: Text('موردی برای نمایش وجود ندارد'),
                        ),
                )),
          ],
        ),
      ),
    );
  }
}

class FilterSourceCityListWidget extends StatelessWidget {
  const FilterSourceCityListWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(
          title: 'انتخاب شهر', backgroundColor: Constants.passengerColor),
      body: Padding(
        padding: const EdgeInsets.only(
          right: 12,
          left: 12,
          top: 12,
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 35,
                      child: TextFormFieldWidget(
                        labelText: 'جستجوی شهر',
                        textAlign: TextAlign.right,
                        textDirection: TextDirection.ltr,
                        keyboardType: TextInputType.text,
                        controller: CommonController.to.cityListSearch,
                        suffixIcon:
                            const Icon(Icons.search, color: Colors.grey),
                        onChanged: (value) async {
                          if (value.isEmpty) {
                            await CommonController.to
                                .getCityListByDestinationProvince();
                          }
                        },
                        onTap: () {
                          CommonController.to.cityListSearch.selection =
                              TextSelection.fromPosition(
                            TextPosition(
                              offset: CommonController
                                  .to.cityListSearch.text.length,
                            ),
                          );
                          CommonController.to.cityListSearch.clear();
                        },
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  ElevatedButtonWidget(
                    onPressed: () async {
                      await CommonController.to
                          .getCityListByDestinationProvince();
                      CommonController.to.destinationCityList.value =
                          CommonController.to.destinationCityList
                              .where((element) => element.name.contains(
                                  CommonController.to.cityListSearch.text))
                              .toList();
                    },
                    fixedSize: const Size(90, 35),
                    backgroundColor: Constants.passengerColor,
                    child: const Text(
                      'جستجو',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                      textScaler: TextScaler.noScaling,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Obx(() => Expanded(
                  child: CommonController.to.filterSourceCityList.isNotEmpty
                      ? ListView.builder(
                          itemCount:
                              CommonController.to.filterSourceCityList.length,
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            final BaseListData provinceData =
                                CommonController.to.filterSourceCityList[index];
                            return Padding(
                              padding: const EdgeInsets.all(4),
                              child: GestureDetector(
                                onTap: () {
                                  DriverController
                                          .to.selectedDestinationCityId =
                                      provinceData.id;
                                  DriverController.to.selectedDestinationCity
                                      .value = provinceData.name;
                                  Get.back();
                                },
                                child: Container(
                                  padding: const EdgeInsets.only(right: 16),
                                  height: 60,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Colors.black12,
                                        blurRadius: 5,
                                        spreadRadius: 1,
                                      )
                                    ],
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      provinceData.name,
                                      textScaler: TextScaler.noScaling,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        )
                      : const Center(
                          child: Text('موردی برای نمایش وجود ندارد'),
                        ),
                )),
          ],
        ),
      ),
    );
  }
}

class FilterDestinationProvinceListWidget extends StatelessWidget {
  const FilterDestinationProvinceListWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(
          title: 'انتخاب استان', backgroundColor: Constants.passengerColor),
      body: Padding(
        padding: const EdgeInsets.only(
          right: 12,
          left: 12,
          top: 12,
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 35,
                      child: TextFormFieldWidget(
                        labelText: 'جستجوی استان',
                        textAlign: TextAlign.right,
                        textDirection: TextDirection.ltr,
                        keyboardType: TextInputType.text,
                        controller: CommonController.to.provinceListSearch,
                        suffixIcon:
                            const Icon(Icons.search, color: Colors.grey),
                        onChanged: (value) async {
                          if (value.isEmpty) {
                            await CommonController.to.getProvinceList();
                          }
                        },
                        onTap: () {
                          CommonController.to.provinceListSearch.selection =
                              TextSelection.fromPosition(
                            TextPosition(
                              offset: CommonController
                                  .to.provinceListSearch.text.length,
                            ),
                          );
                          CommonController.to.provinceListSearch.clear();
                        },
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  ElevatedButtonWidget(
                    onPressed: () async {
                      await CommonController.to.getProvinceList();
                      CommonController.to.provinceList.value = CommonController
                          .to.provinceList
                          .where((element) => element.name.contains(
                              CommonController.to.provinceListSearch.text))
                          .toList();
                    },
                    fixedSize: const Size(90, 35),
                    backgroundColor: Constants.passengerColor,
                    child: const Text(
                      'جستجو',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                      textScaler: TextScaler.noScaling,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Obx(() => Expanded(
                  child: CommonController.to.provinceList.isNotEmpty
                      ? ListView.builder(
                          itemCount: CommonController.to.provinceList.length,
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            final BaseListData provinceData =
                                CommonController.to.provinceList[index];
                            return Padding(
                              padding: const EdgeInsets.all(4),
                              child: GestureDetector(
                                onTap: () {
                                  DriverController
                                          .to.selectedDestinationProvinceId =
                                      provinceData.id;
                                  DriverController
                                      .to
                                      .selectedDestinationProvince
                                      .value = provinceData.name;
                                  Get.back();
                                },
                                child: Container(
                                  padding: const EdgeInsets.only(right: 16),
                                  height: 60,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Colors.black12,
                                        blurRadius: 5,
                                        spreadRadius: 1,
                                      )
                                    ],
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      provinceData.name,
                                      textScaler: TextScaler.noScaling,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        )
                      : const Center(
                          child: Text('موردی برای نمایش وجود ندارد'),
                        ),
                )),
          ],
        ),
      ),
    );
  }
}

class FilterDestinationCityListWidget extends StatelessWidget {
  const FilterDestinationCityListWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(
          title: 'انتخاب شهر', backgroundColor: Constants.passengerColor),
      body: Padding(
        padding: const EdgeInsets.only(
          right: 12,
          left: 12,
          top: 12,
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 35,
                      child: TextFormFieldWidget(
                        labelText: 'جستجوی شهر',
                        textAlign: TextAlign.right,
                        textDirection: TextDirection.ltr,
                        keyboardType: TextInputType.text,
                        controller: CommonController.to.cityListSearch,
                        suffixIcon:
                            const Icon(Icons.search, color: Colors.grey),
                        onChanged: (value) async {
                          if (value.isEmpty) {
                            await CommonController.to
                                .getCityListByDestinationProvince();
                          }
                        },
                        onTap: () {
                          CommonController.to.cityListSearch.selection =
                              TextSelection.fromPosition(
                            TextPosition(
                              offset: CommonController
                                  .to.cityListSearch.text.length,
                            ),
                          );
                          CommonController.to.cityListSearch.clear();
                        },
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  ElevatedButtonWidget(
                    onPressed: () async {
                      await CommonController.to
                          .getCityListByDestinationProvince();
                      CommonController.to.destinationCityList.value =
                          CommonController.to.destinationCityList
                              .where((element) => element.name.contains(
                                  CommonController.to.cityListSearch.text))
                              .toList();
                    },
                    fixedSize: const Size(90, 35),
                    backgroundColor: Constants.passengerColor,
                    child: const Text(
                      'جستجو',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                      textScaler: TextScaler.noScaling,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Obx(() => Expanded(
                  child: CommonController.to.destinationCityList.isNotEmpty
                      ? ListView.builder(
                          itemCount:
                              CommonController.to.destinationCityList.length,
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            final BaseListData provinceData =
                                CommonController.to.destinationCityList[index];
                            return Padding(
                              padding: const EdgeInsets.all(4),
                              child: GestureDetector(
                                onTap: () {
                                  DriverController
                                          .to.selectedDestinationCityId =
                                      provinceData.id;
                                  DriverController.to.selectedDestinationCity
                                      .value = provinceData.name;
                                  Get.back();
                                },
                                child: Container(
                                  padding: const EdgeInsets.only(right: 16),
                                  height: 60,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Colors.black12,
                                        blurRadius: 5,
                                        spreadRadius: 1,
                                      )
                                    ],
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      provinceData.name,
                                      textScaler: TextScaler.noScaling,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        )
                      : const Center(
                          child: Text('موردی برای نمایش وجود ندارد'),
                        ),
                )),
          ],
        ),
      ),
    );
  }
}
