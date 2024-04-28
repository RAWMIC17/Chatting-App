import 'package:chatting_app_1/utils/routes.dart';
import 'package:chatting_app_1/utils/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:velocity_x/velocity_x.dart';

class SkillsPage extends StatefulWidget {
  const SkillsPage({super.key});

  @override
  State<SkillsPage> createState() => _SkillsPageState();
}

class _SkillsPageState extends State<SkillsPage> {
  List<String> skills = [
    "Java",
    "HTML5",
    "CSS",
    "Python",
    "C",
    "C++",
    "AutoCAD",
    "Data Analysis",
    "Flutter",
    "Adobe Photoshop",
    "JavaScript",
    "Swift",
    "Illustrator"
  ];

  // List<String> _foundToDo = [];
  // final _skillController = TextEditingController();

  // void initState() {
  //   _foundToDo = skills;
  //   super.initState();
  // }

  // void _runfilter(String enteredkeyword) {
  //   List<String> results = [];
  //   if (enteredkeyword.isEmpty) {
  //     results = skills;
  //   } else {
  //     results = skills
  //         .where((item) => item.todoText!
  //             .toLowerCase()
  //             .contains(enteredkeyword.toLowerCase()))
  //         .toList();
  //   }

  //   setState(() {
  //     _foundToDo = results;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Vx.black,
        appBar: AppBar(
          backgroundColor: Mycolors.appbarcolor,
          foregroundColor: Vx.white,
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              Navigator.pushNamed(context, MyRoutes.profilepageRoute);
            },
            icon: Icon(CupertinoIcons.left_chevron),
          ),
          title: Container(
              child: "Skills"
                  .text
                  .fontWeight(FontWeight.w300)
                  .fontFamily("Poppins")
                  .make()),
        ),
        body: Column(
          children: [
            Container(
              height: 44,
              margin: EdgeInsets.all(25),
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.only(left: 15),
              decoration: BoxDecoration(
                color: Vx.gray500,
                borderRadius: BorderRadius.circular(30),
              ),
              child: TextField(
                cursorColor: Vx.white,
                //onChanged: (value) => runfilter(value),
                decoration: InputDecoration(
                  //         border: OutlineInputBorder(
                  // borderRadius: BorderRadius.circular(20),
                  //     ),
                  enabledBorder: OutlineInputBorder(
                      //gapPadding: 20,
                      borderSide: const BorderSide(
                        color: Colors.transparent,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(40)),
                  focusedBorder: OutlineInputBorder(
                      //gapPadding: 20,
      
                      borderSide: const BorderSide(
                        color: Colors.transparent,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(40)),
                  //isDense: true,
                  //isCollapsed: true,
                  //contentPadding: EdgeInsets.all(2),
                  prefixIcon: Container(
                    margin: EdgeInsets.only(bottom: 2),
                    padding: const EdgeInsets.only(right: 20),
                    child: Icon(
                      Icons.search,
                      color: Mycolors.textcolorwhite,
                      weight: 10,
                      size: 22,
                    ),
                  ),
                  // prefixIconConstraints:
                  //     BoxConstraints(minHeight: 20, maxWidth: 25),
                  hintText: "Search and Add Skills",
                  hintStyle: TextStyle(
                      color: Mycolors.textcolorwhite,
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.w400,
                      height: 1),
                ),
              ),
            ),
            Expanded(
              child: Container(
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(color: Vx.white, width: 0.2))),
                      child: ListTile(
                        title: Text(
                          skills[index],
                          style: TextStyle(
                              color: Mycolors.textcolorwhite,
                              fontFamily: "Poppins",
                              fontSize: 21),
                        ),
                      ),
                    );
                  },
                  itemCount: skills.length,
                  shrinkWrap: true,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
