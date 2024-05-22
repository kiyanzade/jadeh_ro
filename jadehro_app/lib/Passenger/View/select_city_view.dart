import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Common/Controller/common_controller.dart';
import '../../Common/Widgets/list_widget.dart';
import '../../Config/constant.dart';

class SelectCityScreenView extends StatefulWidget {
  const SelectCityScreenView({super.key});

  @override
  State<SelectCityScreenView> createState() => _SelectCityScreenViewState();
}

class _SelectCityScreenViewState extends State<SelectCityScreenView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // body: 
      // ProvinceListWidget(
      //   color: Constants.passengerColor,
      //   listName: CommonController.to.provinceList,
      //   onTapItems: () {
      //     Get.toNamed('/MainScreenPassengerView');
      //   },
      //   onTapSearch: () {},
      //   label: 'شهر',
      // ),
    );
  }
}
