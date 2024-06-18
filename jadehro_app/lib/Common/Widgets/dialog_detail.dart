import 'package:flutter/material.dart';
import 'package:get/get.dart';



void requestToDriver() async {
  Get.bottomSheet(
    const SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Row(
            children: [
              Text('ظرفیت درخواستی: '),
            ],
          )
        ],
      ),
    ),
    backgroundColor: Colors.white,
    barrierColor: Colors.black.withOpacity(0.7),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(10),
        topRight: Radius.circular(10),
      ),
    ),
    enableDrag: true,
    isDismissible: true,
    isScrollControlled: true,
    elevation: 0,
  );
}
