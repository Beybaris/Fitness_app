import 'package:fitness_app/domain/client.dart';
import 'package:fitness_app/screens/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'home.dart';
class LandingPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final Client? client = Provider.of<Client?>(context);
    final bool isLoggedIn = client != null;
    return isLoggedIn ? HomePage() : AuthorizationPage();
  }
}
