import 'package:flutter/material.dart';
import 'package:flutter_spinbox/flutter_spinbox.dart';
import 'package:get/get.dart';
import 'package:jadehro_app/gen/fonts.gen.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
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


  @override
  Widget build(BuildContext context) {
    int spinValue = PassengerTripController.to.selectedCapacity;
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
              () {
                return Column(
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
                          Text('با هزینه'),
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
                            await CommonController.to.getProvinceList();
                            Get.to(const ProvinceSourceListWidget(),
                                arguments: [false]);
                          },
                          backgroundColor: Constants.passengerColor,
                          child: const Text('انتخاب استان'),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              const Text(
                                'استان مبدا:',
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Text(
                                PassengerTripController
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
                                  Get.to(
                                    const FilterDestinationProvinceListWidget(),
                                  );
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
                              Expanded(
                                child: Row(
                                  children: [
                                    const Text(
                                      'استان مقصد:',
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    Text(
                                      PassengerTripController
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
                            await CommonController.to.getCarBrandsByCarType();
                            Get.to(const FilterBrandListWidget());
                          },
                          backgroundColor: Constants.passengerColor,
                          child: const Text('انتخاب برند'),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              const Text(
                                'برند:',
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Text(
                                PassengerTripController.to.selectedBrand.value,
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
                      max: 4,
                      value: spinValue.toDouble(),
                      onChanged: (value) {
                        PassengerTripController.to.selectedCapacity =
                            value.toInt();
                      },
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
                            onPressed: () async {
                              Jalali? picked = await showPersianDatePicker(
                                  context: context,
                                  initialDate: Jalali.now(),
                                  firstDate: Jalali(1385, 8),
                                  lastDate: Jalali(1450, 9),
                                  initialEntryMode:
                                      PDatePickerEntryMode.calendarOnly,
                                  initialDatePickerMode: PDatePickerMode.year,
                                  builder: (context, child) {
                                    return Theme(
                                      data: ThemeData(
                                        colorScheme: const ColorScheme.light(
                                          primary: Constants.driverColor,
                                        ),
                                        primaryColor: Constants.driverColor,
                                        fontFamily: FontFamily.iranSans,
                                        dialogTheme: const DialogTheme(
                                          backgroundColor: Colors.white,
                                          elevation: 10,
                                          surfaceTintColor:
                                              Constants.driverColor,
                                          iconColor: Constants.driverColor,
                                          shadowColor: Constants.driverColor,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(24)),
                                          ),
                                        ),
                                      ),
                                      child: child!,
                                    );
                                  });
                              if (picked != null) {
                                setState(() {
                                  PassengerTripController
                                      .to
                                      .selectedFromDateController
                                      .text = picked.formatFullDate();
                                });
                              }
                            },
                            child: const Text('انتخاب تاریخ'),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: TextFormFieldWidget(
                            controller: PassengerTripController
                                      .to
                                      .selectedFromDateController,
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
                        onPressed: () async {
                          PassengerTripController.to.passengerTripList.clear();
                          await PassengerTripController.to
                              .getPassengerTripList();
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
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
