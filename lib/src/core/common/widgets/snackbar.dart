import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';

class SnackBarUtil {
  /// Displays an "Awesome" Snackbar using the [awesome_snackbar_content] package.
  /// Customize [title], [message], and [contentType] as needed.
  static void showSnackBar(
    BuildContext context,
    String message, {
    String title = 'Mensaje',
    ContentType contentType = ContentType.failure,
  }) {
    final snackBar = SnackBar(
      /// For best visual results with AwesomeSnackbarContent
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        title: title,
        message: message,
        contentType: contentType,
      ),
    );

    // Hide any current SnackBars before showing a new one
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }
}
