import 'package:chatting_app_1/utils/theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:chatting_app_1/services/chat/chat_service.dart';
import 'package:velocity_x/velocity_x.dart';

class AddParticipantsDialog extends StatefulWidget {
  final String groupId;

  AddParticipantsDialog({required this.groupId});

  @override
  _AddParticipantsDialogState createState() => _AddParticipantsDialogState();
}

class _AddParticipantsDialogState extends State<AddParticipantsDialog> {
  final ChatService _chatService = ChatService();
  List<String> selectedUserIds = [];

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Mycolors.backgroundcolor,
      title: "Add Participants"
          .text
          .color(Mycolors.textcolorwhite)
          .fontFamily("Poppins")
          .make()
          .centered(),
      content: StreamBuilder<QuerySnapshot>(
        stream: _chatService.getUsersStream(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text("Error loading users"));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text("No users found"));
          }
    
          var users = snapshot.data!.docs;
          return ListView.builder(
            shrinkWrap: true,
            itemCount: users.length,
            itemBuilder: (context, index) {
              var user = users[index];
              var userId = user.id;
              var userName = user['username'];
              var userEmail = user['email'];
              return ListTile(
                title: Text(
                  userName,
                  style: TextStyle(
                      fontFamily: "Poppins",
                      color: Mycolors.textcolorwhite,
                      fontSize: 16),
                ),
                subtitle: Text(
                  userEmail,
                  softWrap: false,
                  style: TextStyle(fontFamily: "Poppins", fontSize: 13),
                ),
                trailing: Checkbox(
                  value: selectedUserIds.contains(userId),
                  onChanged: (isSelected) {
                    setState(() {
                      if (isSelected!) {
                        selectedUserIds.add(userId);
                      } else {
                        selectedUserIds.remove(userId);
                      }
                    });
                  },
                  activeColor: Mycolors.purplecolor,
                ),
              );
            },
          );
        },
      ),
      actions: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: "Cancel".text.fontFamily("Poppins").color(Mycolors.purplecolor).make(),
            ),
            ElevatedButton(
          onPressed: _addParticipants,
          style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(Mycolors.purplecolor)),
          child: "Add".text.fontFamily("Poppins").color(Mycolors.textcolorwhite).make(),
        ),
          ],
        ),
      ],
    );
  }

  void _addParticipants() async {
    if (selectedUserIds.isNotEmpty) {
      await _chatService.addParticipantsToGroup(
          widget.groupId, selectedUserIds);
      Navigator.pop(context);
    }
  }
}
