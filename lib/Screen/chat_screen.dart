import 'dart:ui';

import 'package:chatify/Widget/message_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
