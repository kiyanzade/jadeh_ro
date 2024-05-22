import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:delayed_widget/delayed_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Config/check_token_config.dart';
import '../../gen/assets.gen.dart';

class SplashScreenView extends StatefulWidget {
  const SplashScreenView({super.key});
  @override
  createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashScreenView> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3)).then((value) async {
      final SharedPreferences preferences =
          await SharedPreferences.getInstance();
      final bool isSeeOnboard = preferences.getBool('isSeeOnboard') ?? false;
      if (isSeeOnboard) {
        await checkTokenConfig();
      } else {
        Get.offAllNamed('/HelpOnBoardScreen');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2d302f),
      body: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            DelayedWidget(
              delayDuration: const Duration(milliseconds: 200),
              animationDuration: const Duration(seconds: 1),
              animation: DelayedAnimations.SLIDE_FROM_TOP,
              child: Assets.images.img.image(),
            ),
            Column(
              children: [
                AnimatedTextKit(
                  animatedTexts: [
                    TypewriterAnimatedText(
                      'جاده رو',
                      textStyle: const TextStyle(
                        fontSize: 30.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      speed: const Duration(milliseconds: 150),
                    ),
                  ],
                  totalRepeatCount: 1,
                ),
                const SizedBox(
                  height: 24,
                ),
                const SpinKitThreeBounce(
                  color: Colors.white,
                  size: 16.0,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}


// class SplashScreenView extends StatefulWidget {
//   const SplashScreenView({Key? key}) : super(key: key);

//   @override
//   _SplashScreenViewState createState() => _SplashScreenViewState();
// }

// class _SplashScreenViewState extends State<SplashScreenView> {
//   final DashboardController _dashboardController =
//       Get.put(DashboardController());

//   Future<void> navigationPage() async {
//     final PackageInfo _packageInfo = await PackageInfo.fromPlatform();
//     final String _packageName = _packageInfo.packageName;
//     if (_packageName == 'com.hezarbar.driver') {
//       await _dashboardController.checkVersion();
//     } else {
//       primaryAlert(
//         context: Get.context!,
//         title: "خطا!",
//         type: AlertType.error,
//         buttonText: "خروج",
//         desc: "ورود شما غیرمجاز می باشد.",
//         onPressed: () {
//           SystemNavigator.pop();
//         },
//       );
//     }
//   }

//   @override
//   void initState() {
//     super.initState();
//     Future.delayed(const Duration(seconds: 3))
//         .then((value) async => await navigationPage());
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: redColor,
//         body: Stack(
//           fit: StackFit.expand,
//           children: <Widget>[
//             Column(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               mainAxisSize: MainAxisSize.min,
//               children: <Widget>[
//                 Center(
//                   child: AnimatedTextKit(
//                     animatedTexts: [
//                       TypewriterAnimatedText(
//                         'هزاربار',
//                         textStyle: const TextStyle(
//                             fontSize: 30.0,
//                             color: Colors.white,
//                             fontWeight: FontWeight.bold,
//                             fontFamily: FontFamily.shabnam),
//                         speed: const Duration(milliseconds: 150),
//                       ),
//                     ],
//                     totalRepeatCount: 100,
//                   ),
//                 )
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
