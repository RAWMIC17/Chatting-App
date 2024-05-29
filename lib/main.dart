import 'package:chatting_app_1/pages/login(deleted).dart';
import 'package:chatting_app_1/services/auth/auth_gate.dart';
import 'package:chatting_app_1/utils/firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
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
    return const MaterialApp(
        debugShowCheckedModeBanner: false,
        
        home: AuthGate(),
        //to remove debug banner
        //initialRoute: MyRoutes.authGate, //changes the default the route

        routes: {
          // "/" is show on screen first by default
          //"/": (context) => LoginPage(),
          //MyRoutes.authGate: (context) => AuthGate(),
          //MyRoutes.loginOrRegister: (context) => LoginOrRegister(),
          //MyRoutes.login_pageRoute: (context) => Login_Page(),
          //MyRoutes.loginRoute: (context) => LoginPage(),
          //MyRoutes.notificationRoute: (context) => NotificationPage(),
          //MyRoutes.chathomescreenpageRoute: (context) => ChatHomeScreenPage(),
          //MyRoutes.groupsRoute: (context) => GroupPage(),
          //MyRoutes.callspageRoute: (context) => CallsPage(),
          //MyRoutes.profilepageRoute: (context) => ProfilePage(),
          //MyRoutes.bottomnavigationbarRoute: (context) =>
          //BottomNavigationBarPage(),
          //MyRoutes.editpageRoute: (context) => EditPage(),
          //MyRoutes.chatpageRoute: (context) => ChatPage(),
          //MyRoutes.skillspageRoute: (context) => SkillsPage(),
          //MyRoutes.reviewspageRoute:(context) => ReviewsPage(),
        });
  }
}
