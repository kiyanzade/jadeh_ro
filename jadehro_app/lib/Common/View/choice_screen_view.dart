import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jadehro_app/Common/Controller/common_controller.dart';
import 'package:jadehro_app/Common/Widgets/button_widget.dart';
import 'package:jadehro_app/Config/constant.dart';


import '../../gen/assets.gen.dart';
import '../Widgets/list_widget.dart';

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
                      Get.to(
                        const ProvinceListWidget(),
                      );
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
