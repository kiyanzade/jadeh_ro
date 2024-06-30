import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jadehro_app/Driver/Controller/driver_controller.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';

import '../../../Common/Widgets/button_widget.dart';
import '../../../Common/Widgets/text_field_widget.dart';
import '../../../Config/constant.dart';
import '../../../gen/fonts.gen.dart';

class SelectTimeView extends StatefulWidget {
  const SelectTimeView({super.key});

  @override
  State<SelectTimeView> createState() => _SelectTimeViewState();
}

class _SelectTimeViewState extends State<SelectTimeView> {
  RxBool enable = false.obs;
  RxBool sms = false.obs;
  RxBool call = false.obs;
  RxBool chat = false.obs;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Container(
        padding: const EdgeInsets.all(10),
        height: Get.height,
        width: Get.width,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
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
              Obx(
                () => RadioListTile(
                  contentPadding: EdgeInsets.zero,
                  activeColor: Constants.driverColor,
                  title: const Row(
                    children: [
                      Icon(Icons.handshake_rounded),
                      SizedBox(width: 5),
                      Text('رایگان'),
                    ],
                  ),
                  value: 1,
                  groupValue: DriverController.to.selectedMoneyType.value,
                  onChanged: (int? value) {
                    DriverController.to.selectedMoneyType.value = value!;
                  },
                ),
              ),
              Obx(
                () => RadioListTile(
                  contentPadding: EdgeInsets.zero,
                  activeColor: Constants.driverColor,
                  title: const Row(
                    children: [
                      Icon(Icons.car_crash_rounded),
                      SizedBox(width: 5),
                      Text('توافقی'),
                    ],
                  ),
                  value: 2,
                  groupValue: DriverController.to.selectedMoneyType.value,
                  onChanged: (int? value) {
                    DriverController.to.selectedMoneyType.value = value!;
                  },
                ),
              ),
              Obx(
                () => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RadioListTile(
                      contentPadding: EdgeInsets.zero,
                      activeColor: Constants.driverColor,
                      title: const Row(
                        children: [
                          Icon(Icons.monetization_on),
                          SizedBox(width: 5),
                          Text('مبلغ'),
                        ],
                      ),
                      value: 3,
                      groupValue: DriverController.to.selectedMoneyType.value,
                      onChanged: (int? value) {
                        DriverController.to.selectedMoneyType.value = value!;
                      },
                    ),
                    Visibility(
                      visible: DriverController.to.selectedMoneyType.value == 3,
                      child: TextFormFieldWidget(
                        labelText: 'مبلغ به ازای هر نفر',
                      
                        prefixIcon: const Icon(Icons.attach_money_outlined,
                            color: Colors.black),
                        onChanged: (value) {
                          if (value == ' تومان') {
                            DriverController.to.money.text = "";
                            return;
                          }

                          if (DriverController.to.money.text
                              .contains('تومان')) {
                      
                          } else {
                            DriverController.to.money.text =
                                "$value تومان";

                            DriverController.to.money.selection =
                                TextSelection.fromPosition(
                              const TextPosition(offset: 1),
                            );
                          }
                        },
                        keyboardType: TextInputType.number,
                        controller: DriverController.to.money,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              const Text(
                'زمان حرکت',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: <Widget>[
                  SizedBox(
                    height: 40,
                    child: ElevatedButtonWidget(
                      backgroundColor: Constants.driverColor,
                      onPressed: () async {
                        // Jalali? picked = await showPersianDatePicker(
                        //     context: context,
                        //     initialDate: Jalali.now(),
                        //     firstDate: Jalali(1402, 5),
                        //     lastDate: Jalali(1402, 7),
                        //     initialEntryMode: PDatePickerEntryMode.calendarOnly,
                        //     initialDatePickerMode: PDatePickerMode.day,
                        //     builder: (context, child) {
                        //       return Theme(
                        //         data: ThemeData(
                        //           dialogTheme: const DialogTheme(
                        //             shape: RoundedRectangleBorder(
                        //               borderRadius: BorderRadius.all(
                        //                 Radius.circular(0),
                        //               ),
                        //             ),
                        //           ),
                        //         ),
                        //         child: child!,
                        //       );
                        //     });
                        // if (picked != null) {
                        //   setState(() {
                        //     textEditingController.text =
                        //         picked.toJalaliDateTime().substring(0, 10);
                        //   });
                        // }

                        // await showModalBottomSheet<Jalali>(
                        //   context: Get.context!,
                        //   builder: (context) {
                        //     Jalali tempPickedDate = Jalali.now();
                        //     return SizedBox(
                        //       height: 250,
                        //       child: Column(
                        //         children: <Widget>[
                        //           Padding(
                        //             padding: const EdgeInsets.all(12.0),
                        //             child: Row(
                        //               mainAxisAlignment:
                        //                   MainAxisAlignment.spaceBetween,
                        //               children: <Widget>[
                        //                 GestureDetector(
                        //                   onTap: () {
                        //                     Get.back();
                        //                   },
                        //                   child: const Text(
                        //                     'لغو',
                        //                     style: TextStyle(
                        //                       fontFamily: FontFamily.iranSans,
                        //                       fontSize: 14,
                        //                       fontWeight: FontWeight.bold,
                        //                     ),
                        //                   ),
                        //                 ),
                        //                 GestureDetector(
                        //                   onTap: () {
                        //                     DriverTripController
                        //                             .to
                        //                             .selectedFromDateController
                        //                             .text =
                        //                         '${tempPickedDate.year}/${tempPickedDate.month}/${tempPickedDate.day}';
                        //                     Get.back();
                        //                   },
                        //                   child: const Text(
                        //                     'تایید',
                        //                     style: TextStyle(
                        //                       fontFamily: FontFamily.iranSans,
                        //                       fontSize: 14,
                        //                       fontWeight: FontWeight.bold,
                        //                     ),
                        //                   ),
                        //                 ),
                        //               ],
                        //             ),
                        //           ),
                        //           const Divider(
                        //             height: 0,
                        //             thickness: 1,
                        //           ),
                        //           Expanded(
                        //             child: CupertinoTheme(
                        //               data: const CupertinoThemeData(
                        //                 textTheme: CupertinoTextThemeData(
                        //                   dateTimePickerTextStyle: TextStyle(
                        //                       fontFamily: FontFamily.iranSans,
                        //                       fontSize: 14,
                        //                       fontWeight: FontWeight.bold),
                        //                 ),
                        //               ),
                        //               child: PCupertinoDatePicker(
                        //                 mode: PCupertinoDatePickerMode.date,
                        //                 maximumDate: Jalali.now().addMonths(1),
                        //                 minimumDate: Jalali.now(),
                        //                 onDateTimeChanged: (Jalali dateTime) {
                        //                   tempPickedDate = dateTime;
                        //                 },
                        //               ),
                        //             ),
                        //           ),
                        //         ],
                        //       ),
                        //     );
                        //   },
                        // );

                        Jalali? picked = await showPersianDatePicker(
                            context: context,
                            initialDate: Jalali.now(),
                            firstDate: Jalali(1385, 8),
                            lastDate: Jalali(1450, 9),
                            initialEntryMode: PDatePickerEntryMode.calendarOnly,
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
                                    surfaceTintColor: Constants.driverColor,
                                    iconColor: Constants.driverColor,
                                    shadowColor: Constants.driverColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(24)),
                                    ),
                                  ),
                                ),
                                child: child!,
                              );
                            });
                        if (picked != null) {
                          setState(() {
                            DriverController.to.selectedFromDateController
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
                      controller:
                          DriverController.to.selectedFromDateController,
                      labelText: 'تاریخ',
                      readOnly: true,
                      textAlign: TextAlign.right,
                      prefixIcon: const Icon(Icons.date_range_rounded,
                          color: Colors.black),
                    ),
                  ),
                ],
              ),
              // const SizedBox(
              //   height: 10,
              // ),
              // Obx(
              //   () => CheckboxListTile(
              //     controlAffinity: ListTileControlAffinity.leading,
              //     contentPadding: EdgeInsets.zero,
              //     activeColor: primaryColor,
              //     title: Row(
              //       children: const [
              //         Icon(Icons.compare_arrows_sharp),
              //         SizedBox(width: 5),
              //         Text('سفر گروهی (رفت و برگشت)'),
              //       ],
              //     ),
              //     value: isCheckBack.value,
              //     onChanged: (value) {
              //       isCheckBack.value = !isCheckBack.value;
              //     },
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
