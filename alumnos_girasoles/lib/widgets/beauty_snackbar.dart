import 'package:flutter/material.dart';

class BeautySnackbar {
  static void show(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, textAlign: TextAlign.center),
        elevation: 10.0,
        margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 3),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(15.0),
        ),
      ),
    );
  }
}
