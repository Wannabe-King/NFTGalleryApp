import 'package:flutter/material.dart';

class ButtonX extends StatelessWidget {
  final String buttonLable;
  final Color? lableColor;
  final Color? buttonColor;
  final Function() click;
  const ButtonX(
      {super.key,
      required this.buttonLable,
      this.lableColor,
      this.buttonColor,
      required this.click});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: click,
      child: Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(color: buttonColor ?? Colors.grey[700]),
        child: Text(
          buttonLable,
          style: TextStyle(color: lableColor ?? Colors.white),
        ),
      ),
    );
  }
}
