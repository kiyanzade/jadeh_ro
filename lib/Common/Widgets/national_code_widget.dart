import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:jadehro_app/Common/Controller/authentication_controller.dart';
import 'package:jadehro_app/Common/Widgets/text_field_widget.dart';
import 'package:jadehro_app/Config/user_type.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../../Config/api_client_config.dart';
import '../../Config/constant.dart';
import 'alert_dialog_widget.dart';
import 'button_widget.dart';

void nationalCodeDialog(
    {required UserType userType, required String phoneNumber}) {
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  Get.defaultDialog(
    title: 'اطلاعات کاربر',
    titleStyle: const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    ),
    radius: 5,
    barrierDismissible: false,
    confirm: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ElevatedButtonWidget(
          onPressed: () {
            Get.back();
          },
          fixedSize: const Size(85, 35),
          backgroundColor: Colors.white,
          child: Text(
            'بستن',
            style: TextStyle(
              color: userType == UserType.driver
                  ? Constants.driverColor
                  : Constants.passengerColor,
              fontSize: 12,
            ),
            textScaler: TextScaler.noScaling,
          ),
        ),
        Obx(() => ElevatedButtonWidget(
              fixedSize: const Size(85, 35),
              backgroundColor: userType == UserType.driver
                  ? Constants.driverColor
                  : Constants.passengerColor,
              onPressed: () {
                if (formkey.currentState!.validate()) {
                  FocusManager.instance.primaryFocus?.unfocus();
                  secondaryAlert(
                      Get.context!,
                      'هشدار!',
                      AlertType.warning,
                      'آیا از اطلاعات وارد شده اطمینان دارید؟',
                      'خیر',
                      'بله', () {
                    Get.back();
                  }, () async {
                    Get.back();
                    if (formkey.currentState!.validate()) {
                      await AuthenticationController.to.register(
                          userType: userType, phoneNumber: phoneNumber);
                    }
                  },
                      buttonColor: userType == UserType.driver
                          ? Constants.driverColor
                          : Constants.passengerColor);
                }
              },
              child: showLoading.value
                  ? const SpinKitThreeBounce(
                      color: Colors.white,
                      size: 24.0,
                    )
                  : const Text(
                      'ادامه',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                      textScaler: TextScaler.noScaling,
                    ),
            )),
      ],
    ),
    content: Form(
      key: formkey,
      child: Column(
        children: [
          TextFormFieldWidget(
            labelText: 'کد ملی',
            textAlign: TextAlign.right,
            keyboardType: TextInputType.number,
            validator: (p0) {
              if (p0 != null && p0.length == 10) {
                return null;
              } else {
                return 'لطفا کد ملی را صحیح وارد کنید.';
              }
            },
            controller: AuthenticationController.to.nationalCode,
            suffixIconConstraints: const BoxConstraints(maxWidth: 0),
            prefixIconConstraints: const BoxConstraints(maxWidth: 30),
          ),
          const SizedBox(
            height: 16,
          ),
          TextFormFieldWidget(
            labelText: 'نام و نام خانوادگی',
            textAlign: TextAlign.right,
            validator: (p0) {
              if (p0 != null && p0.length > 5) {
                return null;
              } else {
                return 'لطفا نام و نام خانوادگی خود را صحیح وارد کنید';
              }
            },
            controller: AuthenticationController.to.name,
            suffixIconConstraints: const BoxConstraints(maxWidth: 0),
            prefixIconConstraints: const BoxConstraints(maxWidth: 30),
          ),
        ],
      ),
    ),
  );
}
