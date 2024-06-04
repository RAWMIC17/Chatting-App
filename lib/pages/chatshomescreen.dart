import 'package:chatting_app_1/models/user_tile.dart';
import 'package:chatting_app_1/pages/chat_page.dart';
import 'package:chatting_app_1/services/auth/auth_service.dart';
import 'package:chatting_app_1/services/chat/chat_service.dart';
import 'package:chatting_app_1/utils/theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'create_group_page.dart';
import 'package:chatting_app_1/pages/group_chat_page.dart';
import 'package:flutter/cupertino.dart';

class ChatHomeScreenPage extends StatefulWidget {
  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  @override
  State<ChatHomeScreenPage> createState() => _ChatHomeScreenPageState();
}

class _ChatHomeScreenPageState extends State<ChatHomeScreenPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CreateGroupPage()),
            );
          },
          child: Icon(
            CupertinoIcons.group,
            color: Mycolors.textcolorwhite,
            size: 30,
          ),
          backgroundColor: Mycolors.purplecolor,
          shape: CircleBorder(),
        ),
        backgroundColor: Mycolors.backgroundcolor,
        body: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.only(top: 15, left: 10),
              child: "Welcome,"
                  .text
                  .xl2
                  .light
                  .color(Mycolors.textcolorwhite)
                  .fontFamily("Poppins")
                  .make(),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.only(left: 10),
              child: widget._authService
                  .getCurrentUser()
                  ?.email
                  .toString()
                  .text
                  .xl3
                  .bold
                  .color(Mycolors.textcolorwhite)
                  .fontFamily("Poppins")
                  .make(),
            ),
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.only(top: 15, bottom: 26),
              alignment: Alignment.center,
              child: "Chats"
                  .text
                  .xl5
                  .fontFamily("Poppins")
                  .fontWeight(FontWeight.w400)
                  .color(Mycolors.textcolorwhite)
                  .make(),
            ),
            SizedBox(height: 10),
            Expanded(
              child: Container(
                  padding: EdgeInsets.only(top: 8),
                  decoration: BoxDecoration(
                      color: Vx.white,
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(20))),
                  child: _buildUserList()),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUserList() {
    return StreamBuilder<QuerySnapshot>(
      stream: widget._chatService.getUsersStream(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text("Error");
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }

        var users = snapshot.data!.docs
            .map((doc) => doc.data() as Map<String, dynamic>)
            .toList();

        return StreamBuilder<List<Map<String, dynamic>>>(
          stream: widget._chatService.getGroupChatsStream(),
          builder: (context, groupChatSnapshot) {
            if (groupChatSnapshot.hasError) {
              return const Text("Error");
            }
            if (groupChatSnapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            }

            var groupChats = groupChatSnapshot.data!;

            return ListView(
              children: [
                ...users.map<Widget>(
                    (userData) => _buildUserListItem(userData, context)),
                ...groupChats.map<Widget>(
                    (groupData) => _buildGroupChatItem(groupData, context)),
              ],
            );
          },
        );
      },
    );
  }

  Widget _buildUserListItem(
      Map<String, dynamic> userData, BuildContext context) {
    if (userData["email"] != widget._authService.getCurrentUser()!.email) {
      String? username = userData["username"];
      String displayText = username ?? userData["email"];
      String? profileImageUrl = userData["profileImage"];

      return StreamBuilder(
        stream: widget._chatService.getMessages(
          userData["uid"],
          widget._authService.getCurrentUser()!.uid,
        ),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Container();
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }

          if (snapshot.data!.docs.isNotEmpty) {
            var lastMessage = snapshot.data!.docs.last;
            var messageData = lastMessage.data() as Map<String, dynamic>;

            return UserTile(
              text: displayText,
              lastMessage: messageData["message"],
              profileImageUrl: profileImageUrl,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChatPage(
                      recieverUserName: userData["username"],
                      recieverEmail: userData["email"],
                      recieverID: userData["uid"],
                    ),
                  ),
                );
              },
            );
          } else {
            return UserTile(
              text: displayText,
              profileImageUrl: profileImageUrl,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChatPage(
                      recieverUserName: userData["username"],
                      recieverEmail: userData["email"],
                      recieverID: userData["uid"],
                    ),
                  ),
                );
              },
            );
          }
        },
      );
    } else {
      return Container();
    }
  }

  Widget _buildGroupChatItem(
      Map<String, dynamic> groupData, BuildContext context) {
    String groupId = groupData["groupId"] ?? "";
    String groupName = groupData["groupName"] ?? "Unnamed Group";
    List<String> userIds = List<String>.from(groupData["userIds"] ?? []);

    if (userIds.contains(widget._authService.getCurrentUser()?.uid)) {
      return UserTile(
        text: groupName,
        lastMessage: groupData["lastMessage"] ?? "",
        onTap: () {
          if (groupId.isNotEmpty) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => GroupChatPage(
                  groupId: groupId,
                  groupName: groupName,
                ),
              ),
            );
          }
        },
      );
    } else {
      // If the current user is not part of the group, return an empty container
      return Container();
    }
  }
}