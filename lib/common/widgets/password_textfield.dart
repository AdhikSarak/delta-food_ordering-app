import 'package:flutter/material.dart';

class PassTextfield extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  const PassTextfield(
      {super.key, required this.controller, required this.hintText});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: true,
      controller: controller,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.key_outlined),
        labelText: hintText,        
        hintText: hintText,
        border: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black38,
          ),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black38,
          ),
        ),
      ),
      validator: (val) {
        if (val!.length < 8) {
          return 'Password must contain at least 7 characters';
        }
        return null;
      },
    );
  }
}