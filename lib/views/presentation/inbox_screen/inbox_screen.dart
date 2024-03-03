import 'package:flutter/material.dart';
import 'package:propertify/constants/spaces%20&%20paddings/paddings.dart';
import 'package:propertify/constants/spaces%20&%20paddings/spaces.dart';
import 'package:propertify/constants/text_styles/text_styles.dart';

// class InboxScreen extends StatelessWidget {
//   const InboxScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: ListView(
//         children: [
//           Padding(
//             padding: customPaddings.horizontalpadding20,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 customSpaces.verticalspace20,
//                 Text(
//                   "Inbox",
//                   style: AppFonts.SecondaryColorText28,
//                 ),
//                 ListTile(
//                   onTap: () {
//                     // Navigator.of(context).push(MaterialPageRoute(builder: (context) => ChatSingleScreen(),));
//                   },
//                   contentPadding: EdgeInsets.all(0),
//                   leading: CircleAvatar(),
//                   title: Text('Michael Angelo', style: AppFonts.SecondaryColorText18,),
//                   subtitle: Text('This property is mostly wooded...',style: AppFonts.SecondaryColorText12,),
//                   trailing: Text('12:15 PM', style: AppFonts.PrimaryColorText12,),
//                 ),

//               ],
//             ),
//           ),
//           Divider(),
//         ],
//       ),
//     );
//   }
// }

// socket_manager.dart
import 'package:socket_io_client/socket_io_client.dart' as IO;
// main.dart
import 'package:flutter/material.dart';

class SocketManager {
  static final SocketManager _instance = SocketManager._internal();
  late IO.Socket socket;

  factory SocketManager() {
    return _instance;
  }

  SocketManager._internal() {
    socket = IO.io('http://192.168.77.11:4000', <String, dynamic>{
      'transports': ['websocket'],
    });
  }
}

class InboxScreen extends StatefulWidget {
  @override
  _InboxScreenState createState() => _InboxScreenState();
}

class _InboxScreenState extends State<InboxScreen> {
  late IO.Socket socket;
  List<ChatEntry> chatEntries = [];

  @override
  void initState() {
    super.initState();
    socket = SocketManager().socket;
    socket.emit('loadChatEntries');
    socket.on('chatEntries', handleLoadChatEntries);
    socket.on('newChatEntry', handleNewChatEntry);
  }

  void handleLoadChatEntries(dynamic data) {
    print('Received chatEntries: $data');
    if (data is List) {
      setState(() {
        chatEntries = data.map((item) => ChatEntry.fromJson(item)).toList();
      });
    }
  }

  void handleNewChatEntry(dynamic data) {
    print('Received new chat entry: $data');
    if (data is List) {
      setState(() {
        chatEntries.addAll(data.map((item) => ChatEntry.fromJson(item)));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat Entries'),
      ),
      body: ListView.builder(
        itemCount: chatEntries.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(chatEntries[index].id),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      ChatScreen(chatEntryId: chatEntries[index].id),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          socket.emit('createChatEntry');
        },
        child: Icon(Icons.add),
      ),
    );
  }

  @override
  void dispose() {
    // No need to disconnect here
    super.dispose();
  }
}

class ChatScreen extends StatefulWidget {
  final String chatEntryId;

  ChatScreen({required this.chatEntryId});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late IO.Socket socket;
  TextEditingController messageController = TextEditingController();
  List<ChatMessage> messages = [];

  @override
  void initState() {
    super.initState();
    socket = SocketManager().socket;
    socket.emit('joinChatRoom', {'chatEntryId': widget.chatEntryId});
    socket.emit('loadMessages', {'chatEntryId': widget.chatEntryId});
    socket.on('message', handleMessage);
    socket.on('loadMessages', handleLoadMessages);
  }

  void handleMessage(dynamic data) {
    print('Received message: $data');
    if (data is Map<String, dynamic>) {
      if (mounted) {
        final message = ChatMessage.fromJson(data);
        addMessageToList(message);
      }
    }
  }

  void handleLoadMessages(dynamic data) {
    print('Received loadMessages: $data');
    if (data is List) {
      if (mounted) {
        setState(() {
          messages.clear(); // Clear existing messages
          addMessagesToList(
              data.map((item) => ChatMessage.fromJson(item)).toList());
        });
      }
    }
  }

  void addMessageToList(ChatMessage message) {
    setState(() {
      messages.add(message);
    });
  }

  void addMessagesToList(List<ChatMessage> newMessages) {
    setState(() {
      messages.addAll(newMessages);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat Room'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                return CustomChatMessage(message: messages[index]);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: messageController,
                    decoration: InputDecoration(
                      hintText: 'Enter your message...',
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    socket.emit('message', {
                      'message': messageController.text,
                      'sender': 'user',
                      'time': DateTime.now().toIso8601String(),
                      'chatEntryId': widget.chatEntryId,
                      'isUser': true, // Set isUser to false for user messages
                    });

                    messageController.clear();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    // No need to disconnect here
    super.dispose();
  }
}

class ChatEntry {
  final String id;

  ChatEntry({
    required this.id,
  });

  factory ChatEntry.fromJson(Map<String, dynamic> json) {
    return ChatEntry(
      id: json['_id'] ?? '',
    );
  }
}

class ChatMessage {
  final String message;
  final String sender;
  final DateTime time;
  bool isUser; // Updated isUser field

  ChatMessage({
    required this.message,
    required this.sender,
    required this.time,
    this.isUser = false, // Default value is false
  });

  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    return ChatMessage(
      message: json['message'] ?? '',
      sender: json['sender'] ?? '',
      time: DateTime.parse(json['time'] ?? ''),
      isUser: json['isUser'] ?? false,
    );
  }
}

class CustomChatMessage extends StatelessWidget {
  final ChatMessage message;

  CustomChatMessage({required this.message});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: message.isUser
            ? MainAxisAlignment.end
            : MainAxisAlignment.start, // Adjusted for both true and false cases
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: message.isUser ? Colors.blue[100] : Colors.green[100],
            ),
            padding: EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  message.message,
                  textAlign: TextAlign.left,
                ),
                SizedBox(height: 4),
                Text(
                  '${message.sender} - ${message.time.toLocal()}',
                  textAlign: TextAlign.left,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
