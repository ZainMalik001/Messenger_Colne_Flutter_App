import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:messenger_clone/Screens/signIn.dart';
import 'package:messenger_clone/chat/messages.dart';
import 'package:messenger_clone/chat/new_message.dart';

class ChatScreen extends StatefulWidget {

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

  @override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Madhu Fanpage App'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout,color: Colors.white),
              onPressed: (){

                  Widget noButton = FlatButton(
                    child: Text("No"),
                    onPressed:  () {
                      Navigator.of(context).pop();
                    },
                  );
                  Widget yesButton = FlatButton(
                    child: Text("Yes"),
                    onPressed:  () {
                      FirebaseAuth.instance.signOut();
                      Navigator.push(context,MaterialPageRoute(builder:(context) => SignIn()));
                    },
                  );

                  AlertDialog alert = AlertDialog(
                    title: Text("Logout Confirmation"),
                    content: Text("Are you sure you want to logout?"),
                    actions: [
                      noButton,
                      yesButton,
                    ],
                  );

                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return alert;
                    },
                  );
              }
          ),
        ],
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(child: Messages()),
            NewMessage(),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton.extended(

        icon: Icon(Icons.logout),
        label: Text('Logout'),
        onPressed: (){
          Widget noButton = FlatButton(
            child: Text("No"),
            onPressed:  () {
              Navigator.of(context).pop();
            },
          );
          Widget yesButton = FlatButton(
            child: Text("Yes"),
            onPressed:  () {
              FirebaseAuth.instance.signOut();
              Navigator.push(context,MaterialPageRoute(builder:(context) => SignIn()));
            },
          );

          AlertDialog alert = AlertDialog(
            title: Text("Logout Confirmation"),
            content: Text("Are you sure you want to logout?"),
            actions: [
              noButton,
              yesButton,
            ],
          );

          showDialog(
            context: context,
            builder: (BuildContext context) {
              return alert;
            },
          );
        },
      ),
      floatingActionButtonLocation:FloatingActionButtonLocation.miniEndTop
    );
  }
}
