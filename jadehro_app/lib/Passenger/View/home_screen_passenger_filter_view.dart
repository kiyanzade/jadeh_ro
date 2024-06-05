import 'package:flutter/material.dart';
import 'package:flutter_spinbox/flutter_spinbox.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';

import '../../Common/Controller/common_controller.dart';
import '../../Common/Widgets/app_bar_widget.dart';
import '../../Common/Widgets/button_widget.dart';
import '../../Common/Widgets/list_widget.dart';
import '../../Common/Widgets/text_field_widget.dart';
import '../../Config/constant.dart';
import '../Controller/passenger_trip_controller.dart';

class HomeScreenFilterView extends StatefulWidget {
  const HomeScreenFilterView({super.key});

  @override
  State<HomeScreenFilterView> createState() => _HomeScreenFilterViewState();
}

class _HomeScreenFilterViewState extends State<HomeScreenFilterView> {
  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(
        title: 'فیلتر سفر',
        backgroundColor: Constants.passengerColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Container(
            padding: const EdgeInsets.all(10),
            height: Get.height,
            width: Get.width,
            child: Obx(
              () => Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'هزینه سفر',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  RadioListTile(
                    contentPadding: EdgeInsets.zero,
                    activeColor: Constants.passengerColor,
                    title: const Row(
                      children: [
                        Icon(Icons.handshake_rounded),
                        SizedBox(width: 5),
                        Text('همه'),
                      ],
                    ),
                    value: 0,
                    groupValue:
                        PassengerTripController.to.selectedMoneyType.value,
                    onChanged: (int? value) {
                      PassengerTripController.to.selectedMoneyType.value =
                          value ?? 0;
                      PassengerTripController.to.selectedMoneyType.value =
                          value!;
                    },
                  ),
                  RadioListTile(
                    contentPadding: EdgeInsets.zero,
                    activeColor: Constants.passengerColor,
                    title: const Row(
                      children: [
                        Icon(Icons.handshake_rounded),
                        SizedBox(width: 5),
                        Text('رایگان'),
                      ],
                    ),
                    value: 1,
                    groupValue:
                        PassengerTripController.to.selectedMoneyType.value,
                    onChanged: (int? value) {
                      PassengerTripController.to.selectedMoneyType.value =
                          value ?? 1;
                      PassengerTripController.to.selectedMoneyType.value =
                          value!;
                    },
                  ),
                  RadioListTile(
                    contentPadding: EdgeInsets.zero,
                    activeColor: Constants.passengerColor,
                    title: const Row(
                      children: [
                        Icon(Icons.car_crash_rounded),
                        SizedBox(width: 5),
                        Text('توافقی'),
                      ],
                    ),
                    value: 2,
                    groupValue:
                        PassengerTripController.to.selectedMoneyType.value,
                    onChanged: (int? value) {
                      PassengerTripController.to.selectedMoneyType.value =
                          value ?? 2;
                      PassengerTripController.to.selectedMoneyType.value =
                          value!;
                    },
                  ),
                  RadioListTile(
                    contentPadding: EdgeInsets.zero,
                    activeColor: Constants.passengerColor,
                    title: const Row(
                      children: [
                        Icon(Icons.attach_money_sharp),
                        SizedBox(width: 5),
                        Text('با هرینه'),
                      ],
                    ),
                    value: 3,
                    groupValue:
                        PassengerTripController.to.selectedMoneyType.value,
                    onChanged: (int? value) {
                      PassengerTripController.to.selectedMoneyType.value =
                          value ?? 3;
                      PassengerTripController.to.selectedMoneyType.value =
                          value!;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'مبدا',
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
                        fixedSize: const Size(125, 40),
                        onPressed: () async {
                          await CommonController.to
                              .getCityListBySourceProvinceForFilter();
                          Get.to(const FilterSourceCityListWidget());
                        },
                        backgroundColor: Constants.passengerColor,
                        child: const Text('انتخاب شهر'),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      const Expanded(
                        child: Row(
                          children: [
                            Text(
                              'شهر مبدا:',
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              'ایلام',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'مقصد',
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
                              fixedSize: const Size(125, 40),
                              onPressed: () async {
                                await CommonController.to.getProvinceList();
                                // Get.to(
                                //   ProvinceListWidget(
                                //       color: Constants.passengerColor,
                                //       listName: CommonController.to.provinceList,
                                //       onTapItems: () {
                                //         Get.back();
                                //       },
                                //       onTapSearch: () {},
                                //       label: 'استان مقصد'),
                                // );
                              },
                              backgroundColor: Constants.passengerColor,
                              child: const Text(
                                'انتخاب استان',
                                style: TextStyle(fontSize: 14),
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            const Expanded(
                              child: Row(
                                children: [
                                  Text(
                                    'استان مقصد:',
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    'ایلام',
                                    style: TextStyle(
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
                              fixedSize: const Size(125, 40),
                              onPressed: () {
                                // Get.to(
                                //   ProvinceListWidget(
                                //       color: Constants.passengerColor,
                                //       listName: const [],
                                //       onTapItems: () {
                                //         Get.back();
                                //       },
                                //       onTapSearch: () {},
                                //       label: 'شهر مقصد'),
                                // );
                              },
                              backgroundColor: Constants.passengerColor,
                              child: const Text('انتخاب شهر'),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            const Expanded(
                              child: Row(
                                children: [
                                  Text(
                                    'شهر مقصد:',
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    'ایلام',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ]),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'نوع ماشین ',
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
                        fixedSize: const Size(125, 40),
                        onPressed: () async {
                          // Get.to(
                          //   ProvinceListWidget(
                          //     color: Constants.passengerColor,
                          //     listName: const [],
                          //     onTapItems: () {
                          //       Get.back();
                          //     },
                          //     onTapSearch: () {},
                          //     label: 'برند',
                          //   ),
                          // );
                        },
                        backgroundColor: Constants.passengerColor,
                        child: const Text('انتخاب برند'),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      const Expanded(
                        child: Row(
                          children: [
                            Text(
                              'برند:',
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              'پراید',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
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
                  SpinBox(
                    iconColor: const MaterialStatePropertyAll(Colors.grey),
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    min: 1,
                    max: 50,
                    value: 1,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        height: 40,
                        child: ElevatedButtonWidget(
                          fixedSize: const Size(125, 40),
                          backgroundColor: Constants.passengerColor,
                          onPressed: () async {},
                          child: const Text('انتخاب تاریخ'),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: TextFormFieldWidget(
                          controller: textEditingController,
                          labelText: 'تاریخ',
                          readOnly: true,
                          enabled: false,
                          keyboardType: TextInputType.number,
                          maxLength: 2,
                          textAlign: TextAlign.right,
                          prefixIcon: const Icon(Icons.date_range_rounded),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 100,
                  ),
                  SizedBox(
                    height: 50,
                    width: Get.width,
                    child: ElevatedButtonWidget(
                      backgroundColor: Constants.passengerColor,
                      onPressed: () {
                        Get.back();
                      },
                      child: const Text(
                        'اعمال',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
