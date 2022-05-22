import 'package:flutter/material.dart';

class MessageTextField extends StatefulWidget {
  final String? currentId;
  final String? friendId;

  MessageTextField({Key? key, this.currentId, this.friendId}) : super(key: key);

  @override
  State<MessageTextField> createState() => _MessageTextFieldState();
}

class _MessageTextFieldState extends State<MessageTextField> {
  TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: TextField(
            controller: _controller,
            decoration: InputDecoration(
              hintText: "deine Nachricht",
              border: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.white),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
