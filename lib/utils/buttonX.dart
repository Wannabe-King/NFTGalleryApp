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
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        height: 50,
        decoration: BoxDecoration(
            color: buttonColor ?? Colors.grey[700],
            borderRadius: BorderRadius.circular(10)),
        child: Text(
          buttonLable,
          style: TextStyle(fontSize: 20, color: lableColor ?? Colors.white),
        ),
      ),
    );
  }
}
