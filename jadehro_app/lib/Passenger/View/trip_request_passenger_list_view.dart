import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:jadehro_app/Common/Model/trip_request_model.dart';
import 'package:jadehro_app/Common/Widgets/alert_dialog_widget.dart';
import 'package:jadehro_app/Common/Widgets/button_widget.dart';
import 'package:jadehro_app/Common/Widgets/filters_widget.dart';
import 'package:jadehro_app/Common/Widgets/travel_card_passenger_widget.dart';
import 'package:jadehro_app/Config/check_token_config.dart';
import 'package:jadehro_app/Config/constant.dart';
import 'package:jadehro_app/Passenger/Controller/passenger_trip_controller.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class TripRequestPassengerListView extends StatefulWidget {
  const TripRequestPassengerListView({super.key});

  @override
  State<TripRequestPassengerListView> createState() => _TripRequestPassengerListViewState();
}

class _TripRequestPassengerListViewState extends State<TripRequestPassengerListView> {
  @override
  void dispose() {
    selectedIdFilter.value = -1;
    PassengerTripController.to.reqStatusFilter = 0;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return accessToken.isNotEmpty
        ? FutureBuilder(
            future: PassengerTripController.to.getPassengerTripRequestList(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CupertinoActivityIndicator());
              } else {
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
                      child: Row(
                        children: [
                          const Text(
                            'فیلترها: ',
                          ),
                          Expanded(
                            child: FilterChipWidget(
                              everyCall: () async {
                                PassengerTripController.to.passengerReqTripList.clear();
                                await PassengerTripController.to.getPassengerTripRequestList();
                              },
                              onSelected: () {
                                if (selectedIdFilter.value == -1) {
                                  PassengerTripController.to.reqStatusFilter = 0;
                                } else {
                                  PassengerTripController.to.reqStatusFilter = selectedIdFilter.value;
                                }
                              },
                              items: const {"در حال انتظار": 1, "تایید شده": 2, "رد شده": 3, "لغو شده": 4},
                            ),
                          ),
                        ],
                      ),
                    ),
                    Obx(
                      () => Expanded(
                        child: (PassengerTripController.to.passengerReqTripList.isEmpty)
                            ? const Center(child: Text("آیتمی برای نمایش وجود ندارد."))
                            : ListView.builder(
                                shrinkWrap: true,
                                itemCount: PassengerTripController.to.passengerReqTripList.length,
                                itemBuilder: (context, index) {
                                  final TripReqData tripReqData =
                                      PassengerTripController.to.passengerReqTripList[index];
                                  return Container(
                                    margin: const EdgeInsets.all(8),
                                    padding: const EdgeInsets.symmetric(vertical: 16),
                                    decoration: defaultBoxDeco,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(right: 16.0),
                                              child: Row(
                                                children: [
                                                  const Text(
                                                    'نام و نام خانوادگی: ',
                                                    style: TextStyle(color: Colors.grey),
                                                  ),
                                                  Text(tripReqData.userFullName)
                                                ],
                                              ),
                                            ),
                                            Container(
                                              alignment: Alignment.center,
                                              width: 80,
                                              height: 35,
                                              decoration: BoxDecoration(
                                                  borderRadius: const BorderRadius.only(
                                                      bottomRight: Radius.circular(16), topRight: Radius.circular(16)),
                                                  color: (tripReqData.status == 1
                                                          ? Colors.amber
                                                          : tripReqData.status == 2
                                                              ? Colors.green.shade800
                                                              : tripReqData.status == 3
                                                                  ? Colors.red.shade800
                                                                  : Colors.red)
                                                      .withOpacity(0.2)),
                                              child: Text(
                                                tripReqData.status == 1
                                                    ? "در حال انتظار"
                                                    : tripReqData.status == 2
                                                        ? "تایید شده"
                                                        : tripReqData.status == 3
                                                            ? "رد شده"
                                                            : "لغو شده",
                                                style: TextStyle(
                                                    color: tripReqData.status == 1
                                                        ? Colors.amber
                                                        : tripReqData.status == 2
                                                            ? Colors.green.shade800
                                                            : tripReqData.status == 3
                                                                ? Colors.red.shade800
                                                                : Colors.red,
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w600),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                child: Row(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    const Text(
                                                      'حدود آدرس: ',
                                                      style: TextStyle(color: Colors.grey),
                                                    ),
                                                    const SizedBox(
                                                      width: 4,
                                                    ),
                                                    Expanded(child: Text(tripReqData.sourcePath))
                                                  ],
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 8,
                                              ),
                                              Row(
                                                children: [
                                                  const Text(
                                                    'تعداد صندلی درخواستی: ',
                                                    style: TextStyle(color: Colors.grey),
                                                  ),
                                                  Text(tripReqData.personCount.toString()),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        Container(
                                          width: Get.width,
                                          padding: const EdgeInsets.all(12),
                                          margin: const EdgeInsets.symmetric(horizontal: 16),
                                          decoration: BoxDecoration(
                                            color: Colors.grey.withOpacity(0.1),
                                            borderRadius: const BorderRadius.all(
                                              Radius.circular(16),
                                            ),
                                          ),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              const Text(
                                                'توضیحات مسافر',
                                                style: TextStyle(color: Colors.grey),
                                              ),
                                              const SizedBox(
                                                height: 8,
                                              ),
                                              Text(tripReqData.reqDescription)
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 12,
                                        ),
                                        Visibility(
                                          visible: tripReqData.acceptOrRejectDescription.isNotEmpty,
                                          child: Container(
                                            width: Get.width,
                                            padding: const EdgeInsets.all(12),
                                            margin: const EdgeInsets.symmetric(horizontal: 16),
                                            decoration: BoxDecoration(
                                              color: (tripReqData.status == 2 ? Colors.green : Colors.red)
                                                  .withOpacity(0.1),
                                              borderRadius: const BorderRadius.all(
                                                Radius.circular(16),
                                              ),
                                            ),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'توضیحات ${tripReqData.status == 2 ? 'تایید درخواست' : 'رد درخواست'}',
                                                  style: const TextStyle(color: Colors.grey),
                                                ),
                                                const SizedBox(
                                                  height: 8,
                                                ),
                                                Text(
                                                  tripReqData.acceptOrRejectDescription,
                                                  style: TextStyle(
                                                      color:
                                                          tripReqData.status == 2 ? Colors.green.shade900 : Colors.red),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(right: 16.0),
                                          child: Visibility(
                                            visible: tripReqData.status == 1,
                                            child: ElevatedButtonWidget(
                                              onPressed: () async {
                                                secondaryAlert(Get.context!, 'هشدار!', AlertType.warning,
                                                    'آیا از لغو اطمینان دارید؟', 'خیر', 'بله', () {
                                                  Get.back();
                                                }, () async {
                                                  Get.back();

                                                  await PassengerTripController.to.cancelRequest(tripReqData.id);
                                                }, buttonColor: Constants.passengerColor);
                                              },
                                              backgroundColor: Constants.passengerColor,
                                              child: const Text("لغو درخواست"),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  );
                                },
                              ),
                      ),
                    ),
                  ],
                );
              }
            },
          )
        : Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text('برای مشاهده درخواست‌های خود، لطفا ابتدا ورود کنید.'),
                const SizedBox(
                  height: 16,
                ),
                ElevatedButtonWidget(
                    onPressed: () {
                      Get.toNamed('/RegisterPassengerView', arguments: [false]); // if in req list screen
                    },
                    backgroundColor: Constants.passengerColor,
                    child: const Text("ورود به حساب کاربری"))
              ],
            ),
          );
  }
}
