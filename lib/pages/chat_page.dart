import 'dart:io';
import 'package:chatting_app_1/models/chat_bubble.dart';
import 'package:chatting_app_1/models/my_textfield.dart';
import 'package:chatting_app_1/pages/bottomnavigationbar.dart';
import 'package:chatting_app_1/services/auth/auth_service.dart';
import 'package:chatting_app_1/services/chat/chat_service.dart';
import 'package:chatting_app_1/utils/theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:velocity_x/velocity_x.dart';

class ChatPage extends StatefulWidget {
  final String recieverEmail;
  final String recieverID;
  final String recieverUserName;

  ChatPage(
      {super.key,
      required this.recieverEmail,
      required this.recieverID,
      required this.recieverUserName});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  TextEditingController _messageController = TextEditingController();
  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();
  FocusNode myFocusNode = FocusNode();
  File? _selectedFile;
  final Reference _storageRef =
      FirebaseStorage.instance.ref().child('chat_files');

  @override
  void initState() {
    super.initState();
    myFocusNode.addListener(() {
      if (myFocusNode.hasFocus) {
        Future.delayed(
          const Duration(milliseconds: 500),
          () => scrollDown(),
        );
      }
    });
  }

  @override
  void dispose() {
    myFocusNode.dispose();
    _messageController.dispose();
    super.dispose();
  }

  final ScrollController _scrollcontroller = ScrollController();
  void scrollDown() {
    _scrollcontroller.animateTo(_scrollcontroller.position.maxScrollExtent,
        duration: const Duration(seconds: 1), curve: Curves.fastOutSlowIn);
  }

  Future<void> _sendMessage({String? fileUrl}) async {
    if (_messageController.text.isNotEmpty || fileUrl != null) {
      await _chatService.sendMessage(
        widget.recieverID,
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
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: Colors.black,
        title: Text(
          widget.recieverUserName,
          style: TextStyle(color: Colors.white,),
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => BottomNavigationBarPage()));
            },
            icon: Icon(
              CupertinoIcons.arrow_left,
              color: Mycolors.textcolorwhite,
            )),
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
    String senderID = _authService.getCurrentUser()!.uid;
    return StreamBuilder(
      stream: _chatService.getMessages(widget.recieverID, senderID),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text("Error");
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading..");
        }
        return ListView(
          controller: _scrollcontroller,
          children:
              snapshot.data!.docs.map((doc) => _buildMessageItem(doc)).toList(),
        );
      },
    );
  }

  Widget _buildMessageItem(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    bool isCurrentUser = data['senderID'] == _authService.getCurrentUser()!.uid;
    var alignment =
        isCurrentUser ? Alignment.centerRight : Alignment.centerLeft;

    return Container(
      alignment: alignment,
      child: ChatBubble(
        message: data["message"],
        isCurrentUser: isCurrentUser,
        username: data["fileUrl"] != null ? "File" : null,
        fileUrl: data["fileUrl"],
      ),
    );
  }

  Widget _buildUserInput() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: MyTextField(
              controller: _messageController,
              hintText: "Type a message. . .",
              obscureText: false,
              focusNode: myFocusNode,
            ),
          ),
          Transform.rotate(
            angle: 220 * math.pi / 180,
            child: IconButton(iconSize: 27,
              icon: Icon(Icons.attach_file_rounded),
              onPressed: _selectFile,
              style: ButtonStyle(),
              color: Vx.black,
            ),
          ),
          Container(
            margin: EdgeInsets.only(right: 12),
            decoration:
                BoxDecoration(color: Colors.green, shape: BoxShape.circle),
            child: IconButton(
              onPressed: () => _sendMessage(),
              icon: Icon(Icons.send, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
