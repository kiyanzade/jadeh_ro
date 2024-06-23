import 'package:flutter/material.dart';
import 'package:flutter_spinbox/flutter_spinbox.dart';
import 'package:get/get.dart';
import 'package:jadehro_app/Common/Controller/common_controller.dart';
import '../../../Common/Widgets/button_widget.dart';
import '../../../Common/Widgets/list_widget.dart';
import '../../../Config/constant.dart';
import '../../Controller/driver_controller.dart';

class SelectCarView extends StatefulWidget {
  const SelectCarView({super.key});

  @override
  State<SelectCarView> createState() => _SelectCarViewState();
}

class _SelectCarViewState extends State<SelectCarView> {
  TextEditingController capacityText = TextEditingController();

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
                  "نوع ماشین",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                RadioListTile(
                  contentPadding: EdgeInsets.zero,
                  activeColor: Constants.driverColor,
                  title: const Row(
                    children: [
                      Icon(Icons.no_crash_rounded),
                      SizedBox(width: 5),
                      Text('سواری'),
                    ],
                  ),
                  value: 1,
                  groupValue: DriverController.to.selectedCarType.value,
                  onChanged: (int? value) {
                    DriverController.to.selectedCarType.value = value!;
                    if (DriverController.to.spinValue.value > 4) {
                      DriverController.to.spinValue = 4.obs;
                    }
                    DriverController.to.spinMax = 4.obs;
                  },
                ),
                RadioListTile(
                  contentPadding: EdgeInsets.zero,
                  activeColor: Constants.driverColor,
                  title: const Row(
                    children: [
                      Icon(Icons.bus_alert_sharp),
                      SizedBox(width: 5),
                      Text('ون'),
                    ],
                  ),
                  value: 2,
                  groupValue: DriverController.to.selectedCarType.value,
                  onChanged: (int? value) {
                    DriverController.to.selectedCarType.value = value!;
                    DriverController.to.spinMax = 14.obs;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: <Widget>[
                    SizedBox(
                      height: 40,
                      width: 120,
                      child: ElevatedButtonWidget(
                        onPressed: () async {
                          CommonController.to.carBrandSearch.clear();
                          await CommonController.to.getCarBrandsByCarType();
                          Get.to(
                            const BrandListWidget(),
                          );
                        },
                        backgroundColor: Constants.driverColor,
                        child: const Text('انتخاب'),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          const Text(
                            'نوع خودرو : ',
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Text(
                            DriverController.to.selectedBrand.value.isEmpty
                                ? 'انتخاب کنید'
                                : DriverController.to.selectedBrand.value,
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
                    SizedBox(
                      height: 40,
                      width: 120,
                      child: ElevatedButtonWidget(
                        backgroundColor: Constants.driverColor,
                        onPressed: () {
                          Get.to(const ModelListWidget());
                        },
                        child: const Text('انتخاب'),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          const Text(
                            'مدل خودرو : ',
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Text(
                            DriverController.to.selectedModel.value.isEmpty
                                ? 'انتخاب کنید'
                                : 'سال ${DriverController.to.selectedModel.value}',
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
                  'ظرفیت خالی',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Obx(
                  () => SpinBox(
                    iconColor: const WidgetStatePropertyAll(Colors.grey),
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    min: 1,
                    max: DriverController.to.spinMax.value.toDouble(),
                    value: DriverController.to.spinValue.value.toDouble(),
                    onChanged: (value) {
                      DriverController.to.selectedCapacity = value.toInt();
                      DriverController.to.spinValue.value = value.toInt();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
