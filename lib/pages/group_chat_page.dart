import 'package:chatting_app_1/models/chat_bubble.dart';
import 'package:chatting_app_1/models/my_textfield.dart';
import 'package:chatting_app_1/services/chat/chat_service.dart';

import 'package:flutter/material.dart';

class GroupChatPage extends StatefulWidget {
  final String groupId;
  final String groupName;

  GroupChatPage({required this.groupId, required this.groupName});

  @override
  _GroupChatPageState createState() => _GroupChatPageState();
}

class _GroupChatPageState extends State<GroupChatPage> {
  TextEditingController _messageController = TextEditingController();
  final ChatService _chatService = ChatService();
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  void _sendMessage() async {
    if (_messageController.text.isNotEmpty) {
      await _chatService.sendGroupMessage(
          widget.groupId, _messageController.text);
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.groupName),
      ),
      body: Column(
        children: [
          Expanded(
            child: _buildMessageList(),
          ),
          _buildUserInput(),
        ],
      ),
    );
  }

  Widget _buildMessageList() {
    return StreamBuilder(
      stream: _chatService.getGroupMessages(widget.groupId),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text("Error loading messages"));
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        var messages = snapshot.data!.docs;
        return ListView.builder(
          controller: _scrollController,
          itemCount: messages.length,
          itemBuilder: (context, index) {
            var message = messages[index];
            return FutureBuilder(
              future: _chatService.getUsername(message['senderID']),
              builder: (context, usernameSnapshot) {
                if (usernameSnapshot.connectionState ==
                        ConnectionState.waiting ||
                    !usernameSnapshot.hasData) {
                  return SizedBox(); // Return an empty SizedBox while waiting
                }
                var username = usernameSnapshot.data;
                return ChatBubble(
                  message: message['message'],
                  username: username,
                  isCurrentUser:
                      message['senderID'] == _chatService.getCurrentUser()!.uid,
                );
              },
            );
          },
        );
      },
    );
  }

  Widget _buildUserInput() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 50.0, right: 10.0),
      child: Row(
        children: [
          Expanded(
            child: MyTextField(
              controller: _messageController,
              hintText: "Type a message",
              obscureText: false,
            ),
          ),
          Container(
            decoration:
                BoxDecoration(color: Colors.green, shape: BoxShape.circle),
            child: IconButton(
              onPressed: _sendMessage,
              icon: Icon(Icons.arrow_upward, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}