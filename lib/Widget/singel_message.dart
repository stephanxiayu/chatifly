import 'dart:ui';

import 'package:flutter/material.dart';

class SingleMessages extends StatelessWidget {
  final String? message;
  final bool isMe;

  const SingleMessages({Key? key, required this.isMe, required this.message})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        SizedBox(
          child: Text(
            message!,
            style: TextStyle(color: isMe ? Colors.white : Colors.amber),
          ),
        )
      ],
    );
  }
}
