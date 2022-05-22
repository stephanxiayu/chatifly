import 'package:chatify/Screen/chat_screen.dart';
import 'package:chatify/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  User? user;
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchController = TextEditingController();
  List<Map> searchResult = [];
  bool isLoading = false;

  void onSearch() async {
    setState(() {
      searchResult = [];
      isLoading = true;
    });
    await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: searchController.text)
        .get()
        .then((value) => {
              if (value.docs.isEmpty)
                {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Niemanden gefunden'))),
                  setState(() {
                    isLoading = false;
                  }),
                },
              value.docs.forEach((user) {
                if (user.data()['email'] != widget.user?.email) {
                  searchResult.add(user.data());
                }
              }),
              setState(() {
                isLoading = false;
              })
            });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Stack(
        children: [
          Image.asset("lib/assets/bild2.jpg",
              fit: BoxFit.cover,
              width: MediaQuery.of(context).size.width * 1,
              height: MediaQuery.of(context).size.height * 1),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: searchController,
                    decoration: InputDecoration(
                        hintText: "schreibe den Namen",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10))),
                  ),
                ),
              ),
              IconButton(
                  onPressed: () {
                    onSearch();
                  },
                  icon: Icon(Icons.search))
            ],
          ),
          if (searchResult.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 50),
              child: Expanded(
                  child: ListView.builder(
                      itemCount: searchResult.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return ListTile(
                          subtitle: Text(searchResult[index]['email']),
                          title: Text(searchResult[index]['name']),
                          leading: CircleAvatar(
                            child: Image.network(searchResult[index]['image']),
                          ),
                          trailing: IconButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ChatScreen(
                                            currentUser: widget.user,
                                            friendId: searchResult[index]
                                                ['uid'],
                                            friendname: searchResult[index]
                                                ['name'],
                                            friendImage: searchResult[index]
                                                ['image'])));
                              },
                              icon: Icon(Icons.message)),
                        );
                      })),
            )
          else if (isLoading == true)
            const Center(child: CircularProgressIndicator())
        ],
      ),
    );
  }
}
