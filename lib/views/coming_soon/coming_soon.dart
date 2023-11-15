import 'package:flutter/material.dart';
import 'package:propertify/constants/text_styles/text_styles.dart';

class ComingSoon extends StatelessWidget {
  const ComingSoon({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Coming Soon', style: AppFonts.SecondaryColorText20,),
      ),
    );
  }
}