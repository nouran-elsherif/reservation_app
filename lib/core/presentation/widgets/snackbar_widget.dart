import 'package:flutter/material.dart' show SnackBar, Text;

SnackBar snackBar(String message) {
  return SnackBar(
    content: Text(message),
    duration: (const Duration(seconds: 1)),
  );
}
