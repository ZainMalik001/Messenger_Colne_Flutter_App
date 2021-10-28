import 'dart:io';
import 'package:flutter/material.dart';
import 'package:messenger_clone/constants/common.dart';
import 'package:messenger_clone/constants/imagePicker.dart';
import 'package:messenger_clone/services/auth.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController firstname = TextEditingController();
  TextEditingController lastname = TextEditingController();
  TextEditingController userId = TextEditingController();
  File pickedImage;



  void _trySubmit() {
    if(email.text == null && password.text == null && firstname.text == null && lastname.text == null){
      Scaffold.of(context).showSnackBar(
          SnackBar(
            content: Text('Please Input al fields and pick an image'),
            backgroundColor: Theme.of(context).errorColor,
          )
      );
    } else{
      AuthMethods().createUserWithEmail(context, firstname.text, lastname.text,email.text, password.text);
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Welcome To Madhu Fanpage App'),centerTitle: true,),
      body: ListView(
        children: [
          Container(
            margin: EdgeInsets.only(
              top: MediaQuery.of(context).size.height / 8,
            ),
            padding: EdgeInsets.symmetric(horizontal: 20,vertical: 0),
            child: Column(
              children: [
                setTextField(firstname, Icons.person_rounded,'First Name'),
                setTextField(lastname, Icons.person_rounded,'Last Name'),
                setTextField(userId, Icons.supervised_user_circle_outlined,'User Id'),
                setTextField(email, Icons.email_outlined,'Enter Email'),
                setTextField(password, Icons.lock_open_outlined,'Enter Password'),
                SizedBox(height: 20),
                GestureDetector(
                  onTap: (){
                    _trySubmit();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25.0),
                      color: Colors.blue,
                    ),
                    height: 40,
                    width: 200,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Text(
                        "Sign Up",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
