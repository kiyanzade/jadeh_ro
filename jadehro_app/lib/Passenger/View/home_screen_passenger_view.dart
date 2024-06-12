import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../Common/Widgets/button_widget.dart';
import '../../Common/Widgets/text_field_widget.dart';
import '../../Common/Widgets/travel_card_passenger_widget.dart';
import '../../Config/constant.dart';
import '../Controller/passenger_trip_controller.dart';

class HomePassengerScreen extends StatefulWidget {
  const HomePassengerScreen({super.key});

  @override
  State<HomePassengerScreen> createState() => _HomePassengerScreenState();
}

class _HomePassengerScreenState extends State<HomePassengerScreen> {
  @override
  void dispose() {
    PassengerTripController.to.tripSearchController.clear();
    PassengerTripController.to.tripListIndex = 0;
    PassengerTripController.to.passengerTripList.clear();
    super.dispose();
  }

  final RefreshController refreshController = RefreshController();

  RxBool play = false.obs;
  @override
  Widget build(BuildContext context) {
    // player.setUrl(
    //     'https://dlw.webahang.ir/music/Track/maziar-tavoli-refigh-ja-namoni(128).mp3');

    return FutureBuilder(
      future: PassengerTripController.to.getPassengerTripList(),
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
                return Stack(
                  children: [
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
                    itemIndex == 1
                        ? Align(
                            alignment: Alignment.center,
                            child: InkWell(
                              onTap: () {
                             
                              },
                              child: Obx(() => Container(
                                    alignment: Alignment.center,
                                    width: 30,
                                    height: 30,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white,
                                    ),
                                    child: play.value
                                        ? const Icon(Icons.pause)
                                        : const Icon(Icons.play_arrow),
                                  )),
                            ),
                          )
                        : const SizedBox(),
                  ],
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 35,
                      child: TextFormFieldWidget(
                        labelText: 'جستجو',
                        textAlign: TextAlign.right,
                        textDirection: TextDirection.ltr,
                        keyboardType: TextInputType.text,
                        controller:
                            PassengerTripController.to.tripSearchController,
                        // prefixIconConstraints:
                        //     const BoxConstraints(maxWidth: 10),
                        // suffixIconConstraints:
                        //     const BoxConstraints(maxWidth: 10),
                        suffixIcon:
                            const Icon(Icons.search, color: Colors.grey),
                        onChanged: (value) async {
                          if (value.isEmpty) {
                            EasyLoading.show();
                            PassengerTripController.to.tripListIndex = 0;
                            PassengerTripController.to.passengerTripList
                                .clear();
                            await PassengerTripController.to
                                .getPassengerTripList();
                            EasyLoading.dismiss();
                          }
                        },
                        onTap: () {
                          PassengerTripController.to.tripSearchController
                              .selection = TextSelection.fromPosition(
                            TextPosition(
                              offset: PassengerTripController
                                  .to.tripSearchController.text.length,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  ElevatedButtonWidget(
                    onPressed: () async {
                      EasyLoading.show();
                      PassengerTripController.to.tripListIndex = 0;
                      PassengerTripController.to.passengerTripList.clear();
                      await PassengerTripController.to.getPassengerTripList();
                      EasyLoading.dismiss();
                    },
                    fixedSize: const Size(90, 35),
                    backgroundColor: Constants.passengerColor,
                    child: const Text(
                      'جستجو',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                      textScaler: TextScaler.noScaling,
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  ElevatedButtonWidget(
                    onPressed: () {
                      Get.toNamed('/HomeScreenFilterView');
                    },
                    backgroundColor: Constants.passengerColor,
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 6),
                      child: Icon(
                        Icons.filter_alt_outlined,
                        size: 24,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
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
                        PassengerTripController.to.tripListIndex += 1;
                        await PassengerTripController.to.getPassengerTripList();
                        refreshController.loadComplete();
                      },
                      child: Obx(
                        () {
                          if (PassengerTripController
                              .to.passengerTripList.isNotEmpty) {
                            return ListView.builder(
                              itemCount: PassengerTripController
                                  .to.passengerTripList.length,
                              shrinkWrap: true,
                              physics: const BouncingScrollPhysics(),
                              itemBuilder: (BuildContext context, int index) {
                                return TravelCard(
                                  travelModel: PassengerTripController
                                      .to.passengerTripList[index],
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
          ],
        );
      },
    );
  }
}
