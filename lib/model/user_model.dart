import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? email;
  String? name;
  String? image;
  Timestamp? date;
  String? uid;

  UserModel(
      {required this.date,
      required this.uid,
      required this.email,
      required this.name,
      required this.image});

  factory UserModel.fromJson(DocumentSnapshot snapshot) {
    return UserModel(
        date: snapshot['date'],
        uid: snapshot['uid'],
        email: snapshot['email'],
        name: snapshot['name'],
        image: snapshot['image']);
  }
}
