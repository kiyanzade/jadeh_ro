import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'Config/app_pages_config.dart';

import 'gen/fonts.gen.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void configLoading() {
  EasyLoading.instance
    ..loadingStyle = EasyLoadingStyle.light
    ..maskType = EasyLoadingMaskType.black
    ..userInteractions = false
    ..dismissOnTap = false
    ..indicatorWidget = const SizedBox(
      width: 30,
      height: 30,
      child: SpinKitThreeBounce(
        color: Colors.black,
        size: 20.0,
      ),
    );
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  // SystemChrome.setPreferredOrientations(
  //     [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(const MyApp());
  configLoading();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
          textTheme: const TextTheme(
              displayMedium: TextStyle(color: Colors.white, fontSize: 24)),
          fontFamily: FontFamily.iranSans,
          colorScheme: const ColorScheme.light(primary: Colors.white)),
      textDirection: TextDirection.rtl,
      supportedLocales: const [
        Locale('fa', 'IR'),
      ],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      initialRoute: '/',
      debugShowCheckedModeBanner: false,
      getPages: [
        AppPages.splashScreenView,
        AppPages.choiseScreenView,
        AppPages.registerDriverView,
        AppPages.registerPassengerView,
        AppPages.selectCityView,
        AppPages.verifyCodePassengerView,
        AppPages.verifyCodeDriverView,
        AppPages.mainScreenPassengerView,
        AppPages.mainScreenDriverView,
        AppPages.selectCityScreen,
        AppPages.homeDriverScreen,
        AppPages.homePassengerScreen,
        AppPages.homeScreenFilterView,
        AppPages.travelDetailFriverView,
        AppPages.travelDetailPassengerView,
        AppPages.helpOnBoardScreen,
        AppPages.changephonedriverview,
        AppPages.changephonepassengerview,
        AppPages.requestsListDriverView,
      ],
      builder: EasyLoading.init(),
      defaultTransition: Transition.noTransition,
    );
  }
}
