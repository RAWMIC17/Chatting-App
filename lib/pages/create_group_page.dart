import 'package:chatting_app_1/services/chat/chat_service.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CreateGroupPage extends StatefulWidget {
  @override
  _CreateGroupPageState createState() => _CreateGroupPageState();
}

class _CreateGroupPageState extends State<CreateGroupPage> {
  TextEditingController _groupNameController = TextEditingController();
  final ChatService _chatService = ChatService();
  List<String> selectedUserIds = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Create Group",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.grey,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _groupNameController,
              decoration: InputDecoration(
                labelText: "Group Name",
              ),
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              // CHANGED: Using the updated getUsersStream method
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
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: _createGroup,
              child: Text("Create Group"),
            ),
          ),
        ],
      ),
    );
  }

  void _createGroup() async {
    String groupName = _groupNameController.text.trim();
    if (groupName.isNotEmpty && selectedUserIds.isNotEmpty) {
      String currentUserId = _chatService.getCurrentUser()!.uid;
      await _chatService.createGroupChat(
          groupName, selectedUserIds, currentUserId);
      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    _groupNameController.dispose();
    super.dispose();
  }
}
