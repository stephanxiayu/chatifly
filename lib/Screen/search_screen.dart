import 'package:chatify/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchController = TextEditingController();
  List<Map> searchResult = [];
  bool isLoading = false;

  void onSearch() async {
    setState(() {
      isLoading = true;
    });
    await FirebaseFirestore.instance
        .collection('users')
        .where('name', isEqualTo: searchController.text)
        .get()
        .then((value) => {
              if (value.docs.length < 1)
                {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Niemanden gefunden'))),
                  setState(() {
                    isLoading = false;
                  }),
                },
              value.docs.forEach((user) {
                searchResult.add(user.data());
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
              IconButton(onPressed: () {}, icon: Icon(Icons.search))
            ],
          )
        ],
      ),
    );
  }
}
