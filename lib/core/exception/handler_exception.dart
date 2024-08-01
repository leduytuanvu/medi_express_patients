import 'package:flutter/material.dart';
import 'failure.dart';

void handleException(BuildContext context, Failure failure) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(failure.message)),
  );
}
