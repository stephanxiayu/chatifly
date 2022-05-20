import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Stack(children: [
        Image.asset(
          "lib/assets/bild.jpg",
          fit: BoxFit.cover,
        )
      ]),
    );
  }
}
