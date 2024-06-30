import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jadehro_app/Config/api_client_config.dart';
import 'package:jadehro_app/Config/constant.dart';

final RxInt selectedIdFilter = RxInt(-1);

class FilterChipWidget extends StatefulWidget {
  final Map<String, int> items;
  final VoidCallback everyCall;
  final VoidCallback onSelected;

  const FilterChipWidget({
    super.key,
    required this.everyCall,
    required this.onSelected,
    required this.items,
  });

  @override
  State<FilterChipWidget> createState() => _FilterChipWidgetState();
}

class _FilterChipWidgetState extends State<FilterChipWidget> {
  @override
  Widget build(BuildContext context) {
    List<String> labelText = widget.items.keys.toList();
    List<int> itemId = widget.items.values.toList();
    final ThemeData themeData = Theme.of(context);
    return Expanded(
      child: SizedBox(
        height: 40,
        child: ListView.builder(
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemCount: widget.items.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Obx(
                () => FilterChip(
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(
                      style: BorderStyle.none,
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  label: Text(
                    labelText[index],
                    textScaler: TextScaler.noScaling,
                  ),
                  onSelected: !showLoading.value
                      ? (value) async {
                          if (selectedIdFilter.value == itemId[index]) {
                            selectedIdFilter.value = -1;
                          } else {
                            selectedIdFilter.value = itemId[index];
                          }
                          widget.onSelected();
                          widget.everyCall();
                        }
                      : null,
                  backgroundColor: Colors.grey.shade200,
                  pressElevation: 0,
                  elevation: 0,
                  visualDensity: VisualDensity.compact,
                  selected: selectedIdFilter.value == itemId[index],
                  selectedColor: Constants.driverColor,
                  checkmarkColor: Colors.white,
                  labelStyle: TextStyle(
                    color: selectedIdFilter.value == itemId[index]
                        ? Colors.white
                        : themeData.colorScheme.inverseSurface,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
