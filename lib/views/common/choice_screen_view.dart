import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jadehro_app/Widgets/list_widget.dart';
import 'package:jadehro_app/controllers/common_controller.dart';
import 'package:jadehro_app/widgets/button_widget.dart';
import 'package:jadehro_app/Config/constant.dart';

import '../../gen/assets.gen.dart';

class ChoiceScreenView extends StatelessWidget {
  const ChoiceScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            children: [
              Assets.images.img.image(),
              const SizedBox(
                height: 64,
              ),
              Column(
                children: [
                  ElevatedButtonWidget(
                    fixedSize: Size(Get.width, 65),
                    onPressed: () {
                      Get.toNamed('/RegisterDriverView');
                    },
                    backgroundColor: Constants.driverColor,
                    child: const Text("صندلی خالی دارم (راننده ام)"),
                  ),
                  const Divider(
                    height: 36,
                    endIndent: 36,
                    indent: 36,
                  ),
                  ElevatedButtonWidget(
                    fixedSize: Size(Get.width, 65),
                    onPressed: () async {
                      CommonController.to.provinceListSearch.clear();
                      await CommonController.to.getProvinceList();
                      Get.to(const ProvinceSourceListWidget(),
                          arguments: [true]);
                    },
                    backgroundColor: Constants.passengerColor,
                    child: const Text("دنبال ماشین می گردم (مسافرم)"),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
