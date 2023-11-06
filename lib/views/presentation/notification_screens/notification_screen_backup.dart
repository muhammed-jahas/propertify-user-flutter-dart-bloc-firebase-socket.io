import 'package:flutter/material.dart';
import 'package:propertify/resources/app_urls/app_urls.dart';
import 'package:propertify/views/presentation/notification_screens/notification_single_screen.dart';
import 'package:propertify/constants/spaces%20&%20paddings/paddings.dart';
import 'package:propertify/constants/spaces%20&%20paddings/spaces.dart';
import 'package:propertify/constants/text_styles/text_styles.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import '../chat_screen/chat_single_screen.dart';

class NotificationScreen extends StatelessWidget {
  NotificationScreen({super.key});
  startChat(BuildContext context) async {
    // Establish a Socket.io connection with the server
    final IO.Socket socket = IO.io(Appurls.baseUrl,IO.OptionBuilder().setTransports(['websocket']).build()); // Replace with your server URL
    print('heloooo');
      socket.onConnect((data) => print('Connection Established'));
    
    // Identify the user or agent role
    final role = 'user'; // Replace with 'user' for user app
    socket.emit('identify', role);
    print('heloooo');
    // Create a chat room and inform the server
    socket.emit('joinRoom', 'unique_room_name');

    // Navigate to ChatSingleScreen and pass the request and socket
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => ChatSingleScreen(socket: socket),));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            customSpaces.verticalspace40,
            Padding(
              padding: customPaddings.horizontalpadding20,
              child: Text(
                "Notifications",
                style: AppFonts.SecondaryColorText28,
              ),
            ),
            customSpaces.verticalspace10,
            InkWell(
              onTap: () {
               startChat(context);
              },
              child: Padding(
                padding: customPaddings.horizontalpadding20,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CircleAvatar(),
                      Text('You have a new payment request'),
                      Icon(Icons.arrow_forward)
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
  
  
}
