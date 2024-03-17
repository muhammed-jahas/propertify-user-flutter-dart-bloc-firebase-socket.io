import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:propertify/constants/colors/colors.dart';
import 'package:propertify/constants/spaces%20&%20paddings/spaces.dart';

class CustomInputFieldOtp extends StatelessWidget {
  CustomInputFieldOtp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
      child: Row(
        children: [
          customSpaces.horizontalspace10,
          Expanded(
            child: TextFormField(
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: AppColors.secondaryColor,
              ),
              decoration: InputDecoration(
                  hintStyle: TextStyle(
                    color: Colors.grey.shade400,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                  border: InputBorder.none),
            ),
          ),
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class MobileInputField extends StatelessWidget {
  TextEditingController controller;

  MobileInputField({Key? key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
      child: Row(
        children: [
          Container(
              child: Flag(
            Flags.india,
            size: 24,
          )),
          customSpaces.horizontalspace10,
          Text(
            '+91',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: AppColors.secondaryColor,
            ),
          ),
          customSpaces.horizontalspace10,
          Expanded(
            child: TextFormField(
              controller: controller, // Use the provided controller here
              keyboardType: TextInputType.number,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppColors.secondaryColor,
              ),
              inputFormatters: [
                LengthLimitingTextInputFormatter(
                    10), // Set maximum length to 10
              ],
              onChanged: (text) {
                if (text.length >= 10) {
                  // Dismiss the keyboard when the input reaches 10 characters.
                  FocusScope.of(context).unfocus();
                }
              },
              decoration: InputDecoration(
                  hintText: 'Enter your phone number',
                  hintStyle: TextStyle(
                    color: Colors.grey.shade400,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                  border: InputBorder.none),
            ),
          ),
        ],
      ),
    );
  }
}

class LengthLimitingTextInputFormatter extends TextInputFormatter {
  final int maxLength;

  LengthLimitingTextInputFormatter(this.maxLength);

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.length > maxLength) {
      // Truncate the text to the maximum length.
      return TextEditingValue(
        text: newValue.text.substring(0, maxLength),
        selection: newValue.selection.copyWith(
          baseOffset: newValue.text.length,
          extentOffset: newValue.text.length,
        ),
      );
    }
    return newValue;
  }
}

// ignore: must_be_immutable
class CustomInputField extends StatelessWidget {
  final IconData? fieldIcon;
  final String hintText;
  final int? maxLines;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final Color? bgColor;
  final Color? borderColor;
  final bool? enabled;
  final void Function(String)? onChanged; // Add onChanged callback
  final void Function()? onTap; // Add onTap callback
  final bool editable; // Add editable property

  CustomInputField({
    Key? key,
    this.fieldIcon,
    required this.hintText,
    this.maxLines,
    this.controller,
    this.keyboardType,
    this.validator,
    this.bgColor,
    this.borderColor,
    this.enabled = true,
    this.onChanged, // Include onChanged in the constructor
    this.editable = false,
    this.onTap, // Include editable in the constructor
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: bgColor ?? Colors.transparent,
          // border: Border.all(
          //   color: borderColor ?? Colors.grey,
          // ),
        ),
        child: TextFormField(
          onTap: () {
            if (onTap != null && editable) {
              onTap!();
            }
          },
          enabled: enabled,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          textAlignVertical: TextAlignVertical.center,
          controller: controller,
          validator: validator,
          keyboardType: keyboardType,
          maxLines: maxLines ?? 1,
          onChanged: onChanged, // Pass onChanged callback to TextFormField
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppColors.secondaryColor,
          ),
          readOnly: editable, // Use editable property here
          decoration: InputDecoration(
            prefixIcon: Icon(
              fieldIcon ?? null,
              color: Colors.grey.shade500,
              size: 20,
            ),
            hintText: hintText,
            hintStyle: TextStyle(
              color: Colors.grey.shade400,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: BorderSide(
                color: borderColor ?? Colors.grey,
                width: 1,
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: BorderSide(
                color: Colors.red,
                width: 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: BorderSide(
                color: borderColor ?? Colors.black,
                width: 1,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: BorderSide(
                color: borderColor ?? Colors.red,
                width: 1,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: BorderSide(
                color: borderColor ?? Colors.red,
                width: 1,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CustomMultiLineInputField extends StatefulWidget {
  final IconData? fieldIcon;
  final String hintText;
  final int? maxLines;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;

  CustomMultiLineInputField({
    Key? key,
    this.fieldIcon,
    required this.hintText,
    this.maxLines,
    this.controller,
    this.keyboardType,
    this.validator,
  }) : super(key: key);

  @override
  _CustomMultiLineInputFieldState createState() =>
      _CustomMultiLineInputFieldState();
}

class _CustomMultiLineInputFieldState extends State<CustomMultiLineInputField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: EdgeInsets.fromLTRB(10, 5, 10, 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              customSpaces.horizontalspace10,
              Expanded(
                child: TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: widget.controller,
                  validator: widget.validator,
                  keyboardType: widget.keyboardType,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.secondaryColor,
                  ),
                  maxLines: widget.maxLines ?? 5,
                  maxLength: 512, // Set the maximum character limit
                  decoration: InputDecoration(
                    hintText: widget.hintText,
                    hintStyle: TextStyle(
                      color: Colors.grey.shade400,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ],
          ),
          // Align(
          //   alignment: Alignment.topRight,
          //   child: Text(
          //     '${widget.controller?.text.length ?? 0}/512', // Display character count
          //     style: TextStyle(
          //       color: Colors.grey,
          //       fontSize: 12,
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
