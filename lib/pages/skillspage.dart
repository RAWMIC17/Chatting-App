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
  String searchText  = '';
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

  List<String> filteredItems = [];
  @override
  void initState(){
    super.initState();
    filteredItems= List.from(skills);
  }
  void _onSearchChanged(String value){
    setState(() {
      searchText=value;
      myFilterItems();
    });
  }
  void myFilterItems(){
    if(searchText.isEmpty){
      filteredItems = List.from(skills);
    }else{
      filteredItems= skills.where((skill)=> skill.toLowerCase().contains(searchText.toLowerCase())).toList();
    }
  }
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
        floatingActionButton: Container(
          height: 45,
          width: 125,
          child: FloatingActionButton.extended(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => SimpleDialog(
                  title: "Add Skill"
                      .text
                      .fontFamily("Poppins")
                      .wide
                      .color(Mycolors.textcolorwhite)
                      .make()
                      .centered(),
                  backgroundColor: Mycolors.appbarcolor,
                  //shadowColor: Colors.teal,
                  //surfaceTintColor: Colors.amber,
                  children: [SizedBox(height: 25,),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 25),
                      child: TextField(
                        cursorColor: Mycolors.textcolorblack,
                        decoration: InputDecoration(
                            fillColor: Mycolors.textcolorwhite,
                            isDense: true,
                            filled: true,
                            contentPadding: EdgeInsets.all(12),
                            hintText: "Type Skill here",
                            hintStyle: TextStyle(
                              fontFamily: "Poppins",
                            ),
                            focusedBorder:OutlineInputBorder(
                              borderSide: const BorderSide(color: Vx.purple500, width: 1.0),
                                borderRadius: BorderRadius.circular(10.0),
                              ), 
                            enabledBorder:OutlineInputBorder(
                            borderSide: const BorderSide(color: Vx.black, width: 1.0),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            ),
                        style: TextStyle(
                          //backgroundColor: Mycolors.textcolorblack,
                          fontFamily: "Poppins",
                          color: Mycolors.textcolorblack,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    SizedBox(height: 35,),
                    Container(margin: EdgeInsets.symmetric(horizontal: 25),
                      child: ElevatedButton(
                          onPressed: () {
                            //Function to add skills goes here 
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: "Skill added successfully".text.make(),
                      duration: Duration(milliseconds: 1200),
                    ));
                          },
                          style: ButtonStyle(
                              backgroundColor: WidgetStatePropertyAll(
                                  Mycolors.purplecolor),
                                  shape:WidgetStateProperty.all<OutlinedBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          10.0), // Adjust the radius as needed
                    ),
                  ),),
                          child: "Add"
                              .text
                              .color(Mycolors.textcolorwhite)
                              .fontFamily("Poppins")
                              .lg
                              .make()),
                    )
                  ],
                ),
              );
            },
            label: "Add Skill".text.lg.fontFamily("Poppins").color(Mycolors.textcolorwhite).make(),
            backgroundColor: Mycolors.purplecolor,
            //foregroundColor: Mycolors.textcolorblack,
            icon: Icon(
              CupertinoIcons.add,
              size: 20,
              color: Mycolors.textcolorwhite,
            ),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(150))),
          ),
        ),
        appBar: AppBar(
          backgroundColor: Mycolors.appbarcolor,
          foregroundColor: Vx.white,
          centerTitle: true,
          //leading: IconButton(
          // onPressed: () {
          //    Navigator.pushNamed(context, MyRoutes.profilepageRoute);
          //  },
          //  icon: Icon(CupertinoIcons.left_chevron),
          //),
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
                
                onChanged: _onSearchChanged,
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
                  hintText: "Search",
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
                          filteredItems[index],
                          style: TextStyle(
                              color: Mycolors.textcolorwhite,
                              fontFamily: "Poppins",
                              fontSize: 21),
                        ),
                      ),
                    );
                  },
                  itemCount: filteredItems.length,
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

