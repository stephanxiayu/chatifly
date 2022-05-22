import 'package:chatify/Screen/login_page.dart';
import 'package:chatify/Screen/search_screen.dart';
import 'package:chatify/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text('Chatify'),
        actions: [
          IconButton(
              onPressed: () async {
                await GoogleSignIn().signOut();
                await FirebaseAuth.instance.signOut();
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const LoginPage()));
              },
              icon: const Icon(Icons.exit_to_app))
        ],
      ),
      body: Stack(children: [
        Image.asset("lib/assets/bild2.jpg",
            fit: BoxFit.cover,
            width: MediaQuery.of(context).size.width * 1,
            height: MediaQuery.of(context).size.height * 1),
        const Center(child: Text("Home")),
      ]),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => SearchScreen()));
        },
        child: const Icon(
          Icons.person_add,
          size: 30,
        ),
      ),
    );
  }
}
