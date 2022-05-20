import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key, required this.onItitializationComplete})
      : super(key: key);
  final VoidCallback onItitializationComplete;
  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _registerServices().then(
      (value) => widget.onItitializationComplete(),
    );
  }

  Future<void> _registerServices() async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("lib/assets/chat.png"),
                  fit: BoxFit.contain)),
          height: 200,
          width: 200,
        ),
      ),
    );
  }
}
