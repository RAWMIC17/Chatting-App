import 'dart:io';
import 'package:chatting_app_1/models/chat_bubble.dart';
import 'package:chatting_app_1/models/my_textfield.dart';
import 'package:chatting_app_1/services/auth/auth_service.dart';
import 'package:chatting_app_1/services/chat/chat_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

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
  final AuthService _authService = AuthService();
  final ScrollController _scrollController = ScrollController();
  File? _selectedFile;
  final Reference _storageRef =
      FirebaseStorage.instance.ref().child('group_chat_files');

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  Future<void> _sendMessage({String? fileUrl}) async {
    if (_messageController.text.isNotEmpty || fileUrl != null) {
      await _chatService.sendGroupMessage(
        widget.groupId,
        _messageController.text,
        fileUrl: fileUrl,
      );
      _messageController.clear();
    }
  }

  Future<void> _selectFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      File file = File(result.files.single.path!);
      setState(() {
        _selectedFile = file;
      });
      String fileUrl = await _uploadFile(file);
      await _sendMessage(fileUrl: fileUrl);
    }
  }

  Future<String> _uploadFile(File file) async {
    try {
      TaskSnapshot task = await _storageRef.child(file.path).putFile(file);
      return await task.ref.getDownloadURL();
    } catch (e) {
      print('Error uploading file: $e');
      return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.groupName),
        actions: [
          IconButton(
            icon: Icon(Icons.attach_file),
            onPressed: _selectFile,
          ),
        ],
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
                      message['senderID'] == _authService.getCurrentUser()!.uid,
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
