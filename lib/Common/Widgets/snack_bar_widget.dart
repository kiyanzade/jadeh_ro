import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Config/constant.dart';

enum SnackBarWidgetType { success, failure }

void snackBarWidget({
  required String messageText,
  required SnackBarWidgetType type,
}) {
  Get.snackbar(
    type == SnackBarWidgetType.success ? 'موفق!' : 'خطا!',
    messageText,
    backgroundColor:
        type == SnackBarWidgetType.success ? Colors.green : Constants.redColor,
    colorText: Colors.white,
    borderRadius: 8,
    icon: Icon(
      type == SnackBarWidgetType.success ? Icons.check : Icons.error,
      color: Colors.white,
    ),
    margin: const EdgeInsets.only(top: 10, right: 10, left: 10),
    padding: const EdgeInsets.all(5),
    duration: const Duration(seconds: 5),
    animationDuration: const Duration(milliseconds: 250),
    overlayColor: Colors.grey.withOpacity(0.5),
    overlayBlur: 2,
    isDismissible: true,
    snackPosition: SnackPosition.TOP,
  );
}
