import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

void primaryAlert({
  double? width = 100,
  required BuildContext context,
  required String title,
  required AlertType type,
  String? desc,
  required String buttonText,
  void Function()? onPressed,
  Color? buttonColor,
}) {
  Alert(
    onWillPopActive: true,
    context: context,
    type: type,
    title: title,
    style: const AlertStyle(
      isCloseButton: false,
      descStyle: TextStyle(color: Colors.grey, fontSize: 14),
      titleStyle: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
    ),
    desc: desc,
    buttons: [
      DialogButton(
        color: buttonColor,
        onPressed: onPressed,
        width: width,
        padding: EdgeInsets.zero,
        child: Text(
          buttonText,
          textScaler: TextScaler.noScaling,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      )
    ],
  ).show();
}

void secondaryAlert(
  BuildContext context,
  String title,
  AlertType type,
  String? desc,
  String noText,
  String yesText,
  void Function()? noPressed,
  void Function()? yesPressed, {
  double? width = 100,
  Color buttonColor = Colors.white,
}) {
  Alert(
    onWillPopActive: true,
    context: context,
    type: type,
    title: title,
    style: const AlertStyle(
      isCloseButton: false,
      descStyle: TextStyle(
        color: Colors.grey,
        fontSize: 14,
        fontWeight: FontWeight.bold,
      ),
      titleStyle: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
    ),
    desc: desc,
    buttons: [
      DialogButton(
        color: Colors.white,
        onPressed: noPressed,
        width: width,
        border: Border.all(color: buttonColor),
        padding: EdgeInsets.zero,
        child: Text(
          noText,
          style: TextStyle(
            color: buttonColor,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      DialogButton(
        color: buttonColor,
        onPressed: yesPressed,
        width: width,
        padding: EdgeInsets.zero,
        child: Text(
          yesText,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ],
  ).show();
}
