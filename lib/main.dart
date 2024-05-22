import 'package:chatting_app_1/pages/bottomnavigationbar.dart';
import 'package:chatting_app_1/pages/callspage.dart';
import 'package:chatting_app_1/pages/chatpage.dart';
import 'package:chatting_app_1/pages/chatshomescreen.dart';
import 'package:chatting_app_1/pages/editprofile.dart';
import 'package:chatting_app_1/pages/groups.dart';
import 'package:chatting_app_1/pages/notifications.dart';
import 'package:chatting_app_1/pages/profilepage.dart';
import 'package:chatting_app_1/pages/settingspage.dart';
import 'package:chatting_app_1/pages/skillspage.dart';
import 'package:chatting_app_1/utils/firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:chatting_app_1/pages/login.dart';
import 'package:chatting_app_1/utils/routes.dart';
import 'package:firebase_core/firebase_core.dart';



void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false, //to remove debug banner
        initialRoute: MyRoutes.settingspageRoute, //changes the default the route

        routes: {
          //"/" is show on screen first by default
          "/": (context) =>  LoginPage(),
          MyRoutes.loginRoute: (context) => LoginPage(),
          MyRoutes.notificationRoute:(context) => NotificationPage(),
          MyRoutes.chathomescreenpageRoute:(context) => ChatHomeScreenPage(),
          MyRoutes.groupsRoute:(context) => GroupPage(),
          MyRoutes.callspageRoute:(context) => CallsPage(),
          MyRoutes.profilepageRoute:(context) => ProfilePage(),
          MyRoutes.bottomnavigationbarRoute:(context) => BottomNavigationBarPage(),
          MyRoutes.editpageRoute:(context) => EditPage(),
          MyRoutes.chatpageRoute:(context) => ChatPage(),
          MyRoutes.skillspageRoute:(context) => SkillsPage(),
          MyRoutes.settingspageRoute:(context) => SettingsPage(),
        }
        );
  }
}
