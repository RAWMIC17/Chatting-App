import 'package:chatting_app_1/utils/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:velocity_x/velocity_x.dart';

class Callcard extends StatelessWidget {
  const Callcard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          elevation: 0,
          color: Vx.white,
          child: ListTile( 
            leading: CircleAvatar(
              foregroundImage: AssetImage("lib/images/Tony_Stark.jpg"),
              radius: 35,
            ),
            title: Text(
              'Changu Gupta',
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: const Color.fromARGB(255, 10, 38, 36)),
            ),
            subtitle: Row(
              //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2.0),
                  child: Icon(
                    CupertinoIcons.phone_fill_arrow_up_right,
                    color: Vx.green500,
                    size: 16,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2.0),
                  child: Icon(
                    CupertinoIcons.phone_fill_arrow_down_left,
                    color: Vx.yellow600,
                    size: 16,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2.0),
                  child: Icon(
                    Icons.phone_missed_rounded,
                    color: Vx.red500,
                    size: 16,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(child: "15 mins Ago".text.color(Mycolors.textcolorblack).make())
              ],
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      //Navigator.pushNamed(context, MyRoutes.profilepageRoute);
                    },
                    child: Icon(
                      CupertinoIcons.phone_fill,
                  color: Vx.green500,
                  size: 27,
                    ),
                  ),
                SizedBox(
                  width: 12,
                ),
                GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      //Navigator.pushNamed(context, MyRoutes.profilepageRoute);
                    },
                    child: Icon(
                      Icons.message,
                  color: Vx.blue500,
                  size: 27,
                    ),
                  )
              ],
            ),
          ),
        ),
        Divider(
                  thickness: 1.5,
                )
      ],
    );
  }
}
