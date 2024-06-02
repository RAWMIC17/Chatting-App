import 'package:flutter/material.dart';

class UserTile extends StatelessWidget {
  final String text;
  final String? lastMessage;
  final String? profileImageUrl; // Optional image URL
  final void Function()? onTap;

  const UserTile({
    Key? key,
    required this.text,
    this.lastMessage,
    this.profileImageUrl,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(elevation: 3,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          //margin: EdgeInsets.symmetric(vertical: 5, horizontal: 25),
          padding: EdgeInsets.all(9),
          child: Row(
            children: [
              // Profile image
              Container(
                height: 60.0, // Adjust height and width as needed
                width: 60.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle, // Set shape to circle
                  image: DecorationImage(
                    image: NetworkImage(profileImageUrl ??
                        'https://cdn.pixabay.com/photo/2021/07/25/08/03/account-6491185_1280.png'),
                    fit: BoxFit.cover, // Adjust image fitting as needed
                  ),
                ),
              ),
              SizedBox(width: 20),
              // Username and last message
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      text,
                      style: TextStyle(fontWeight: FontWeight.bold,fontFamily: "Poppins",fontSize: 15),
                    ),
                    if (lastMessage != null)
                      Text(
                        lastMessage!,
                        style: TextStyle(color: Colors.grey.shade600,overflow: TextOverflow.ellipsis),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
