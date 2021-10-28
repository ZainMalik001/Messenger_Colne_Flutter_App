import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:messenger_clone/helper/sharedPreferenceHelper.dart';

class DatabaseMethods{
  Future addUserToDB(String userId, Map<String,dynamic> userInfo) async{
    return await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .set(userInfo);
  }
  Future<Stream<QuerySnapshot>> getUserBySearch(String username) async{
    return FirebaseFirestore.instance
        .collection('users')
        .where('username',isEqualTo: username)
        .snapshots();
  }

  Future addUserWithEmailAndPassword(String uid, Map<String,dynamic> userInfo) async{
    return await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .set(userInfo);
  }


  writeMessage(String chatRoomId, String messageId, Map userInfo) async{
    return FirebaseFirestore.instance
        .collection('chatrooms')
        .doc(chatRoomId)
        .collection('chats')
        .doc(messageId)
        .set(userInfo);
  }

  updateLastSent(String chatRoomId,Map lastSentInfo) async{
    return FirebaseFirestore.instance
        .collection('chatrooms')
        .doc(chatRoomId)
        .update(lastSentInfo);
  }

  createChatRooms(String chatRoomId, Map chatRoomInfo) async{
    var snapShot = await FirebaseFirestore.instance
        .collection('chatrooms')
        .doc(chatRoomId)
        .get();
    if(snapShot.exists){
      return true;
    } else{
      return await FirebaseFirestore.instance
          .collection('chatrooms')
          .doc(chatRoomId)
          .set(chatRoomInfo);
    }
  }
  
  Future<Stream<QuerySnapshot>> getUserMessagesFromChatRooms(String chatRoomId) async{
    return FirebaseFirestore.instance
        .collection('chatrooms')
        .doc(chatRoomId)
        .collection('chats')
        .orderBy('ts',descending: true)
        .snapshots();
  }

  Future<Stream<QuerySnapshot>> getChatRooms() async{
    String myUserName = await SharedPreferenceHelper().getUserName();
    return FirebaseFirestore.instance
        .collection('chatrooms')
        .orderBy('lastMessageSend',descending: true)
        .where('users',arrayContains: myUserName)
        .snapshots();
  }
  
   Future<QuerySnapshot> getRequireduser(String userName) async{
    return await FirebaseFirestore.instance
        .collection('users')
        .where('username',isEqualTo: userName)
        .get();
  }
  

}









