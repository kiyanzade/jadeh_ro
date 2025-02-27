import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jadehro_app/controllers/common_controller.dart';
import 'package:jadehro_app/widgets/list_widget.dart';
import 'package:jadehro_app/controllers/driver_controller.dart';
import '../../../widgets/button_widget.dart';
import '../../../widgets/snack_bar_widget.dart';
import '../../../Config/constant.dart';

class SelectDestinationView extends StatefulWidget {
  const SelectDestinationView({super.key});

  @override
  State<SelectDestinationView> createState() => _SelectDestinationViewState();
}

class _SelectDestinationViewState extends State<SelectDestinationView> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Container(
        padding: const EdgeInsets.all(10),
        height: Get.height,
        width: Get.width,
        child: SingleChildScrollView(
          child: Obx(
            () => Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text(
                  'نام مبدا',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  children: <Widget>[
                    ElevatedButtonWidget(
                      fixedSize: const Size(120, 40),
                      onPressed: () async {
                        await CommonController.to.getProvinceList();
                        Get.to(const AddTripSourceProvinceListWidget());
                      },
                      backgroundColor: Constants.driverColor,
                      child: const Text('انتخاب'),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          const Text(
                            'استان مبدا : ',
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Text(
                            DriverController
                                    .to.selectedSourceProvince.value.isEmpty
                                ? 'انتخاب کنید'
                                : DriverController
                                    .to.selectedSourceProvince.value,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  children: <Widget>[
                    ElevatedButtonWidget(
                      fixedSize: const Size(120, 40),
                      onPressed: () async {
                        if (DriverController.to.selectedSourceProvinceId == 0) {
                          snackBarWidget(
                            messageText: 'لطفا استان مبدا را وارد کنید.',
                            type: SnackBarWidgetType.failure,
                          );
                        } else {
                          await CommonController.to
                              .getCityListBySourceProvince();
                          Get.to(const AddTripSourceCityListWidget());
                        }
                      },
                      backgroundColor: Constants.driverColor,
                      child: const Text('انتخاب'),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          const Text(
                            'شهر مبدا : ',
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Text(
                            DriverController.to.selectedSourceCity.value.isEmpty
                                ? 'انتخاب کنید'
                                : DriverController.to.selectedSourceCity.value,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                const Text(
                  'نام مقصد',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  children: <Widget>[
                    ElevatedButtonWidget(
                      fixedSize: const Size(120, 40),
                      onPressed: () async {
                        await CommonController.to.getProvinceList();
                        Get.to(const AddTripDestinationProvinceListWidget());
                      },
                      backgroundColor: Constants.driverColor,
                      child: const Text('انتخاب'),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          const Text(
                            'استان مقصد : ',
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Text(
                            DriverController.to.selectedDestinationProvince
                                    .value.isEmpty
                                ? 'انتخاب کنید'
                                : DriverController
                                    .to.selectedDestinationProvince.value,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  children: <Widget>[
                    ElevatedButtonWidget(
                      fixedSize: const Size(120, 40),
                      onPressed: () async {
                        if (DriverController.to.selectedDestinationProvinceId ==
                            0) {
                          snackBarWidget(
                            messageText: 'لطفا استان مقصد را وارد کنید.',
                            type: SnackBarWidgetType.failure,
                          );
                        } else {
                          await CommonController.to
                              .getCityListByDestinationProvince();
                          Get.to(const AddTripDestinationCityListWidget());
                        }
                      },
                      backgroundColor: Constants.driverColor,
                      child: const Text('انتخاب'),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          const Text(
                            'شهر مقصد : ',
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Text(
                            DriverController
                                    .to.selectedDestinationCity.value.isEmpty
                                ? 'انتخاب کنید'
                                : DriverController
                                    .to.selectedDestinationCity.value,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
