import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jadehro_app/controllers/authentication_controller.dart';
import 'package:jadehro_app/controllers/common_controller.dart';
import 'package:jadehro_app/views/passenger/profile_screen_passenger_view.dart';
import 'package:jadehro_app/views/passenger/trip_request_passenger_list_view.dart';
import 'package:jadehro_app/widgets/alert_dialog_widget.dart';
import 'package:jadehro_app/Config/check_token_config.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import '../../Config/constant.dart';

import 'home_screen_passenger_view.dart';

class MainScreenPassengerView extends StatefulWidget {
  const MainScreenPassengerView({
    super.key,
  });

  @override
  State<MainScreenPassengerView> createState() => _MainScreenPassengerViewState();
}

class _MainScreenPassengerViewState extends State<MainScreenPassengerView> {
  final RxList pageList = [
    const TripRequestPassengerListView(),
    const HomePassengerScreen(),
    const ProfilePassengerScreen(),
  ].obs;

  RxInt pageIndex = 1.obs;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: FutureBuilder(
        future: CommonController.to.getUserInfo(),
        builder: (context, snapshot) => Obx(
          () => Scaffold(
            appBar: AppBar(
              backgroundColor: Constants.passengerColor,
              title: const Text(
                "جاده رو",
                style: TextStyle(color: Colors.white),
              ),
              centerTitle: true,
              iconTheme: const IconThemeData(color: Colors.white),
            ),
            drawer: Drawer(
              width: (Get.width / 4) * 3.0,
              backgroundColor: Colors.white,
              child: Column(
                children: [
                  Container(
                    height: 110,
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                    decoration: BoxDecoration(
                      color: Constants.passengerColor.withOpacity(0.9),
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(32),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 60,
                              height: 60,
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  border: Border.all(color: Colors.white, width: 1.5)),
                              child: const Icon(
                                Icons.person,
                                color: Colors.white,
                                size: 50,
                              ),
                            ),
                            const SizedBox(
                              width: 16,
                            ),
                            Visibility(
                              visible: accessToken.isNotEmpty,
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        'نام و نام خانوادگی: ',
                                        textScaler: TextScaler.noScaling,
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white.withOpacity(0.8),
                                        ),
                                      ),
                                      Text(
                                        CommonController.to.userInfoData.fullName,
                                        textScaler: TextScaler.noScaling,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        'شماره موبایل: ',
                                        textScaler: TextScaler.noScaling,
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white.withOpacity(0.8),
                                        ),
                                      ),
                                      Text(
                                        CommonController.to.userInfoData.phoneNumber,
                                        textScaler: TextScaler.noScaling,
                                        style: const TextStyle(
                                            fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        // ListTile(
                        //   title: Row(
                        //     children: const [
                        //       Icon(
                        //         Icons.phone,
                        //         color: Constants.passengerColor,
                        //       ),
                        //       SizedBox(
                        //         width: 16,
                        //       ),
                        //       Text(
                        //         'تغییر شماره موبایل',
                        //         style: TextStyle(fontSize: 13),
                        //       ),
                        //     ],
                        //   ),
                        //   onTap: () {
                        //     Get.toNamed('/ChangePhonePassengerView');
                        //   },
                        // ),
                        ListTile(
                          title: const Row(
                            children: [
                              Icon(
                                Icons.support_agent,
                                color: Constants.passengerColor,
                              ),
                              SizedBox(
                                width: 16,
                              ),
                              Text(
                                'پشتیبانی',
                                style: TextStyle(fontSize: 13),
                              ),
                            ],
                          ),
                          onTap: () {
                            Navigator.pop(context);
                          },
                        ),
                        ListTile(
                          title: const Row(
                            children: [
                              Icon(
                                Icons.help_outline,
                                color: Constants.passengerColor,
                              ),
                              SizedBox(
                                width: 16,
                              ),
                              Text(
                                "قوانین و مقررات",
                                style: TextStyle(fontSize: 13),
                              ),
                            ],
                          ),
                          onTap: () {
                            Navigator.pop(context);
                          },
                        ),
                        ListTile(
                          title: const Row(
                            children: [
                              Icon(Icons.logout, color: Colors.red),
                              SizedBox(
                                width: 16,
                              ),
                              Text(
                                'خروج از حساب کاربری',
                                style: TextStyle(fontSize: 13, color: Colors.red),
                              ),
                            ],
                          ),
                          onTap: () {
                            secondaryAlert(
                                buttonColor: Constants.passengerColor,
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
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            body: pageList[pageIndex.value],
            bottomNavigationBar: Container(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: Colors.grey.shade200,
                  ),
                ),
              ),
              child: BottomNavigationBar(
                  currentIndex: pageIndex.value,
                  onTap: (index) {
                    pageIndex.value = index;
                  },
                  selectedItemColor: Constants.passengerColor,
                  unselectedItemColor: Colors.grey,
                  iconSize: 24,
                  elevation: 0,
                  items: const [
                    BottomNavigationBarItem(
                      icon: Icon(
                        Icons.list_alt_rounded,
                      ),
                      activeIcon: Icon(
                        Icons.list_alt_rounded,
                      ),
                      label: "درخواست‌ها",
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(
                        Icons.home_outlined,
                      ),
                      activeIcon: Icon(
                        Icons.home,
                      ),
                      label: 'خانه',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(
                        Icons.person_outline,
                      ),
                      activeIcon: Icon(
                        Icons.person,
                      ),
                      label: 'پروفایل',
                    ),
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
