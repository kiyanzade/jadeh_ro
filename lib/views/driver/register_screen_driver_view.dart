import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:jadehro_app/controllers/authentication_controller.dart';
import 'package:jadehro_app/widgets/app_bar_widget.dart';
import 'package:jadehro_app/Config/user_type.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

import '../../widgets/button_widget.dart';
import '../../widgets/text_field_widget.dart';
import '../../Config/api_client_config.dart';
import '../../Config/constant.dart';

class RegisterDriverView extends StatefulWidget {
  const RegisterDriverView({
    super.key,
  });

  @override
  State<RegisterDriverView> createState() => _RegisterDriverViewState();
}

class _RegisterDriverViewState extends State<RegisterDriverView> {
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  RxBool showClearPhone = false.obs;
  RxBool isPhoneNumberFilled = false.obs;
  @override
  void initState() {
    AuthenticationController.to.phoneNumber.clear();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: appBarWidget(
            backgroundColor: Constants.driverColor,
            title: 'شماره موبایل',
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
                        'برای ادامه شماره موبایل خود را وارد کنید.',
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
                    onPressed:  isPhoneNumberFilled.value
                        ?() async {
                      if (formkey.currentState!.validate()) {
                        await AuthenticationController.to
                            .checkPhoneNumber(userType: UserType.driver);
                      }
                    }:(){},
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
