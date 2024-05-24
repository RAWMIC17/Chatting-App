import 'package:chatting_app_1/services/auth/auth_service.dart';
import 'package:chatting_app_1/pages/callspage.dart';
import 'package:chatting_app_1/pages/chatshomescreen.dart';
import 'package:chatting_app_1/pages/profilepage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:velocity_x/velocity_x.dart';

class BottomNavigationBarPage extends StatefulWidget {
  const BottomNavigationBarPage({super.key});

  void logout() {
    final _auth = AuthService();
    _auth.signOut();
  }

  @override
  State<BottomNavigationBarPage> createState() =>
      _BottomNavigationBarPageState();
}

class _BottomNavigationBarPageState extends State<BottomNavigationBarPage> {
  int myindex = 1;

  List<Widget> widgetList = [
    CallsPage(),
    ChatHomeScreenPage(),
    //GroupPage()
    // ProfilePage(),
    // Text("Calls", style: TextStyle(fontSize: 40),),
    // Text("Chats", style: TextStyle(fontSize: 40),),
    // Text("Profile", style: TextStyle(fontSize: 40),),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        
        appBar: AppBar(
          title: Align(
            alignment: Alignment.centerRight,
            child: const Text("Logout",
                style: TextStyle(
                  color: Colors.white,
                )),
          ),
          backgroundColor: Colors.black,
          actions: [
            GestureDetector(
                onTap: widget.logout,
                child: Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: Icon(
                    Icons.logout,
                    color: Colors.white,
                  ),
                ))
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
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
          items: <BottomNavigationBarItem>[
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
            // BottomNavigationBarItem(icon: Icon(CupertinoIcons.group_solid),
            // label: "groups"),
            BottomNavigationBarItem(
              icon: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProfilePage(
                          firestore: FirebaseFirestore.instance,
                        ),
                      ));
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 36.0),
                  child: Icon(
                    CupertinoIcons.person_alt,
                  ),
                ),
              ),
              label: 'Profile',
              //backgroundColor: Colors.blue,
            ),
          ],
        ),
        body: IndexedStack(
          children: widgetList,
          index: myindex,
        ),
      ),
    );
  }
}
