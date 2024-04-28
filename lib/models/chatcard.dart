import 'package:chatting_app_1/utils/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatCard extends StatelessWidget {
  const ChatCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 1,
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: InkWell(
            onTap: () {},
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
                  // Text(
                  //   "Bhubaneswar | Student",
                  //   style: TextStyle(color: Color.fromARGB(255, 22, 72, 69)),
                  // ),
                  // Text(
                  //   'Within 100 m',
                  //   style: TextStyle(
                  //       fontWeight: FontWeight.w500,
                  //       color: const Color.fromARGB(255, 10, 38, 36)),
                  // ),
                  // SizedBox(
                  //   height: 10,
                  // ),
                  // SizedBox(
                  //   height: 14,
                  //   width: 140,
                  //   child: LinearProgressIndicator(
                  //     value: 0.5,
                  //     color: Color.fromARGB(255, 63, 109, 113),
                  //     borderRadius: BorderRadius.all(Radius.circular(15)),
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: 10,
                  // ),
                  // Text(
                  //   'Coffee | Business | Friendship',
                  //   style: TextStyle(
                  //       fontWeight: FontWeight.w500,
                  //       color: const Color.fromARGB(255, 10, 38, 36)),
                  // ),
                  // SizedBox(
                  //   height: 10,
                  // ),
                  Text(
                    'Check emails bro, deadline aagyi hai....😢😢',
                    style: TextStyle(color: Mycolors.captioncolor),
                  ),
                ],
              ),
              // trailing: Container(
              //   height: MediaQuery.of(context).size.height,
              //   //color: Colors.red,
              //   child: ElevatedButton.icon(
              //     onPressed: () {},
              //     icon: Icon(Icons.add),
              //     label: Text("Invite"),
              //     style: ButtonStyle(
              //       alignment: Alignment.topRight,
              //         elevation: MaterialStatePropertyAll(0),
              //         backgroundColor:
              //             MaterialStatePropertyAll(Colors.transparent),
              //         //splashFactory: NoSplash.splashFactory
              //         foregroundColor: MaterialStatePropertyAll(
              //             Color.fromARGB(255, 10, 38, 36))),
              //   ),
              // )
            )));
  }
}
