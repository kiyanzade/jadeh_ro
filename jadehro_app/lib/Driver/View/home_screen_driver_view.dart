import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jadehro_app/Common/Widgets/travel_card_driver_widget.dart';
import 'package:jadehro_app/Driver/Controller/driver_trip_controller.dart';
import 'package:just_audio/just_audio.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomeDriverScreen extends StatefulWidget {
  const HomeDriverScreen({super.key});

  @override
  State<HomeDriverScreen> createState() => _HomeDriverScreenState();
}

class _HomeDriverScreenState extends State<HomeDriverScreen> {
  final player = AudioPlayer();
  RxBool play = false.obs;
  final RefreshController refreshController = RefreshController();

  @override
  void dispose() {
    DriverTripController.to.tripListIndex = 0;
    DriverTripController.to.driverTripList.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: DriverTripController.to.getDriverTripList(),
      builder: (context, snapshot) {
        return Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            CarouselSlider.builder(
              itemCount: 3,
              options: CarouselOptions(
                autoPlay: true,
                enableInfiniteScroll: false,
                scrollPhysics: const BouncingScrollPhysics(),
                padEnds: true,
                height: Get.height * 0.22,
                // height: 100,
                viewportFraction: 0.9,
                autoPlayInterval: const Duration(seconds: 10),
              ),
              itemBuilder: (
                BuildContext context,
                int itemIndex,
                int pageViewIndex,
              ) {
                return Stack(children: [
                  Container(
                    width: Get.width,
                    clipBehavior: Clip.antiAlias,
                    margin: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 5,
                          spreadRadius: 1,
                        )
                      ],
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Image.asset(
                      "assets/Images/i${itemIndex + 1}.jpg",
                      fit: BoxFit.fill,
                    ),
                  ),
                ]);
              },
            ),
            Expanded(
              child: snapshot.connectionState == ConnectionState.waiting
                  ? const Center(child: CupertinoActivityIndicator())
                  : SmartRefresher(
                      controller: refreshController,
                      enablePullUp: true,
                      enablePullDown: false,
                      physics: const BouncingScrollPhysics(),
                      footer: CustomFooter(
                        builder: (BuildContext context, LoadStatus? mode) {
                          Widget body;
                          if (mode == LoadStatus.loading) {
                            body = const CupertinoActivityIndicator();
                          } else {
                            body = const Text('');
                          }
                          return SizedBox(
                            height: 48,
                            child: Center(child: body),
                          );
                        },
                      ),
                      onLoading: () async {
                        await Future.delayed(const Duration(seconds: 1));
                        DriverTripController.to.tripListIndex += 1;
                        await DriverTripController.to.getDriverTripList();
                        refreshController.loadComplete();
                      },
                      child: Obx(
                        () {
                          if (DriverTripController
                              .to.driverTripList.isNotEmpty) {
                            return ListView.builder(
                              itemCount:
                                  DriverTripController.to.driverTripList.length,
                              shrinkWrap: true,
                              physics: const BouncingScrollPhysics(),
                              itemBuilder: (BuildContext context, int index) {
                                return TravelCardDriver(
                                  travelData: DriverTripController
                                      .to.driverTripList[index],
                                );
                              },
                            );
                          } else {
                            return const Center(
                                child: Text(
                              'آیتمی برای نمایش وجود ندارد',
                              textAlign: TextAlign.center,
                              textScaler: TextScaler.noScaling,
                              style: TextStyle(fontSize: 14),
                            ));
                          }
                        },
                      )),
            ),

            //  Expanded(
            //     child: ListView(
            //       shrinkWrap: true,
            //       physics: const BouncingScrollPhysics(),
            //       children: const [
            //         TravelCardDriver(),
            //         TravelCardDriver(),
            //         TravelCardDriver(),
            //         TravelCardDriver(),
            //         TravelCardDriver(),
            //       ],
            //     ),
            //   )
          ],
        );
      },
    );
  }
}
