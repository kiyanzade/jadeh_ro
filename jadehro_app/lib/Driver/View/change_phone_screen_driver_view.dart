import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:jadehro_app/Common/Controller/authentication_controller.dart';
import 'package:jadehro_app/Common/Widgets/app_bar_widget.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

import '../../Common/Widgets/button_widget.dart';
import '../../Common/Widgets/text_field_widget.dart';
import '../../Config/api_client_config.dart';
import '../../Config/constant.dart';

class ChangePhoneDriverView extends StatefulWidget {
  const ChangePhoneDriverView({
    Key? key,
  }) : super(key: key);

  @override
  State<ChangePhoneDriverView> createState() => _ChangePhoneDriverViewState();
}

class _ChangePhoneDriverViewState extends State<ChangePhoneDriverView> {
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  RxBool showClearPhone = false.obs;
  RxBool isPhoneNumberFilled = false.obs;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: appBarWidget(
            backgroundColor: Constants.driverColor,
            title: 'تغییر شماره موبایل',
          ),
          backgroundColor: Colors.white,
          body: Padding(
            padding: const EdgeInsets.fromLTRB(24, 48, 24, 16),
            child: Obx(
              () => Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'برای ادامه شماره موبایل جدید خود را وارد کنید.',
                        style: TextStyle(
                          color: Color(0XFF2b2f33),
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Form(
                        key: formkey,
                        child: TextFormFieldWidget(
                          controller: AuthenticationController.to.phoneNumber,
                          keyboardType: TextInputType.number,
                          labelText: 'شماره موبایل',
                          maxLength: 11,
                          textAlign: TextAlign.right,
                          suffixIcon: showClearPhone.value
                              ? GestureDetector(
                                  onTap: showClearPhone.value
                                      ? () {
                                          AuthenticationController
                                              .to.phoneNumber
                                              .clear();
                                          showClearPhone.value = false;
                                          isPhoneNumberFilled.value = false;
                                        }
                                      : null,
                                  child: const Icon(
                                    Icons.cancel,
                                    color: Colors.black54,
                                    size: 20,
                                  ),
                                )
                              : null,
                          textDirection: TextDirection.ltr,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          validator: (value) {
                            if (!value!.isValidIranianMobileNumber()) {
                              return '* شماره موبایل وارد شده نامعتبر می باشد.';
                            }
                            return null;
                          },
                          onChanged: (value) {
                            if (value.isNotEmpty) {
                              showClearPhone.value = true;
                              if (value.length == 11) {
                                isPhoneNumberFilled.value = true;
                                FocusManager.instance.primaryFocus?.unfocus();
                              } else {
                                isPhoneNumberFilled.value = false;
                              }
                            } else {
                              showClearPhone.value = false;
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                  ElevatedButtonWidget(
                    onPressed: () async {
                      if (formkey.currentState!.validate()) {
                        final bool result = await AuthenticationController.to
                            .sendVerifyCode(
                                phoneNumber: AuthenticationController
                                    .to.phoneNumber.text);
                        if (result) {
                          Get.toNamed('/VerifyCodeDriverView',
                              arguments:
                                  AuthenticationController.to.phoneNumber.text);
                        }
                      }
                    },
                    fixedSize: Size(Get.width, 50),
                    backgroundColor: isPhoneNumberFilled.value
                        ? Constants.driverColor
                        : Constants.driverColor.withOpacity(0.5),
                    child: showLoading.value
                        ? const SpinKitThreeBounce(
                            color: Colors.white,
                            size: 24.0,
                          )
                        : const Text(
                            'تایید و ادامه',
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
