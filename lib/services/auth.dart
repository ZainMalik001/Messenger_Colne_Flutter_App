import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:messenger_clone/Screens/chat_screen.dart';
import 'package:messenger_clone/Screens/signIn.dart';
import 'package:messenger_clone/helper/sharedPreferenceHelper.dart';
import 'package:messenger_clone/services/database.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthMethods{
 final FirebaseAuth _auth = FirebaseAuth.instance;

 getCurrentUser() async{
   return await _auth.currentUser;
 }

 createUserWithEmail(BuildContext context, String firstname, String lastname,String email, String password) async{
   try{
      final result = await _auth.createUserWithEmailAndPassword(email: email, password: password);

      SharedPreferenceHelper prefs = SharedPreferenceHelper();
      prefs.saveUserId(result.user.uid);
      prefs.saveUserEmail(result.user.email);
      prefs.saveUserName(result.user.email.replaceAll("@gmail.com", ""));
      prefs.saveUserDisplayName(firstname);
      prefs.saveUserDisplayName(lastname);

      Map<String,dynamic> userInfo = {
        'email': email,
        'firstname': firstname,
        'lasttname': lastname,
        'username': email.replaceAll('@gmail.com', ''),
        'registeredAt':Timestamp.now()
      };
      DatabaseMethods().addUserWithEmailAndPassword(result.user.uid, userInfo).then((value) {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ChatScreen()));
      });
   } catch(e){
     print(e);
   }
 }

 signInWithEmailAndPassword(BuildContext context, String email, String password) async{
   try{
     await _auth.signInWithEmailAndPassword(email: email, password: password).then((value) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ChatScreen()));
     });
   } catch(e){
     print(e);
   }
 }


 signInWithGoogle(BuildContext context) async{
   final FirebaseAuth auth = FirebaseAuth.instance;
   final GoogleSignIn _googleSignIn = GoogleSignIn();

   final GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
   final GoogleSignInAuthentication googleSignInAuthentication =
       await googleSignInAccount.authentication;

   final AuthCredential credential =  GoogleAuthProvider.credential(
     idToken: googleSignInAuthentication.idToken,
     accessToken: googleSignInAuthentication.accessToken
   );

   final result = await auth.signInWithCredential(credential);
   final userCredentials = result.user;


   if(result != null){
     SharedPreferenceHelper().saveUserId(userCredentials.uid);
     SharedPreferenceHelper().saveUserEmail(userCredentials.email);
     SharedPreferenceHelper().saveUserName(userCredentials.email.replaceAll("@gmail.com", ""));
     SharedPreferenceHelper().saveUserDisplayName(userCredentials.displayName);
     SharedPreferenceHelper().saveUserProfilePic(userCredentials.photoURL);

     Map<String,dynamic> userInfo = {
       'username': userCredentials.email.replaceAll("@gmail.com", ""),
       'name': userCredentials.displayName,
       'email': userCredentials.email,
       'imageUrl': userCredentials.photoURL,
     };

     DatabaseMethods().addUserToDB(userCredentials.uid, userInfo).then((value) => {
       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ChatScreen()))
     });

   }

 }

 signOut(BuildContext context) async{
   SharedPreferences prefs = await SharedPreferences.getInstance();
   prefs.clear();
   await _auth.signOut().then((value) => {
     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SignIn()))
   });
 }

}