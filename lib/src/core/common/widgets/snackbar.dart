import 'package:flutter/material.dart';
import 'package:loadin_guide_scann/src/core/theme/app_pallete.dart';

class SnackBarUtil {
  static void showSnackBar(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(text, textAlign: TextAlign.center),
      backgroundColor: AppPallete.whiteColor,
    ));
  }
}
