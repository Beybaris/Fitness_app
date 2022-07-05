import 'package:firebase_core/firebase_core.dart';
import 'package:fitness_app/screens/landing.dart';
import 'package:fitness_app/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'domain/client.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaxFitApp());
}

class MaxFitApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return StreamProvider<Client?>.value(
      value: AuthService().currentUser,
      initialData: Client(),
      child: MaterialApp(
        title: "Max Fitness",
        theme: ThemeData(
          primaryColor: Color.fromRGBO(50, 65, 85, 1),
          textTheme: TextTheme(titleLarge: TextStyle(color: Colors.white)),
        ),
        home: LandingPage(),
      ),
    );
  }

}
