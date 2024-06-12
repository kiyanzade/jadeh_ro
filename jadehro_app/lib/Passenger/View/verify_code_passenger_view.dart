import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:jadehro_app/Common/Widgets/national_code_widget.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:pinput/pinput.dart';
import 'package:timer_count_down/timer_controller.dart';
import 'package:timer_count_down/timer_count_down.dart';
import '../../Common/Controller/authentication_controller.dart';
import '../../Config/api_client_config.dart';
import '../../Config/constant.dart';
import '../../gen/fonts.gen.dart';
import '../../Common/Widgets/app_bar_widget.dart';
import '../../Common/Widgets/button_widget.dart';

class VerifyCodePassengerView extends StatefulWidget {
  const VerifyCodePassengerView({super.key});

  @override
  State<VerifyCodePassengerView> createState() =>
      _VerifyCodePassengerViewState();
}

class _VerifyCodePassengerViewState extends State<VerifyCodePassengerView> {
  RxBool isCodeFilled = false.obs;

  final FocusNode focusNode = FocusNode();

  final CountdownController countdownController =
      CountdownController(autoStart: true);
  @override
  void initState() {
    AuthenticationController.to.code.clear();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Color borderColor = Constants.passengerColor.withOpacity(0.5);
    const errorColor = Color.fromRGBO(255, 234, 238, 1);
    const fillColor = Color.fromRGBO(222, 231, 240, .57);
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(
        fontSize: 22,
        color: Color.fromRGBO(30, 60, 87, 1),
        fontFamily: FontFamily.iranSans,
      ),
      decoration: BoxDecoration(
        color: fillColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.transparent),
      ),
    );
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        appBar: appBarWidget(
            title: 'کد تایید', backgroundColor: Constants.passengerColor),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(24, 36, 24, 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'کد 6 رقمی به شماره ${Get.arguments[1].toString().toPersianDigit()} ارسال شد.',
                      style: const TextStyle(
                        color: Color(0XFF2b2f33),
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Directionality(
                      textDirection: TextDirection.ltr,
                      child: SizedBox(
                        height: 120,
                        child: Pinput(
                          length: 6,
                          autofocus: true,
                          controller: AuthenticationController.to.code,
                          focusNode: focusNode,
                          closeKeyboardWhenCompleted: true,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(
                              RegExp(r'[0-9]'),
                            ),
                          ],
                          keyboardType: TextInputType.number,
                          defaultPinTheme: defaultPinTheme,
                          onChanged: (value) {
                            if (value.length == 6) {
                              FocusManager.instance.primaryFocus?.unfocus();
                              isCodeFilled.value = true;
                            } else {
                              isCodeFilled.value = false;
                            }
                          },
                          focusedPinTheme: defaultPinTheme.copyWith(
                            height: 60,
                            width: 60,
                            decoration: defaultPinTheme.decoration!.copyWith(
                              border: Border.all(color: borderColor),
                            ),
                          ),
                          errorPinTheme: defaultPinTheme.copyWith(
                            decoration: BoxDecoration(
                              color: errorColor,
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    Countdown(
                      controller: countdownController,
                      seconds: 120,
                      build: (BuildContext context, double time) {
                        return time == 0.0
                            ? Row(
                                children: [
                                  const Text(
                                    'آیا کد را دریافت نکرده اید؟',
                                    style: TextStyle(
                                        fontSize: 12, color: Color(0XFF2b2f33)),
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  GestureDetector(
                                    onTap: () async {
                                      final bool result =
                                          await AuthenticationController.to
                                              .sendVerifyCode(
                                        phoneNumber: Get.arguments[1],
                                      );
                                      if (result) {
                                        countdownController.restart();
                                      }
                                    },
                                    child: const Row(
                                      children: [
                                        Icon(
                                          Icons.replay,
                                          color: Constants.driverColor,
                                          size: 16,
                                        ),
                                        SizedBox(
                                          width: 2,
                                        ),
                                        Text(
                                          'ارسال مجدد کد پیامکی',
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Constants.driverColor),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              )
                            : Text(
                                '${time.toInt().toString()} ثانیه تا درخواست مجدد کد',
                                style: const TextStyle(
                                    fontSize: 12, color: Color(0XFF2b2f33)),
                              );
                      },
                      interval: const Duration(seconds: 1),
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  Obx(
                    () => ElevatedButtonWidget(
                      onPressed: isCodeFilled.value
                          ? () async {
                              if (Get.arguments[2]) {
                                await AuthenticationController.to.login(
                                    userType: Get.arguments[0],
                                    phoneNumber: Get.arguments[1]);
                              } else {
                                nationalCodeDialog(
                                    userType: Get.arguments[0],
                                    phoneNumber: Get.arguments[1]);
                              }
                            }
                          : () {},
                      fixedSize: Size(Get.width, 50),
                      backgroundColor: isCodeFilled.value
                          ? Constants.passengerColor
                          : Constants.passengerColor.withOpacity(0.5),
                      child: showLoading.value
                          ? const SpinKitThreeBounce(
                              color: Colors.white,
                              size: 24.0,
                            )
                          : const Text(
                              'تایید و ادامه',
                            ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
