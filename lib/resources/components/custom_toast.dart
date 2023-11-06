import 'package:flutter/material.dart';
import 'package:another_flushbar/flushbar.dart';

 showCustomToast(BuildContext context,String message, [Color? bgColor]) async {
  Flushbar(
    message: message,
    icon: Icon(
      Icons.info,
      color: Colors.white,
    ),
    backgroundColor: bgColor ?? Colors.blue,
    duration: Duration(seconds: 3),
  )..show(context);
}