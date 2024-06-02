import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String senderID;
  final String senderEmail;
  final String recieverID;
  final String message;
  final Timestamp timestamp;
  final String? fileUrl; // Added optional fileUrl field

  Message({
    required this.senderID,
    required this.senderEmail,
    required this.recieverID,
    required this.message,
    required this.timestamp,
    this.fileUrl, // Initialize fileUrl as optional
  });

  // Convert a Message object to a map
  Map<String, dynamic> toMap() {
    return {
      "senderID": senderID,
      "senderEmail": senderEmail,
      "recieverID": recieverID,
      "message": message,
      "timestamp": timestamp,
      "fileUrl": fileUrl, // Include fileUrl in the map
    };
  }
}
