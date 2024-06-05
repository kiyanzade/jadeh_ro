import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:jadehro_app/Common/View/laws_screen_view.dart';
import 'package:jadehro_app/Driver/Controller/driver_controller.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../Common/Widgets/button_widget.dart';
import '../../Common/Widgets/snack_bar_widget.dart';
import '../../Config/api_client_config.dart';
import '../../Config/constant.dart';
import 'OnBoardingPage/select_car_view.dart';
import 'OnBoardingPage/select_destination_view.dart';
import 'OnBoardingPage/select_detail_view.dart';
import 'OnBoardingPage/select_time_view.dart';

RxBool isCheckPolicy = false.obs;
RxBool isCheckBack = false.obs;

List<Widget> pagesList = [
  const SelectCarView(),
  const SelectDestinationView(),
  const SelectTimeView(),
  const SelectDetailView(),
  const LawsScreenView()
];

class TravelOnboarding extends StatefulWidget {
  const TravelOnboarding({super.key});

  @override
  State<TravelOnboarding> createState() => _TravelOnboardingState();
}

class _TravelOnboardingState extends State<TravelOnboarding> {
  int pageIndex = 0;
  int pages = pagesList.length;
  final PageController _pageController = PageController(keepPage: true);

  @override
  void initState() {
    _pageController.addListener(() {
      if (_pageController.page!.round() != pageIndex) {
        setState(() {
          pageIndex = _pageController.page!.round();
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView(
                controller: _pageController,
                reverse: true,
                physics: const NeverScrollableScrollPhysics(),
                children: pagesList,
              ),
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
                      pageIndex == pages - 1
                          ? Obx(
                              () => ElevatedButtonWidget(
                                onPressed: () async {
                                  if (isCheckPolicy.value) {
                                    await DriverController.to
                                        .addTripForDriver();
                                    isCheckPolicy.value = false;
                                  }
                                },
                                fixedSize: const Size(90, 40),
                                backgroundColor: isCheckPolicy.value
                                    ? Constants.driverColor
                                    : Colors.grey,
                                child: showLoading.value
                                    ? const SpinKitThreeBounce(
                                        color: Colors.white,
                                        size: 24.0,
                                      )
                                    : const Text(
                                        'ثبت',
                                      ),
                              ),
                            )
                          : ElevatedButtonWidget(
                              onPressed: () {
                                if (pageIndex == 0) {
                                  if (DriverController.to.selectedCarBrand ==
                                      0) {
                                    snackBarWidget(
                                      messageText:
                                          'لطفا نوع خودرو را وارد کنید.',
                                      type: SnackBarWidgetType.failure,
                                    );
                                  } else if (DriverController
                                      .to.selectedModel.isEmpty) {
                                    snackBarWidget(
                                      messageText:
                                          'لطفا مدل خودرو را وارد کنید.',
                                      type: SnackBarWidgetType.failure,
                                    );
                                  } else {
                                    _pageController.animateToPage(
                                      pageIndex + 1,
                                      duration:
                                          const Duration(milliseconds: 500),
                                      curve: Curves.decelerate,
                                    );
                                  }
                                }
                                if (pageIndex == 1) {
                                  if (DriverController
                                          .to.selectedSourceProvinceId ==
                                      0) {
                                    snackBarWidget(
                                      messageText:
                                          'لطفا استان مبدا را وارد کنید.',
                                      type: SnackBarWidgetType.failure,
                                    );
                                  } else if (DriverController
                                          .to.selectedSourceCityId ==
                                      0) {
                                    snackBarWidget(
                                      messageText:
                                          'لطفا شهر مبدا را وارد کنید.',
                                      type: SnackBarWidgetType.failure,
                                    );
                                  } else if (DriverController
                                          .to.selectedDestinationProvinceId ==
                                      0) {
                                    snackBarWidget(
                                      messageText:
                                          'لطفا استان مقصد را وارد کنید.',
                                      type: SnackBarWidgetType.failure,
                                    );
                                  } else if (DriverController
                                          .to.selectedDestinationCityId ==
                                      0) {
                                    snackBarWidget(
                                      messageText:
                                          'لطفا شهر مقصد را وارد کنید.',
                                      type: SnackBarWidgetType.failure,
                                    );
                                  } else {
                                    _pageController.animateToPage(
                                      pageIndex + 1,
                                      duration:
                                          const Duration(milliseconds: 500),
                                      curve: Curves.decelerate,
                                    );
                                  }
                                }
                                if (pageIndex == 2) {
                                  if (DriverController
                                      .to
                                      .selectedFromDateController
                                      .text
                                      .isEmpty) {
                                    snackBarWidget(
                                      messageText: 'لطفا تاریخ را وارد کنید.',
                                      type: SnackBarWidgetType.failure,
                                    );
                                  } else {
                                    _pageController.animateToPage(
                                      pageIndex + 1,
                                      duration:
                                          const Duration(milliseconds: 500),
                                      curve: Curves.decelerate,
                                    );
                                  }
                                }
                                if (pageIndex == 3) {
                                  _pageController.animateToPage(
                                    pageIndex + 1,
                                    duration: const Duration(milliseconds: 500),
                                    curve: Curves.decelerate,
                                  );
                                }
                              },
                              fixedSize: const Size(80, 40),
                              backgroundColor: Constants.driverColor,
                              child: const Text(
                                'بعدی',
                              ),
                            ),
                      pageIndex != 0
                          ? ElevatedButtonWidget(
                              onPressed: () {
                                _pageController.animateToPage(
                                  pageIndex - 1,
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.decelerate,
                                );
                              },
                              fixedSize: const Size(80, 40),
                              backgroundColor: Constants.driverColor,
                              child: const Text('قبلی'),
                            )
                          : const SizedBox()
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
