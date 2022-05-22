import 'dart:ui';

import 'package:chatify/Widget/message_textfield.dart';
import 'package:chatify/Widget/singel_message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ChatScreen extends StatelessWidget {
  User? currentUser;

  late final String? friendId;

  late final String? friendname;
  late final String? friendImage;

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
      body: Stack(children: [
        Image.asset("lib/assets/bild2.jpg",
            fit: BoxFit.cover,
            width: MediaQuery.of(context).size.width * 1,
            height: MediaQuery.of(context).size.height * 1),
        StreamBuilder(
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
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  physics: const ScrollPhysics(),
                  itemBuilder: (context, index) {
                    return ListTile(
                        title: Text(
                      snapshot.data.docs[index]['message'],
                    ));
                  });
            }),
        Align(
            alignment: Alignment.bottomCenter,
            child: MessageTextField(
              currentId: currentUser?.uid,
              friendId: friendId,
            ))
      ]),
    );
  }
}
