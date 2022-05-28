import 'package:flutter/material.dart';

class SingleMessages extends StatelessWidget {
  final String? message;
  final bool isMe;

  const SingleMessages({
    Key? key,
    required this.isMe,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
          constraints: const BoxConstraints(maxWidth: 200),
          padding: const EdgeInsets.all(16),
          margin: const EdgeInsets.all(16),
          child: Text(
            message!,
            style: TextStyle(color: isMe ? Colors.black : Colors.amber),
          ),
        )
      ],
    );
  }
}
