import 'package:chatting_app_1/utils/routes.dart';
import 'package:chatting_app_1/utils/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  double turns = 0.0;
  final _formkey = GlobalKey<FormState>();
  bool changebutton = false;
  var image = Image.asset(
    "lib/images/header.png",
    height: 290,
    width: 290,
  );

  moveToHome(BuildContext context) async {
    if (_formkey.currentState!.validate()) {
      setState(() {
        changebutton = true;
      });

      await Future.delayed(Duration(seconds: 1));
      //await Navigator.pushNamed(context, MyRoutes.loginRoute);

      setState(() {
        changebutton = false;
      });
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Mycolors.creamcolor,
      body: Stack(
        children: [
          Center(
              child: Image.asset(
            "lib/images/START.png",
            fit: BoxFit.cover,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
          )),
          SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(top: 450, right: 165),
                  child: Image.asset("lib/images/image-7.png"),
                ),
                SizedBox(
                  height: 13,
                ),
                Container(
                  padding: EdgeInsets.only(right: 80),
                  child: Image.asset("lib/images/RnPSoft.png"),
                ),
                SizedBox(
                  height: 23,
                ),
                Container(
                  padding: EdgeInsets.only(left: 20),
                  child: "Endless Possibilities."
                      .text
                      .fontWeight(FontWeight.w300)
                      .xl3
                      .fontFamily("Poppins")
                      .color(Mycolors.textcolor1)
                      .make(),
                ),
                Container(
                  padding: EdgeInsets.only(right: 145),
                  child: "Infinite."
                      .text
                      .xl3
                      .fontWeight(FontWeight.w300)
                      .fontFamily("Poppins")
                      .color(Mycolors.textcolor1)
                      .make(),
                ),
              ],
            ),
          ),
          Container(
            width: 371,
            padding: EdgeInsets.only(top: 690, left: 30, right: 10),
            child: ElevatedButton(
              onPressed: () {
                // setState(() {
                //   _size = _size == 290 ? 200 : 290;
                // });
                // setState(() => turns = turns == 0 ? -1 / 4 : 0);
                showModalBottomSheet(
                    isScrollControlled: true,
                    backgroundColor: Mycolors.bottomsheetcolor,
                    showDragHandle: true,
                    enableDrag: true,
                    useSafeArea: true,
                    shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(18))),
                    elevation: 10,
                    barrierColor: Mycolors.creamcolor.withOpacity(0),
                    context: context,
                    builder: (BuildContext context) {
                      return SizedBox(
                        height: 400,
                        child: Form(
                          key: _formkey,
                          child: Container(
                            padding: EdgeInsets.only(
                                bottom:
                                    MediaQuery.of(context).viewInsets.bottom),
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(
                                        left: 20, right: 273, top: 3),
                                    height: 23,
                                    child: "Username"
                                        .text
                                        .color(Mycolors.textcolor)
                                        .fontFamily('Mulish')
                                        .xl2
                                        .make(),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 20, horizontal: 18),
                                    child: TextFormField(
                                      style: TextStyle(fontSize: 16),
                                      autofocus: true,
                                      textCapitalization:
                                          TextCapitalization.none,
                                      decoration: InputDecoration(
                                          filled: true,
                                          border: InputBorder.none,
                                          fillColor: Mycolors.textboxcolor,
                                          hintText: "Enter Username",
                                          hintStyle: TextStyle(
                                              fontWeight: FontWeight.w300)),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return "Username can't be empty";
                                        }
                                        return null;
                                      },
                                      onChanged: (value) {
                                        setState(() {});
                                      },
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(
                                        left: 20, right: 273, top: 8),
                                    height: 28,
                                    child: "Password"
                                        .text
                                        .color(Mycolors.textcolor)
                                        .fontFamily('Mulish')
                                        .xl2
                                        .make(),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 20, horizontal: 18),
                                    child: TextFormField(
                                      style: TextStyle(fontSize: 16),
                                      autofocus: true,
                                      obscureText: true,
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          fillColor: Mycolors.textboxcolor,
                                          filled: true,
                                          hintText: "Enter Password",
                                          hintStyle: TextStyle(
                                              fontWeight: FontWeight.w300)
                                          //labelText: "Password"
                                          ),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return "Password can't be empty";
                                        } else if (value.length < 8) {
                                          return "Password must be atleast 8 alphanumeric code";
                                        }
                                        return null;
                                      },
                                      onChanged: (value) {
                                        setState(() {});
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(
                                        top: 25, left: 15, right: 15),
                                    height: 80,
                                    width: 356,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        //Navigator.pop(context);
                                        moveToHome(context);
                                      },
                                      child: "Login"
                                          .text
                                          .xl2
                                          .bold
                                          .fontFamily('Poppins')
                                          .wide
                                          .color(Vx.white)
                                          .wide
                                          .make(),
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Mycolors.buttoncolor1),
                                        //fixedSize: MaterialStateProperty.all(Size(100, 70)),
                                        minimumSize:
                                            MaterialStateProperty.all<Size>(
                                                Size(100, 55)),
                                        shape: MaterialStateProperty.all<
                                            OutlinedBorder>(
                                          RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                13.0), // Adjust the radius as needed
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    });
                /*setState(() {
                    finalAngle = -495 / 360;
                    Offset(0, 0); // Set the desired rotation angle
                  });*/
                //_showBottomSheet(context);//BottomSheet;
              },
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(Mycolors.buttoncolor),
                //fixedSize: MaterialStateProperty.all(Size(100, 70)),
                minimumSize: MaterialStateProperty.all<Size>(Size(100, 55)),
                shape: MaterialStateProperty.all<OutlinedBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        13.0), // Adjust the radius as needed
                  ),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 60, right: 7),
                    child: Icon(
                      CupertinoIcons.square_arrow_right_fill,
                      color: Vx.black,
                    ),
                  ),
                  Container(padding: EdgeInsets.only(right: 5),
                    child: " Get Started"
                        .text
                        .bold
                        .wide
                        .xl2
                        .fontFamily('Poppins')
                        .color(Vx.black)
                        .make(),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
