import 'package:chatting_app_1/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:velocity_x/velocity_x.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final String? username;
  final bool isCurrentUser;
  final String? fileUrl;

  ChatBubble({
    required this.message,
    required this.isCurrentUser,
    this.username,
    this.fileUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        if (username != null)
          Padding(
            padding: EdgeInsets.only(left: isCurrentUser ? 0 : 10,right: isCurrentUser ? 10 : 0),
            child: Text(
              username!,
              style:
                  TextStyle(fontWeight: FontWeight.bold, fontFamily: "Poppins"),
            ),
          ),
        Container(
          //margin: EdgeInsets.symmetric(vertical: 4.0,horizontal: isCurrentUser ?20:10),
          margin: EdgeInsets.only(
              top: 4,
              bottom: 4,
              left: isCurrentUser ? 60 : 8,
              right: isCurrentUser ? 8 : 60),
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
          decoration: BoxDecoration(
            color: isCurrentUser ? Colors.blue[100] : Colors.grey[300],
            borderRadius: BorderRadius.circular(18.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                message,
                style: TextStyle(
                  color: isCurrentUser
                      ? Mycolors.textcolorblack
                      : Mycolors.textcolorblack,
                ),
              ),
              if (fileUrl != null)
                GestureDetector(
                  onTap: () => _openFile(fileUrl!),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Sent a file",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: "Poppins",
                          color: isCurrentUser ? Colors.black : Colors.black,
                        ),
                      ),
                      Text(
                        "Click to open",
                        style: TextStyle(
                          color: Vx.blue700,
                          fontFamily: "Poppins",
                          decoration: TextDecoration.underline,
                          decorationThickness: 2.5,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }

  void _openFile(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not open file: $url';
    }
  }
}
