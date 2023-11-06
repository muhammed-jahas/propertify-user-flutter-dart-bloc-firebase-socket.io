import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../../../resources/app_urls/app_urls.dart';
class ChatSingleScreen extends StatefulWidget {
  final Socket socket;
  
  ChatSingleScreen({Key? key, required this.socket}) : super(key: key);

  @override
  _ChatSingleScreenState createState() => _ChatSingleScreenState();
}

class _ChatSingleScreenState extends State<ChatSingleScreen> {
  final TextEditingController messageController = TextEditingController();
  final List<String> messages = [];
  final roomName = 'unique_room_name'; // Use the same room name as in NotificationSingleScreen

  @override
  void initState() {
    super.initState();

   final IO.Socket socket = IO.io(Appurls.baseUrl,IO.OptionBuilder().setTransports(['websocket']).build()); // Replace with your server URL


socket.onConnect((data) => print('Connection Established'));
socket.emit('identify', 'user');
socket.emit('joinRoom', roomName);

socket.on('message', (data) {
  // Update the UI with the new message
  final message = data['message'];
  setState(() {
    messages.add(message);
  });
});
  }

  sendMessage(String message) {
    // Send the message to the server
    widget.socket.emit('message', {
      'roomName': roomName,
      'message': message,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(messages[index]),
                );
              },
            ),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: messageController,
                  decoration: InputDecoration(labelText: 'Type a message'),
                ),
              ),
              IconButton(
                icon: Icon(Icons.send),
               onPressed: () {
                  final message = messageController.text;
                  if (message.isNotEmpty) {
                    sendMessage(message);
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
