import 'package:chatting_app_1/models/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatService {
  //-- get instance of firestore & auth
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //-- get user stream (this will return a QuerySnapshot of newly registered users time by time)
  // CHANGED: Updated to return Stream<QuerySnapshot>
  Stream<QuerySnapshot> getUsersStream() {
    return _firestore.collection("Users").snapshots();
  }

  // ------------------------------CREATE GROUP CHAT-------------------------------------
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

  User? getCurrentUser() {
    return _auth.currentUser;
  }

  //-- send messages
  Future<void> sendMessage(String recieverID, message) async {
    // get current user info
    final String currentUserID = _auth.currentUser!.uid;
    final String currentUserEmail = _auth.currentUser!.email!;
    final Timestamp timestamp = Timestamp.now();

    // create a new message
    Message newMessage = Message(
        senderID: currentUserID,
        senderEmail: currentUserEmail,
        recieverID: recieverID,
        message: message,
        timestamp: timestamp);

    // construct a chat room for the two users (sorted to ensure uniqueness)
    List<String> ids = [currentUserID, recieverID];
    ids.sort();
    String chatRoomID = ids.join("_");

    // add new message to database
    await _firestore
        .collection("chat_rooms")
        .doc(chatRoomID)
        .collection("messages")
        .add(newMessage.toMap());
  }

  //-- get messages
  Stream<QuerySnapshot> getMessages(String userID, otherUserID) {
    // construct a chatroom ID for the two users
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

  //-- send group messages--------------------------------------------------------------------------------
  // ADDED: Method to send group messages
  Future<void> sendGroupMessage(String groupId, String message) async {
    String currentUserId = _auth.currentUser!.uid;
    await _firestore
        .collection('groupChats')
        .doc(groupId)
        .collection('messages')
        .add({
      'message': message,
      'senderID': currentUserId,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  //-- get group messages-----------------------------------------------------------------------------------
  // ADDED: Method to get group messages
  Stream<QuerySnapshot> getGroupMessages(String groupId) {
    return _firestore
        .collection('groupChats')
        .doc(groupId)
        .collection('messages')
        .orderBy('timestamp')
        .snapshots();
  }

  //-- get group chats---------------------------------------------------------------------------------------
  // ADDED: Method to get group chats
  Stream<QuerySnapshot> getGroupChats() {
    return _firestore.collection('groupChats').snapshots();
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
}
