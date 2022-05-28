import 'package:chatify/Widget/message_textfield.dart';
import 'package:chatify/Widget/singel_message.dart';
import 'package:chatify/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  final UserModel? currentUser;

  final String? friendId;

  final String? friendname;
  final String? friendImage;

  ChatScreen(
      {Key? key,
      required this.currentUser,
      required this.friendId,
      required this.friendname,
      required this.friendImage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Row(
          children: [
            Text(
              friendname!,
              style: const TextStyle(fontSize: 15),
            )
          ],
        ),
      ),
      body: Column(children: [
        Expanded(
          child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('users')
                  .doc(currentUser?.uid)
                  .collection('messages')
                  .doc(friendId)
                  .collection('chats')
                  .orderBy('date', descending: true)
                  .snapshots(),
              builder: (context, AsyncSnapshot snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: Text("ist loading...."));
                }
                return ListView.builder(
                    itemCount: snapshot.data.docs.length,
                    reverse: true,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      bool isMe = snapshot.data.docs[index]['senderId'] ==
                          currentUser?.uid;
                      return SingleMessages(
                        isMe: isMe,
                        message: snapshot.data.docs[index]['message'],
                      );
                    });
              }),
        ),
        MessageTextField(
          currentId: currentUser?.uid,
          friendId: friendId,
        ),
      ]),
    );
  }
}
