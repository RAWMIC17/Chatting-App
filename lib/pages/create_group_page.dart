import 'package:chatting_app_1/services/chat/chat_service.dart';
import 'package:chatting_app_1/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:velocity_x/velocity_x.dart';

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
      backgroundColor: Vx.black,
      appBar: AppBar(
        centerTitle: true,
        title: "Create Group"
            .text
            .fontFamily("Poppins")
            .color(Mycolors.textcolorwhite)
            .make(),
        backgroundColor: Mycolors.appbarcolor,
        iconTheme: IconThemeData(color: Mycolors.textcolorwhite),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              style: TextStyle(fontFamily: "Poppins",color: Mycolors.textcolorwhite),
              controller: _groupNameController,
              decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
              //fillColor: Vx.white,
                  labelText: "Group Name",
                  labelStyle: TextStyle(fontFamily: "Poppins",fontSize: 18,),
                  hintText: "Enter a Group Name...",
                  hintStyle: TextStyle(fontFamily: "Poppins", fontSize: 14,color: Mycolors.buttongraycolor),
                  //errorText: "Group name empty"
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
                      title: Text(userName,style: TextStyle(fontFamily: "Poppins",color: Mycolors.textcolorwhite,fontSize: 17),),
                      subtitle: Text(userEmail,style: TextStyle(fontFamily: "Poppins",),),
                      trailing: Checkbox(
                        activeColor: Mycolors.purplecolor,
                        splashRadius: 20,
                        visualDensity: VisualDensity.comfortable,
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
              child: "Create Group".text.fontFamily("Poppins").color(Mycolors.textcolorwhite).size(16).make(),
              style: ButtonStyle(
                              backgroundColor: WidgetStatePropertyAll(
                                  Mycolors.purplecolor),
                                  shape:WidgetStateProperty.all<OutlinedBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          10.0), // Adjust the radius as needed
                    ),
                  ),),
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
