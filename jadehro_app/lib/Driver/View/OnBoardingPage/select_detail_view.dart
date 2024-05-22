import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Common/Widgets/text_field_widget.dart';
import '../../Controller/driver_trip_controller.dart';

class SelectDetailView extends StatefulWidget {
  const SelectDetailView({super.key});

  @override
  State<SelectDetailView> createState() => _SelectDetailViewState();
}

class _SelectDetailViewState extends State<SelectDetailView> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Container(
        padding: const EdgeInsets.all(10),
        height: Get.height,
        width: Get.width,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'توضیحات مربوطه سفر',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              TextFormFieldWidget(
                maxLines: 10,
                labelText: 'توضیحات',
                textAlign: TextAlign.right,
                controller: DriverTripController.to.selectedDescription,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
