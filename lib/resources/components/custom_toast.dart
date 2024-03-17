import 'package:flutter/material.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/widgets.dart';
import 'package:propertify/constants/colors/colors.dart';
import 'package:propertify/constants/text_styles/text_styles.dart';

showCustomToast(BuildContext context, String message, [Color? bgColor]) async {
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

showCustomBottomSheet(BuildContext context, String message,
    Function()? onYesPressed, Function()? onCancelPressed) {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 8.0),
            Text(message,
                textAlign: TextAlign.center,
                style: AppFonts.SecondaryColorText16),
            SizedBox(height: 8.0),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ButtonStyle(
                      padding: MaterialStatePropertyAll(EdgeInsets.all(14)),
                      elevation: MaterialStatePropertyAll(0),
                      backgroundColor:
                          MaterialStatePropertyAll(AppColors.primaryColor),
                    ),
                    onPressed: onCancelPressed ??
                        () {
                          Navigator.pop(context);
                        },
                    child: Text(
                      'Cancel',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(width: 10.0),
                Expanded(
                  child: ElevatedButton(
                    style: ButtonStyle(
                      padding: MaterialStatePropertyAll(EdgeInsets.all(14)),
                      elevation: MaterialStatePropertyAll(0),
                      backgroundColor:
                          MaterialStatePropertyAll(AppColors.alertColor),
                    ),
                    onPressed: onYesPressed ?? () {},
                    child: Text(
                      'Yes',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      );
    },
  );
}
