import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jadehro_app/widgets/button_widget.dart';
import 'package:jadehro_app/Config/constant.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HelpOnBoardScreen extends StatefulWidget {
  const HelpOnBoardScreen({super.key});

  @override
  State<HelpOnBoardScreen> createState() => _HelpOnBoardScreenState();
}

class _HelpOnBoardScreenState extends State<HelpOnBoardScreen> {
  final PageController _pageController = PageController();
  int page = 0;
  int pages = 3;
  @override
  void initState() {
    _pageController.addListener(() {
      if (_pageController.page!.round() != page) {
        setState(() {
          page = _pageController.page!.round();
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView(
                  reverse: true,
                  controller: _pageController,
                  children: const [
                    OnBoardText(
                      title: "به جاده رو خوش اومدی!",
                      text:
                          "جاده رو کارش اینه که مسافر رو به راننده خودرو سواری برسونه تا تنها سفر نکنی",
                      image: 'assets/images/1.jpg',
                    ),
                    OnBoardText(
                      title: "راننده اید، سواری دارید!",
                      text:
                          "جاده رو برای شما مسافر میاره تا همسفر داشته باشید و و ماشینتون خالی به مقصد نرسه",
                      image: 'assets/images/2.jpg',
                    ),
                    OnBoardText(
                      title: "مسافرید ! ماشین ندارید !",
                      text:
                          "جاده رو برای شما توی مسیر سفر شما ماشین پیدا میکنه",
                      image: 'assets/images/3.jpg',
                    ),
                  ]),
            ),
            Container(
              color: const Color(0xFF2d302f),
              padding: const EdgeInsets.only(
                top: 16,
                left: 32,
                right: 32,
                bottom: 8,
              ),
              height: 110,
              child: Column(
                children: [
                  SmoothPageIndicator(
                    textDirection: TextDirection.ltr,
                    controller: _pageController,
                    count: pages,
                    effect: const ExpandingDotsEffect(
                      activeDotColor: Constants.driverColor,
                      dotColor: Colors.grey,
                      dotHeight: 8,
                      dotWidth: 8,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButtonWidget(
                          onPressed: () async {
                            if (page == pages - 1) {
                              final SharedPreferences preferences =
                                  await SharedPreferences.getInstance();
                              await preferences.setBool('isSeeOnboard', true);
                              Get.offAllNamed("ChoiceScreenView");
                            } else {
                              _pageController.animateToPage(
                                page + 1,
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.decelerate,
                              );
                            }
                          },
                          fixedSize: const Size(80, 40),
                          backgroundColor: Constants.driverColor,
                          child: page == pages - 1
                              ? const Text("ورود")
                              : const Icon(
                                  CupertinoIcons.arrow_right,
                                )),
                      ElevatedButtonWidget(
                        onPressed: () async {
                          final SharedPreferences preferences =
                              await SharedPreferences.getInstance();
                          await preferences.setBool('isSeeOnboard', true);
                          Get.offAllNamed("ChoiceScreenView");
                        },
                        fixedSize: const Size(100, 40),
                        backgroundColor: Constants.driverColor,
                        child: const Text("رد کردن"),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class OnBoardText extends StatelessWidget {
  final String title;
  final String text;
  final String image;
  const OnBoardText({
    super.key,
    required this.title,
    required this.text,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Image.asset(
            image,
            width: 400,
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        Expanded(
          child: Container(
            width: Get.width,
            margin: const EdgeInsets.all(16),
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    text,
                    textAlign: TextAlign.justify,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
