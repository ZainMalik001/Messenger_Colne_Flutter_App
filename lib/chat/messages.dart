import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'chat_bubble.dart';

class Messages extends StatelessWidget {

  final user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('chat').orderBy(
          'DateTime', descending: true).snapshots(),
      builder: (context, chatSnapshot) {
        if (chatSnapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        final chatDoc = chatSnapshot.data.docs;
        return ListView.builder(
          reverse: true,
          itemCount: chatDoc.length,
          itemBuilder: (context, index) {
            return ChatBubble(
              message: chatDoc[index].data()['text'],
              key: ValueKey(chatDoc[index].id),
              datetime: chatDoc[index].data()['DateTime'].toDate().toString(),
            );
          },
        );
      },
    );
  }
}

