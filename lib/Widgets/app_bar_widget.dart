import 'package:flutter/material.dart';


PreferredSizeWidget? appBarWidget({
  required String title,
  required Color backgroundColor,
}) {
  return AppBar(
    backgroundColor: backgroundColor,
    title: Text(
      title,
      style: const TextStyle(
          color: Colors.white, fontSize: 16, fontWeight: FontWeight.w700),
    ),
    centerTitle: true,
    elevation: 0,
    iconTheme: const IconThemeData(color: Colors.white),
  );
}
