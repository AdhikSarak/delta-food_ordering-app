import 'package:flutter/material.dart';
import 'package:sundari/constants/global_variables.dart';

class DottedLoader extends StatelessWidget {
  const DottedLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return const LinearProgressIndicator(
      color: GlobalVariables.secondaryColor,
      backgroundColor: Colors.transparent,
    );
  }
}