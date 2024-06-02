import 'package:chatting_app_1/utils/routes.dart';
import 'package:chatting_app_1/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/cupertino.dart';

class ReviewsPage extends StatefulWidget {
  const ReviewsPage({super.key});

  @override
  State<ReviewsPage> createState() => _ReviewsPageState();
}

class _ReviewsPageState extends State<ReviewsPage> {
  final String loremText =
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit. "
      "Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, "
      "quis nostrud exercitation ullamco";
  final String reviewedBy = "- Reviewed by RnPsoft";
  final String date = "dd/mm/yyyy"; // Replace with actual date

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Vx.black,
        appBar: AppBar(
          backgroundColor: Mycolors.appbarcolor,
          foregroundColor: Vx.white,
          centerTitle: true,
          //leading: IconButton(
          //  onPressed: () {
          //    Navigator.pushNamed(context, MyRoutes.profilepageRoute);
          //  },
          //  icon: Icon(CupertinoIcons.left_chevron),
         // ),
          title: "Reviews"
              .text
              .fontWeight(FontWeight.w300)
              .fontFamily("Poppins")
              .make(),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const CircleAvatar(
                      backgroundColor: Vx.white,
                      radius: 40,
                      backgroundImage: AssetImage(
                        "lib/images/Tony_Stark.jpg",
                      ),
                    ),
                    SizedBox(width: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        "UserName"
                            .text
                            .xl3
                            .fontWeight(FontWeight.bold)
                            .fontFamily("Poppins")
                            .color(Mycolors.textcolorwhite)
                            .make(),
                        "name@email.com"
                            .text
                            .lg
                            // .caption(context)
                            .fontWeight(FontWeight.w300)
                            .color(Vx.gray400)
                            .make(),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 20),
                loremText.text
                    .color(Mycolors.textcolorwhite)
                    .fontFamily("Poppins")
                    .make(),
                SizedBox(height: 35),
                "$reviewedBy\n"
                    .text
                    .color(Mycolors.textcolorwhite)
                    .fontFamily("Poppins")
                    .make(),
                date.text
                    .color(Vx.gray400) // Light color for the date
                    .make(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
