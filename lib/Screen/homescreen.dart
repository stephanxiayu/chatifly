import 'package:chatify/Screen/login_page.dart';
import 'package:chatify/Screen/search_screen.dart';
import 'package:chatify/model/user_model.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:google_sign_in/google_sign_in.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({this.user, Key? key}) : super(key: key);
  UserModel? user;
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
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(widget.user?.uid)
            .collection('messages')
            .snapshots(),
        builder: (context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: Text('...is loading...'),
            );
          }

          return ListView.builder(
              itemCount: snapshot.data.docs.length,
              itemBuilder: (context, index) {
                var friendId = snapshot.data.docs[index].id;
                var lastMsg = snapshot.data.docs[index]['last_message'];
                return FutureBuilder(
                    future: FirebaseFirestore.instance
                        .collection('users')
                        .doc(friendId)
                        .get(),
                    builder: (context, AsyncSnapshot asyncSnapshot) {
                      if (asyncSnapshot.hasData) {
                        print(asyncSnapshot.data);
                        var friend = asyncSnapshot.data;
                        return ListTile(
                          leading: CircleAvatar(
                            child: Image.network(friend['image']),
                          ),
                          title: Text(friend['name']),
                          subtitle: Text(
                            "$lastMsg",
                            overflow: TextOverflow.clip,
                          ),
                        );
                      }
                      return const LinearProgressIndicator();
                    });
              });
        },
      ),
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
