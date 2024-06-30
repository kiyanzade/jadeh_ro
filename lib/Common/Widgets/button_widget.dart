import 'package:flutter/material.dart';

class ElevatedButtonWidget extends StatelessWidget {
  final Color backgroundColor;
  final Size? fixedSize;
  final void Function() onPressed;
  final Widget child;
  const ElevatedButtonWidget({
    super.key,
    required this.onPressed,
    required this.child,
    required this.backgroundColor,
    this.fixedSize,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        overlayColor: MaterialStateProperty.all(Colors.transparent),
        backgroundColor: MaterialStatePropertyAll(backgroundColor),
        elevation: const MaterialStatePropertyAll(0),
        fixedSize: MaterialStatePropertyAll(fixedSize),
        shape: MaterialStatePropertyAll(RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        )),
      ),
      onPressed: onPressed,
      child: child,
    );
  }
}
