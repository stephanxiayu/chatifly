import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Stack(children: [
        Image.asset("lib/assets/bild2.jpg",
            fit: BoxFit.cover,
            width: MediaQuery.of(context).size.width * 1,
            height: MediaQuery.of(context).size.height * 1),
        const Center(child: Text("Chat")),
      ]),
    );
  }
}
