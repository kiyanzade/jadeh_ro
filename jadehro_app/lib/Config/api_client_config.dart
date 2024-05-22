import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'package:shared_preferences/shared_preferences.dart';

import '../Common/Model/base_data_model.dart';
import '../Common/Model/refresh_token_model.dart';
import '../Common/Widgets/snack_bar_widget.dart';
import 'app_url_config.dart';

RxBool showLoading = false.obs;

enum HttpMethod { get, post, put, delete }

class ApiClient {
  Future<bool> getRefreshToken() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    final String token = preferences.getString('token') ?? '';
    final String refreshToken = preferences.getString('refreshToken') ?? '';
    try {
      final http.Response response = await http.post(
        Uri.parse('${AppUrlConfig.appUrl}User/RefreshToken'),
        body: json.encode({
          'refreshToken': refreshToken,
          'accessToken': token,
        }),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ).timeout(
        const Duration(seconds: 30),
        onTimeout: () {
          return http.Response(
            '{"isSuccess": false,"message": "خطایی در برقراری ارتباط به وجود آمده است لطفا تا دقایقی دیگر مجددا تلاش کنید.","statusCode": 2}',
            500,
            headers: {
              HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
            },
          );
        },
      );
      final String decodeUtf8 = utf8.decode(
        response.bodyBytes,
      );
      final BaseDataModel result = baseDataModelFromJson(decodeUtf8);
      if (result.isSuccess) {
        final RefreshTokenModel result = refreshTokenModelFromJson(decodeUtf8);
        await preferences.setString('token', result.data.accessToken);
        await preferences.setString('refreshToken', result.data.refreshToken);
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Map<String, String> baseHeader({
    bool needToken = true,
    required String token,
  }) {
    return {
      'Content-Type': 'application/json;charset=UTF-8',
      'Accept': 'application/json',
      if (needToken) 'Authorization': 'Bearer $token'
    };
  }

  Future<http.Response> setHttpMethode({
    required String urlPath,
    required HttpMethod httpMethod,
    required String token,
    Map<String, dynamic>? body,
    bool needToken = true,
  }) async {
    if (httpMethod == HttpMethod.get) {
      return await http.get(
        Uri.parse(AppUrlConfig.appUrl + urlPath),
        headers: baseHeader(token: token, needToken: needToken),
      );
    } else if (httpMethod == HttpMethod.post) {
      return await http.post(
        Uri.parse(AppUrlConfig.appUrl + urlPath),
        body: json.encode(body),
        headers: baseHeader(token: token, needToken: needToken),
      );
    } else if (httpMethod == HttpMethod.put) {
      return await http.put(
        Uri.parse(AppUrlConfig.appUrl + urlPath),
        body: json.encode(body),
        headers: baseHeader(token: token, needToken: needToken),
      );
    } else {
      return await http.delete(
        Uri.parse(AppUrlConfig.appUrl + urlPath),
        body: json.encode(body),
        headers: baseHeader(token: token, needToken: needToken),
      );
    }
  }

  Future<http.Response> httpRequest({
    required String urlPath,
    required HttpMethod httpMethod,
    Map<String, dynamic>? body,
    bool needToken = true,
    bool needLoading = false,
  }) async {
    late http.Response response;
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    String token = preferences.getString('token') ?? '';
    try {
      response = await setHttpMethode(
              httpMethod: httpMethod,
              token: token,
              urlPath: urlPath,
              body: body,
              needToken: needToken)
          .timeout(
        const Duration(seconds: 30),
        onTimeout: () {
          return http.Response(
            '{"isSuccess": false,"message": "خطایی در برقراری ارتباط به وجود آمده است لطفا دقایقی دیگر مجددا تلاش کنید.","statusCode": 2}',
            500,
            headers: {
              HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
            },
          );
        },
      );
      if (response.statusCode == 401) {
        final bool result = await getRefreshToken();
        if (result) {
          final SharedPreferences preferences =
              await SharedPreferences.getInstance();
          String token = preferences.getString('token') ?? '';
          response = await setHttpMethode(
                  httpMethod: httpMethod,
                  token: token,
                  urlPath: urlPath,
                  body: body,
                  needToken: needToken)
              .timeout(
            const Duration(seconds: 30),
            onTimeout: () {
              return http.Response(
                '{"isSuccess": false,"message": "خطایی در برقراری ارتباط به وجود آمده است لطفا دقایقی دیگر مجددا تلاش کنید.","statusCode": 2}',
                500,
                headers: {
                  HttpHeaders.contentTypeHeader:
                      'application/json; charset=utf-8',
                },
              );
            },
          );
        }
      }
      return response;
    } catch (e) {
      if (e.toString().contains('Failed host lookup:')) {
        return http.Response(
          '{"isSuccess": false,"message": "دسترسی به اینترنت وجود ندارد.","statusCode": 2}',
          500,
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
          },
        );
      }
      return http.Response(
        '{"isSuccess": false,"message": "خطایی در سرور رخ داده است.","statusCode": 2}',
        500,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
        },
      );
    }
  }

  Future<String> httpResponse({
    required String urlPath,
    required HttpMethod httpMethod,
    Map<String, dynamic>? body,
    bool needToken = true,
    bool needLoading = false,
    bool dismissLoading = false,
  }) async {
    showLoading.value = needLoading;
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    final http.Response response = await httpRequest(
      urlPath: urlPath,
      needToken: needToken,
      needLoading: needLoading,
      httpMethod: httpMethod,
      body: body,
    );
    if (response.statusCode != 401) {
      final String decodeUtf8 = utf8.decode(
        response.bodyBytes,
      );
      final BaseDataModel result = baseDataModelFromJson(decodeUtf8);
      if (result.isSuccess) {
        showLoading.value = dismissLoading;
        return decodeUtf8;
      } else {
        snackBarWidget(
          messageText: result.message,
          type: SnackBarWidgetType.failure,
        );
        showLoading.value = dismissLoading;
        return '';
      }
    } else {
      await preferences.remove('token');
      await preferences.remove('refreshToken');
      Get.offAllNamed('/ChoiceScreenView');
      showLoading.value = dismissLoading;
      return '';
    }
  }

  // Future<http.Response> getRequest({
  //   String url = '',
  //   bool isAuthorized = true,
  // }) async {
  //   late http.Response response;
  //   final SharedPreferences preferences = await SharedPreferences.getInstance();
  //   String token = preferences.getString('token') ?? '';
  //   try {
  //     response = await http.get(
  //       Uri.parse(AppUrlConfig.appUrl + url),
  //       headers: {
  //         'Content-Type': 'application/json;charset=UTF-8',
  //         'Charset': 'utf-8',
  //         'Accept': 'application/json',
  //         if (isAuthorized) 'Authorization': 'Bearer $token'
  //       },
  //     ).timeout(
  //       const Duration(seconds: 30),
  //       onTimeout: () {
  //         return http.Response(
  //           '{"isSuccess": false,"message": "خطایی در برقراری ارتباط به وجود آمده است لطفا تا دقایقی دیگر مجددا تلاش کنید.","statusCode": 2}',
  //           500,
  //           headers: {
  //             HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
  //           },
  //         );
  //       },
  //     );
  //     if (response.statusCode == 401) {
  //       final bool result = await getRefreshToken();
  //       if (result) {
  //         token = preferences.getString('token') ?? '';
  //         response = await http.get(
  //           Uri.parse(AppUrlConfig.appUrl + url),
  //           headers: {
  //             'Content-Type': 'application/json;charset=UTF-8',
  //             'Charset': 'utf-8',
  //             'Accept': 'application/json',
  //             'Authorization': 'Bearer $token'
  //           },
  //         );
  //       }
  //     }
  //     return response;
  //   } catch (e) {
  //     if (e.toString().contains('Failed host lookup:')) {
  //       return http.Response(
  //         '{"isSuccess": false,"message": "دسترسی به اینترنت وجود ندارد.","statusCode": 2}',
  //         500,
  //         headers: {
  //           HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
  //         },
  //       );
  //     }
  //     return http.Response(
  //       '{"isSuccess": false,"message": "خطایی در سرور رخ داده است.","statusCode": 2}',
  //       500,
  //       headers: {
  //         HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
  //       },
  //     );
  //   }
  // }

  // Future<String> getResponse({
  //   String url = '',
  //   bool isAuthorized = true,
  // }) async {
  //   final SharedPreferences preferences = await SharedPreferences.getInstance();
  //   final http.Response response =
  //       await getRequest(url: url, isAuthorized: isAuthorized);
  //   if (response.statusCode == 401) {
  //     await preferences.remove('token');
  //     await preferences.remove('refreshToken');
  //     Get.offAllNamed('/CheckUsernameView');
  //     // await pushe(type: 'unsubscribe', topicName: 'driverGroup');
  //     return '';
  //   } else {
  //     final String decodeUtf8 = utf8.decode(
  //       response.bodyBytes,
  //     );
  //     final BaseDataModel result = baseDataModelFromJson(decodeUtf8);
  //     if (result.isSuccess) {
  //       return decodeUtf8;
  //     } else {
  //       snackBarWidget(
  //         titleText: 'خطا!',
  //         messageText: result.message,
  //         icon: const Icon(
  //           Icons.error,
  //           color: Colors.white,
  //         ),
  //         type: 'failure',
  //       );
  //       return '';
  //     }
  //   }
  // }

  // Future<http.Response> postRequest({
  //   String url = '',
  //   Map<String, dynamic>? body,
  //   bool isAuthorized = true,
  // }) async {
  //   final SharedPreferences preferences = await SharedPreferences.getInstance();
  //   String token = preferences.getString('token') ?? '';
  //   late http.Response response;
  //   try {
  //     response = await http.post(
  //       Uri.parse(AppUrlConfig.appUrl + url),
  //       body: json.encode(body),
  //       headers: {
  //         'Content-type': 'application/json',
  //         'Accept': 'application/json',
  //         if (isAuthorized) 'Authorization': 'Bearer $token'
  //       },
  //     ).timeout(
  //       const Duration(seconds: 30),
  //       onTimeout: () {
  //         return http.Response(
  //           '{"isSuccess": false,"message": "خطایی در برقراری ارتباط به وجود آمده است لطفا تا دقایقی دیگر مجددا تلاش کنید.","statusCode": 2}',
  //           500,
  //           headers: {
  //             HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
  //           },
  //         );
  //       },
  //     );
  //     if (response.statusCode == 401) {
  //       final bool result = await getRefreshToken();
  //       if (result) {
  //         token = preferences.getString('token') ?? '';
  //         response = await http.post(
  //           Uri.parse(AppUrlConfig.appUrl + url),
  //           body: json.encode(body),
  //           headers: {
  //             'Content-Type': 'application/json',
  //             'Accept': 'application/json',
  //             'Authorization': 'Bearer $token'
  //           },
  //         );
  //       }
  //     }
  //     return response;
  //   } catch (e) {
  //     if (e.toString().contains('Failed host lookup:')) {
  //       return http.Response(
  //         '{"isSuccess": false,"message": "دسترسی به اینترنت وجود ندارد.","statusCode": 2}',
  //         500,
  //         headers: {
  //           HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
  //         },
  //       );
  //     }
  //     return http.Response(
  //       '{"isSuccess": false,"message": "خطایی در سرور رخ داده است.","statusCode": 2}',
  //       500,
  //       headers: {
  //         HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
  //       },
  //     );
  //   }
  // }

  // Future<String> postResponse({
  //   String url = '',
  //   Map<String, dynamic>? body,
  //   bool isAuthorized = true,
  // }) async {
  //   final SharedPreferences preferences = await SharedPreferences.getInstance();
  //   final http.Response response =
  //       await postRequest(url: url, body: body, isAuthorized: isAuthorized);
  //   if (response.statusCode == 401) {
  //     await preferences.remove('token');
  //     await preferences.remove('refreshToken');
  //     Get.offAllNamed('/CheckUsernameView');
  //     // await pushe(type: 'unsubscribe', topicName: 'driverGroup');
  //     return '';
  //   } else {
  //     final String decodeUtf8 = utf8.decode(response.bodyBytes);
  //     final BaseDataModel result = baseDataModelFromJson(decodeUtf8);
  //     if (result.isSuccess) {
  //       return decodeUtf8;
  //     } else {
  //       snackBarWidget(
  //         titleText: 'خطا!',
  //         messageText: result.message,
  //         icon: const Icon(
  //           Icons.error,
  //           color: Colors.white,
  //         ),
  //         type: 'failure',
  //       );
  //       return '';
  //     }
  //   }
  // }

  // Future<http.Response> putRequest({
  //   String url = '',
  //   Map<String, dynamic>? body,
  //   bool isAuthorized = true,
  // }) async {
  //   final SharedPreferences preferences = await SharedPreferences.getInstance();
  //   String token = preferences.getString('token') ?? '';
  //   late http.Response response;
  //   try {
  //     response = await http.put(
  //       Uri.parse(AppUrlConfig.appUrl + url),
  //       body: json.encode(body),
  //       headers: {
  //         'Content-type': 'application/json',
  //         'Accept': 'application/json',
  //         if (isAuthorized) 'Authorization': 'Bearer $token'
  //       },
  //     ).timeout(
  //       const Duration(seconds: 30),
  //       onTimeout: () {
  //         return http.Response(
  //           '{"isSuccess": false,"message": "خطایی در برقراری ارتباط به وجود آمده است لطفا تا دقایقی دیگر مجددا تلاش کنید.","statusCode": 2}',
  //           500,
  //           headers: {
  //             HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
  //           },
  //         );
  //       },
  //     );
  //     if (response.statusCode == 401) {
  //       final bool result = await getRefreshToken();
  //       if (result) {
  //         token = preferences.getString('token') ?? '';
  //         response = await http.put(
  //           Uri.parse(AppUrlConfig.appUrl + url),
  //           body: json.encode(body),
  //           headers: {
  //             'Content-Type': 'application/json',
  //             'Accept': 'application/json',
  //             'Authorization': 'Bearer $token'
  //           },
  //         );
  //       }
  //     }
  //     return response;
  //   } catch (e) {
  //     if (e.toString().contains('Failed host lookup:')) {
  //       return http.Response(
  //         '{"isSuccess": false,"message": "دسترسی به اینترنت وجود ندارد.","statusCode": 2}',
  //         500,
  //         headers: {
  //           HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
  //         },
  //       );
  //     }
  //     return http.Response(
  //       '{"isSuccess": false,"message": "خطایی در سرور رخ داده است.","statusCode": 2}',
  //       500,
  //       headers: {
  //         HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
  //       },
  //     );
  //   }
  // }

  // Future<String> putResponse({
  //   String url = '',
  //   Map<String, dynamic>? body,
  //   bool isAuthorized = true,
  // }) async {
  //   final SharedPreferences preferences = await SharedPreferences.getInstance();
  //   final http.Response response =
  //       await putRequest(url: url, body: body, isAuthorized: isAuthorized);
  //   if (response.statusCode == 401) {
  //     await preferences.remove('token');
  //     await preferences.remove('refreshToken');
  //     Get.offAllNamed('/CheckUsernameView');
  //     // await pushe(type: 'unsubscribe', topicName: 'driverGroup');
  //     return '';
  //   } else {
  //     final String decodeUtf8 = utf8.decode(response.bodyBytes);
  //     final BaseDataModel result = baseDataModelFromJson(decodeUtf8);
  //     if (result.isSuccess) {
  //       return decodeUtf8;
  //     } else {
  //       snackBarWidget(
  //         titleText: 'خطا!',
  //         messageText: result.message,
  //         icon: const Icon(
  //           Icons.error,
  //           color: Colors.white,
  //         ),
  //         type: 'failure',
  //       );
  //       return '';
  //     }
  //   }
  // }
}
