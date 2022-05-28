import 'package:chatify/Screen/homescreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GoogleSignIn googleSignIn = GoogleSignIn();
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future signInFuction() async {
    GoogleSignInAccount? googleUser = await googleSignIn.signIn();
    if (googleUser == null) {
      return;
    }
    final googleAuth = await googleUser.authentication;
    final credatial = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
    UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(credatial);

    DocumentSnapshot userExist =
        await firestore.collection('users').doc(userCredential.user?.uid).get();

    if (userExist.exists) {
      print('user already exist');
    } else {
      await firestore.collection('users').doc(userCredential.user?.uid).set({
        'email': userCredential.user?.email,
        'name': userCredential.user?.displayName,
        'image': userCredential.user?.photoURL,
        'uid': userCredential.user?.uid,
        'date': DateTime.now()
      });
    }

    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => HomeScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Image.asset("lib/assets/bild.jpg",
            fit: BoxFit.cover,
            width: MediaQuery.of(context).size.width * 1,
            height: MediaQuery.of(context).size.height * 1),
        const Center(
          child: Text(
            "Chatify",
            style: TextStyle(fontSize: 50, color: Colors.white),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: MaterialButton(
                color: Colors.transparent,
                onPressed: () async {
                  await signInFuction();
                },
                child: const Text("Google",
                    style: TextStyle(fontSize: 50, color: Colors.white))),
          ),
        )
      ]),
    );
  }
}
