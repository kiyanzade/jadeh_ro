import 'package:flutter/material.dart';

enum FilterChipWidgetType { delete, onlySelect }

class FilterChipWidget extends StatelessWidget {
  const FilterChipWidget({
    super.key,
    required this.text,
    required this.filterChipWidget,
    this.onDeleted,
    this.onTap,
  });

  final String text;
  final void Function()? onDeleted;
  final void Function()? onTap;
  final FilterChipWidgetType filterChipWidget;

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(right: 10),
        child: Directionality(
          textDirection: filterChipWidget == FilterChipWidgetType.onlySelect
              ? TextDirection.rtl
              : TextDirection.ltr,
          child: Chip(
            avatar: filterChipWidget == FilterChipWidgetType.onlySelect
                ? Icon(
                    Icons.arrow_drop_down,
                    color: themeData.colorScheme.inverseSurface,
                  )
                : null,
            color: MaterialStatePropertyAll(
              themeData.colorScheme.tertiaryContainer,
            ),
            shape: RoundedRectangleBorder(
              side: const BorderSide(style: BorderStyle.none),
              borderRadius: BorderRadius.circular(16),
            ),
            label: Text(
              text,
              textScaler: TextScaler.noScaling,
              style: themeData.textTheme.bodyMedium,
            ),
            onDeleted: filterChipWidget == FilterChipWidgetType.onlySelect
                ? null
                : onDeleted,
            elevation: 0,
            visualDensity: VisualDensity.compact,
          ),
        ),
      ),
    );
  }
}
