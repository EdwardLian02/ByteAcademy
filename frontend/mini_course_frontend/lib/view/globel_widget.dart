import 'package:flutter/material.dart';

void showLoading(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => Center(
      child: CircularProgressIndicator(),
    ),
  );
}

void showMessage(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
}
