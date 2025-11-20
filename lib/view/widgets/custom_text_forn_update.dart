import 'package:flutter/material.dart';

class CustomTextForm extends StatelessWidget {
  const CustomTextForm({
    super.key,
    required this.hintText,
    this.onSaved,
    this.autoValidateMode,
    this.onChanged,
    this.icon,
    this.controller
  });
  final TextEditingController? controller;
  final String hintText;
  final AutovalidateMode? autoValidateMode;
  final void Function(String?)? onSaved;
  final void Function(String)? onChanged;
  final IconButton? icon;
  @override
  Widget build(BuildContext context) {
    return TextFormField(

      style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold),
      onChanged: onChanged,

      autovalidateMode: autoValidateMode,
      onSaved: onSaved,
      controller: controller,

      decoration: InputDecoration(
        suffixIcon: icon,
        hint: Text(hintText, style: TextStyle(color: Colors.grey)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: Colors.blue, width: 2),
        ),
        enabledBorder: OutlineInputBorder(borderSide: BorderSide(width: 2,color: Colors.deepPurpleAccent),borderRadius: BorderRadius.circular(30)),
        focusedBorder: OutlineInputBorder(borderSide: BorderSide(width: 2,color: Colors.deepPurpleAccent),borderRadius: BorderRadius.circular(30)),
      ),
    );
  }
}
