import 'package:chatting_app_1/utils/routes.dart';
import 'package:chatting_app_1/utils/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatCard extends StatelessWidget {
  const ChatCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
            elevation: 0,
            color: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: InkWell(
                onTap: () {
                  Navigator.pushNamed(context, MyRoutes.chatpageRoute);
                },
                child: ListTile(
                  leading: CircleAvatar(
                    foregroundImage: AssetImage("lib/images/Tony_Stark.jpg"),
                    radius: 35,
                  ),
                  title: Text(
                    'Changu Gupta',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Mycolors.textcolorblack),
                  ),
                  subtitle: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    // mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        'Check emails bro, deadline aagyi hai....😢😢',
                        style: TextStyle(color: Mycolors.captioncolor),
                      ),
                    ],
                  ),
                ))),
                Divider(
                  thickness: 1.5,
                )
      ],
    );
  }
}
