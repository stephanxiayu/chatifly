import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MessageTextField extends StatefulWidget {
  final String? currentId;
  final String? friendId;

  const MessageTextField({Key? key, this.currentId, this.friendId})
      : super(key: key);

  @override
  State<MessageTextField> createState() => _MessageTextFieldState();
}

class _MessageTextFieldState extends State<MessageTextField> {
  final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: TextField(
            autocorrect: false,
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
        const SizedBox(
          width: 10,
        ),
        IconButton(
          onPressed: () async {
            String message = _controller.text;

            await FirebaseFirestore.instance
                .collection('users')
                .doc(widget.currentId)
                .collection('messages')
                .doc(widget.friendId)
                .collection('chats')
                .add({
              'senderId': widget.currentId,
              'recieverId': widget.friendId,
              'message': message,
              'data': DateTime.now(),
            }).then((value) {
              FirebaseFirestore.instance
                  .collection('users')
                  .doc(widget.currentId)
                  .collection('messages')
                  .doc(widget.friendId)
                  .set({
                'last_messages': message,
              });
            });
            await FirebaseFirestore.instance
                .collection('users')
                .doc(widget.friendId)
                .collection('messages')
                .doc(widget.currentId)
                .collection('chats')
                .add({
              'senderId': widget.currentId,
              'recieverId': widget.friendId,
              'message': message,
              'data': DateTime.now(),
            }).then((value) {
              FirebaseFirestore.instance
                  .collection('users')
                  .doc(widget.friendId)
                  .collection('messages')
                  .doc(widget.currentId)
                  .set({
                'last_message': message,
              });
            });
            _controller.clear();
          },
          icon: const Icon(Icons.send),
        )
      ],
    );
  }
}
