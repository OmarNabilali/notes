import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key, required this.buttonName, this.onPressed, required this.color});
  final Widget buttonName;
  final void Function()? onPressed;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child:buttonName,

      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        minimumSize: Size(340, 40),
        maximumSize: Size(340, 40)
      ),
    );
  }
}
