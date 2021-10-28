import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NewMessage extends StatefulWidget {

  @override
  _NewMessageState createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  String _sendMessage = '';
  final _controller = TextEditingController();
  void _writeMessage() async{
    FocusScope.of(context).unfocus();
    final user = FirebaseAuth.instance.currentUser;
    final doc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
    FirebaseFirestore.instance.collection('chat').add({
      'DateTime': Timestamp.now(),
      'text': _sendMessage,
      'UniqueId': user.uid
    });
    _controller.clear();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Post your words...',
              ),
              onChanged: (val){
                setState(() {
                  _sendMessage = val;
                });
              },
            ),
          ),
          IconButton(
            icon: Icon(Icons.send,color: Colors.blue,),
            color: Theme.of(context).primaryColor,
            onPressed: _sendMessage.trim().isEmpty ? null : _writeMessage,
          ),
        ],
      ),
    );
  }
}
