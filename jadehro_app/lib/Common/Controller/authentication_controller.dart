import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jadehro_app/Common/Widgets/snack_bar_widget.dart';
import 'package:jadehro_app/Config/api_client_config.dart';
import 'package:jadehro_app/Config/user_type.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Model/token_model.dart';
import '../Widgets/dialog_detail.dart';
import '../Widgets/national_code_widget.dart';

class AuthenticationController extends GetxController {
  final ApiClient apiClient = ApiClient();
  static AuthenticationController get to =>
      Get.put<AuthenticationController>(AuthenticationController());
  final TextEditingController phoneNumber = TextEditingController();
  final TextEditingController nationalCode = TextEditingController();
  final TextEditingController code = TextEditingController();
  bool isRegistered = false;

  Future<void> checkPhoneNumber({required UserType userType}) async {
    final String response = await apiClient.httpResponse(
      urlPath: 'User/CheckUsername?username=${phoneNumber.text}',
      httpMethod: HttpMethod.get,
      needLoading: true,
      needToken: false,
    );
    if (response.isNotEmpty) {
      final Map<String, dynamic> decoder =
          json.decode(response) as Map<String, dynamic>;
      isRegistered = decoder['data'];
      await sendCodeByPhoneNumber(userType: userType);
    }
  }

  Future<void> sendCodeByPhoneNumber({required UserType userType}) async {
    final String response = await apiClient.httpResponse(
        urlPath: 'User/SendVerifyCode?phoneNumber=${phoneNumber.text}',
        httpMethod: HttpMethod.post,
        needLoading: true,
        needToken: false);
    if (response.isNotEmpty) {
      Get.offAllNamed(
        userType == UserType.driver
            ? '/VerifyCodeDriverView'
            : 'VerifyCodePassengerView',
        arguments: [
          userType,
          phoneNumber.text,
          isRegistered,
        ],
      );
    }
  }

  Future<bool> sendVerifyCode({
    required String phoneNumber,
  }) async {
    final String response = await apiClient.httpResponse(
        urlPath: 'User/SendVerifyCode?phoneNumber=$phoneNumber',
        httpMethod: HttpMethod.post,
        needLoading: true,
        needToken: false);
    if (response.isNotEmpty) {
      return true;
    }
    return false;
  }

  Future<void> verifyCode(
      {required UserType userType,
      required String phoneNumber,
      required bool isRegistered}) async {
    final String response = await apiClient.httpResponse(
        urlPath: 'User/VerifyCode?phoneNumber=$phoneNumber&code=${code.text}',
        httpMethod: HttpMethod.get,
        needLoading: true,
        needToken: false);
    if (response.isNotEmpty) {
      if (isRegistered) {
        await login(userType: userType, phoneNumber: phoneNumber);
      } else {
        nationalCodeDialog(userType: userType, phoneNumber: phoneNumber);
      }
    }
  }

  Future<void> verifyCodeForChangePhoneNumber({
    required String phoneNumber,
  }) async {
    final String response = await apiClient.httpResponse(
        urlPath: 'User/VerifyCode?phoneNumber=$phoneNumber&code=${code.text}',
        httpMethod: HttpMethod.get,
        needLoading: true,
        needToken: false);
    if (response.isNotEmpty) {
      await changePhoneNumber(phoneNumber: phoneNumber, code: code.text);
    }
  }

  Future<void> login(
      {required UserType userType, required String phoneNumber}) async {
    final String response = await apiClient.httpResponse(
      urlPath: 'User/Login',
      httpMethod: HttpMethod.post,
      body: {
        "userName": phoneNumber,
        "verifyCode": code.text,
        "userType": userType == UserType.driver ? 3 : 4
      },
      needLoading: true,
      needToken: false,
    );
    if (response.isNotEmpty) {
      final TokenModel result = tokenModelFromJson(response);
      final SharedPreferences preferences =
          await SharedPreferences.getInstance();
      await preferences.setString('token', result.data.accessToken);
      await preferences.setString(
        'refreshToken',
        result.data.refreshToken,
      );
      if (userType == UserType.driver) {
        Get.offAllNamed('/MainScreenDriverView');
      } else {
        Get.offAllNamed('/MainScreenPassengerView');
        driverInfoDialog();
      }
    }
  }

  Future<void> register(
      {required UserType userType, required String phoneNumber}) async {
    final String response = await apiClient.httpResponse(
      urlPath: 'User/RegisterClient',
      httpMethod: HttpMethod.post,
      body: {
        "phoneNumber": phoneNumber,
        "verifyCode": code.text,
        "nationalCode": nationalCode.text,
        "userType": userType == UserType.driver ? 3 : 4
      },
      needLoading: true,
      needToken: false,
    );
    if (response.isNotEmpty) {
      final TokenModel result = tokenModelFromJson(response);
      final SharedPreferences preferences =
          await SharedPreferences.getInstance();
      await preferences.setString('token', result.data.accessToken);
      await preferences.setString(
        'refreshToken',
        result.data.refreshToken,
      );
      if (userType == UserType.driver) {
        Get.offAllNamed('/MainScreenDriverView');
      } else {
        Get.offAllNamed('/MainScreenPassengerView');
        driverInfoDialog();
      }
    }
  }

  Future<void> changePhoneNumber(
      {required String phoneNumber, required String code}) async {
    final String response = await apiClient.httpResponse(
      urlPath: 'User/ChangePhoneNumber',
      httpMethod: HttpMethod.put,
      body: {
        "verifyCode": code,
        "newPhoneNumber": phoneNumber,
      },
      needLoading: true,
      needToken: false,
    );
    if (response.isNotEmpty) {
      snackBarWidget(
        messageText: 'شماره موبایل شما با موفقیت تغییر یافت.',
        type: SnackBarWidgetType.success,
      );
      await logout();
    }
  }

  Future<void> logout() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();

    final bool isTokenRemoved = await preferences.remove("token");
    final bool isRefreshTokenRemoved = await preferences.remove("refreshToken");

    if (isTokenRemoved && isRefreshTokenRemoved) {
      Get.offAllNamed('/ChoiceScreenView');
    }
  }
}
