import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../../Common/Controller/authentication_controller.dart';
import '../../Common/Widgets/alert_dialog_widget.dart';
import '../../Config/constant.dart';

class ProfileDriverScreen extends StatefulWidget {
  const ProfileDriverScreen({super.key});

  @override
  State<ProfileDriverScreen> createState() => _ProfileDriverScreenState();
}

class _ProfileDriverScreenState extends State<ProfileDriverScreen> {
  @override
  void initState() {
    super.initState();
    debugPrint("profile");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: Padding(
        padding: const EdgeInsetsDirectional.symmetric(
          horizontal: 10,
          vertical: 6,
        ),
        child: Column(
          children: [
            Card(
              color: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  15,
                ),
              ),
            ),
            // child: Column(
            //   children: [
            //     ListTile(
            //       minVerticalPadding: 20,
            //       title: const Text(
            //         "کدملی: 4421214151",
            //         style: TextStyle(
            //           fontWeight: FontWeight.bold,
            //           fontSize: 14,
            //         ),
            //       ),
            //       subtitle: Padding(
            //         padding: const EdgeInsets.only(
            //           top: 5,
            //           left: 10,
            //         ),
            //         child: Text(
            //           "شماره موبایل: 09137895645",
            //           style: TextStyle(
            //             color: Colors.grey.shade700,
            //             fontSize: 12,
            //           ),
            //         ),
            //       ),
            //       leading: const Icon(
            //         Icons.person,
            //         size: 40,
            //       ),
            //     ),
            //   ],
            // ),
            // Card(
            //   color: Colors.white,
            //   elevation: 0,
            //   shape: RoundedRectangleBorder(
            //     borderRadius: BorderRadius.circular(
            //       15,
            //     ),
            //   ),
            //   child: ListTile(
            //     leading: const Icon(
            //       Icons.call,
            //       color: Colors.black,
            //     ),
            //     title: const Text(
            //       "تغییر شماره موبایل",
            //       style: TextStyle(
            //         fontWeight: FontWeight.bold,
            //         fontSize: 14,
            //       ),
            //     ),
            //     onTap: () {
            //       Get.toNamed('/ChangePhoneDriverView');
            //     },
            //   ),
            // ),
            Card(
              color: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  15,
                ),
              ),
              child: Column(
                children: const [
                  Card(
                    elevation: 0,
                    child: ListTile(
                      leading: Icon(
                        Icons.support_agent_sharp,
                        color: Colors.black,
                      ),
                      title: Text(
                        "پشتیبانی",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                  Card(
                    elevation: 0,
                    child: ListTile(
                      leading: Icon(
                        Icons.book,
                        color: Colors.black,
                      ),
                      title: Text(
                        "قوانین و مقررات",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Card(
              color: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  15,
                ),
              ),
              child: ListTile(
                onTap: () async {
                  secondaryAlert(
                      buttonColor: Constants.driverColor,
                      context,
                      'هشدار!',
                      AlertType.warning,
                      'آیا از خروج از حساب کاربری اطمینان دارید؟',
                      'خیر',
                      'بله', () {
                    Get.back();
                  }, () async {
                    await AuthenticationController.to.logout();
                  });
                },
                leading: const Icon(
                  Icons.logout,
                  color: Colors.red,
                ),
                title: const Text(
                  "خروج از حساب کاربری",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(30),
              child: Text(
                "1.0.0",
              ),
            )
          ],
        ),
      ),
    );
  }
}
