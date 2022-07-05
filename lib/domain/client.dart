import 'package:firebase_auth/firebase_auth.dart';

class Client {
  String? id;

  Client();
  Client.fromFirebase(User user) {
    id = user.uid;
  }
}