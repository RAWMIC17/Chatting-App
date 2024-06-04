import 'dart:io';

import 'package:chatting_app_1/models/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ChatService {
  // Get instance of Firestore & Auth
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Get instance of Firebase Storage for file uploads
  final Reference _storageRef =
      FirebaseStorage.instance.ref().child('chat_files');

  // Get user stream (this will return a QuerySnapshot of newly registered users time by time)
  Stream<QuerySnapshot> getUsersStream() {
    return _firestore.collection("Users").snapshots();
  }

  // Create group chat
  Future<void> createGroupChat(
      String groupName, List<String> userIds, String creatorId) async {
    // Generate a new document reference to get the unique ID
    DocumentReference groupChatRef = _firestore.collection('groupChats').doc();

    // Get the unique ID from the document reference
    String groupId = groupChatRef.id;

    // Add the group chat document to Firestore
    await groupChatRef.set({
      'groupId': groupId, // Include the generated groupId
      'groupName': groupName,
      'userIds': userIds,
      'creatorId': creatorId,
      'createdAt': FieldValue.serverTimestamp(),
      'lastMessage': '', // Optional: Initialize with an empty string or null
    });
  }

  // Define the method to fetch group chats as a stream
  Stream<List<Map<String, dynamic>>> getGroupChatsStream() {
    return _firestore.collection('groupChats').snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
    });
  }

  // Get the current user
  User? getCurrentUser() {
    return _auth.currentUser;
  }

  // Send messages
  Future<void> sendMessage(String recieverID, String message,
      {String? fileUrl}) async {
    // Get current user info
    final String currentUserID = _auth.currentUser!.uid;
    final String currentUserEmail = _auth.currentUser!.email!;
    final Timestamp timestamp = Timestamp.now();

    // Create a new message
    Message newMessage = Message(
        senderID: currentUserID,
        senderEmail: currentUserEmail,
        recieverID: recieverID,
        message: message,
        timestamp: timestamp,
        fileUrl: fileUrl // Include the file URL if available
        );

    // Construct a chat room for the two users (sorted to ensure uniqueness)
    List<String> ids = [currentUserID, recieverID];
    ids.sort();
    String chatRoomID = ids.join("_");

    // Add new message to database
    await _firestore
        .collection("chat_rooms")
        .doc(chatRoomID)
        .collection("messages")
        .add(newMessage.toMap());
  }

  // Get messages
  Stream<QuerySnapshot> getMessages(String userID, String otherUserID) {
    // Construct a chatroom ID for the two users
    List<String> ids = [userID, otherUserID];
    ids.sort();
    String chatRoomId = ids.join("_");

    return _firestore
        .collection("chat_rooms")
        .doc(chatRoomId)
        .collection("messages")
        .orderBy("timestamp", descending: false)
        .snapshots();
  }

  // Send group messages
  Future<void> sendGroupMessage(String groupId, String message,
      {String? fileUrl}) async {
    String currentUserId = _auth.currentUser!.uid;
    await _firestore
        .collection('groupChats')
        .doc(groupId)
        .collection('messages')
        .add({
      'message': message,
      'senderID': currentUserId,
      'timestamp': FieldValue.serverTimestamp(),
      'fileUrl': fileUrl // Include the file URL if available
    });
  }

  // Get group messages
  Stream<QuerySnapshot> getGroupMessages(String groupId) {
    return _firestore
        .collection('groupChats')
        .doc(groupId)
        .collection('messages')
        .orderBy('timestamp')
        .snapshots();
  }

  // Get group chats
  Stream<QuerySnapshot> getGroupChats() {
    return _firestore.collection('groupChats').snapshots();
  }

  // Upload a file and return the file URL
  Future<String> uploadFile(File file) async {
    try {
      TaskSnapshot task = await _storageRef.child(file.path).putFile(file);
      return await task.ref.getDownloadURL();
    } catch (e) {
      print('Error uploading file: $e');
      return '';
    }
  }

  // Method to get username based on user ID
  Future<String?> getUsername(String userId) async {
    try {
      DocumentSnapshot userSnapshot =
          await _firestore.collection('Users').doc(userId).get();
      if (userSnapshot.exists) {
        Map<String, dynamic>? userData = userSnapshot.data()
            as Map<String, dynamic>?; // Cast the data to Map<String, dynamic>
        return userData?['username'];
      } else {
        return null;
      }
    } catch (e) {
      print("Error getting username: $e");
      return null;
    }
  }
  Future<void> addParticipantsToGroup(
      String groupId, List<String> userIds) async {
    DocumentReference groupChatRef =
        _firestore.collection('groupChats').doc(groupId);

    await groupChatRef.update({
      'userIds': FieldValue.arrayUnion(userIds),
    });
  }
}
