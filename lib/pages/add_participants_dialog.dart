import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:chatting_app_1/services/chat/chat_service.dart';

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
      title: Text('Add Participants'),
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
                title: Text(userName),
                subtitle: Text(userEmail),
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
                ),
              );
            },
          );
        },
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: _addParticipants,
          child: Text('Add'),
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