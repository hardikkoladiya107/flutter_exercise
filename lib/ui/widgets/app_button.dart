import 'package:flutter/material.dart';
import 'package:flutter_exercise/utils/common_extension.dart';

import '../../other/app_colors.dart';

class AppButton extends StatelessWidget {
  final Function() onPress;
  final double height;
  final double borderValue;
  final String? text;
  final bool visible;
  final Color? buttonColor;
  final Widget? widget;

  const AppButton({
    Key? key,
    required this.onPress,
    this.visible = false,
    required this.borderValue,
    this.height = 50,
    this.buttonColor,
    this.widget,
    this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderValue),
        color: buttonColor ?? appButtonColor,
      ),
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor:
              MaterialStateProperty.all(buttonColor ?? buttonColor),
          elevation: MaterialStateProperty.all(10),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderValue),
            ),
          ),
        ),
        onPressed: () {
          onPress();
        },
        child: Center(
          child: widget ?? text.text(),
        ),
      ),
    );
  }
}
