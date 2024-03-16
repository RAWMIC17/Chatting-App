import 'package:chatting_app_1/pages/callspage.dart';
import 'package:chatting_app_1/pages/chatpage.dart';
import 'package:chatting_app_1/pages/profilepage.dart';
import 'package:chatting_app_1/utils/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class BottomNavigationBarPage extends StatefulWidget {
  const BottomNavigationBarPage({super.key});

  @override
  State<BottomNavigationBarPage> createState() => _BottomNavigationBarPageState();
}

class _BottomNavigationBarPageState extends State<BottomNavigationBarPage> {

  int myindex = 1;

  List<Widget> widgetList = const [
    CallsPage(),
    ChatPage(),
     ProfilePage(),
    // Text("Calls", style: TextStyle(fontSize: 40),),
    // Text("Chats", style: TextStyle(fontSize: 40),),
    // Text("Profile", style: TextStyle(fontSize: 40),),
  ];


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          bottomNavigationBar: BottomNavigationBar(
            elevation: 50,
            selectedItemColor: Vx.black,
            unselectedItemColor: Vx.gray500,
            iconSize: 26,
            currentIndex: myindex,
            onTap: (index) {
              setState(() {
                myindex = index;
              });
            },
            items:  <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                //activeIcon: ,
                icon: Icon(
                  Icons.phone_in_talk_rounded,
                ),
                label: 'Calls',
                //backgroundColor: Colors.green
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  CupertinoIcons.chat_bubble_2_fill,
                ),
                label: 'Messages',
                //backgroundColor: Colors.yellow
              ),
            
              BottomNavigationBarItem(
                icon: GestureDetector(
                  onTap: (){
                    Navigator.pushNamed(context, MyRoutes.profilepageRoute);
                  },
                  child: Icon(
                    CupertinoIcons.person_alt,
                  ),
                ),
                label: 'Profile',
                //backgroundColor: Colors.blue,
              ),
            ],
          ),
          body: 
             IndexedStack(children: widgetList,index: myindex,),
          ),
    );
  }
}