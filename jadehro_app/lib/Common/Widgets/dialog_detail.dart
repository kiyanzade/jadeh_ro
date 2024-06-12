import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jadehro_app/Config/constant.dart';
import 'package:jadehro_app/Driver/Controller/driver_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher_string.dart';

import 'button_widget.dart';


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
