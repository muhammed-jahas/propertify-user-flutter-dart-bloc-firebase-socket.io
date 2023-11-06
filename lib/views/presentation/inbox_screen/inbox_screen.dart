import 'package:flutter/material.dart';
import 'package:propertify/views/presentation/chat_screen/chat_single_screen.dart';
import 'package:propertify/constants/spaces%20&%20paddings/paddings.dart';
import 'package:propertify/constants/spaces%20&%20paddings/spaces.dart';
import 'package:propertify/constants/text_styles/text_styles.dart';


class InboxScreen extends StatelessWidget {
  const InboxScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          Padding(
            padding: customPaddings.horizontalpadding20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                customSpaces.verticalspace20,
                Text(
                  "Inbox",
                  style: AppFonts.SecondaryColorText28,
                ),
                ListTile(
                  onTap: () {
                    // Navigator.of(context).push(MaterialPageRoute(builder: (context) => ChatSingleScreen(),));
                  },
                  contentPadding: EdgeInsets.all(0),
                  leading: CircleAvatar(),
                  title: Text('Michael Angelo', style: AppFonts.SecondaryColorText18,),
                  subtitle: Text('This property is mostly wooded...',style: AppFonts.SecondaryColorText12,),
                  trailing: Text('12:15 PM', style: AppFonts.PrimaryColorText12,),
                ),
                
              ],
            ),
          ),
          Divider(),
        ],
      ),
    );
  }
}
