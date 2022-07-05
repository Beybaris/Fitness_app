import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness_app/domain/client.dart';

class AuthService{
  final FirebaseAuth _fAuth = FirebaseAuth.instance;

  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _fAuth.signInWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      return Client.fromFirebase(user!);


    } catch(e) {
      print(e.toString());

    }
  }

  Future registerInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _fAuth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      return Client.fromFirebase(user!);


    } catch(e) {
      print(e.toString());
    }
  }

  Future logOut() async {
    await _fAuth.signOut();
  }

  Stream<Client?> get currentUser {
    return _fAuth.authStateChanges()
        .map((User? user) => user != null ? Client.fromFirebase(user) : null  );
  }
}