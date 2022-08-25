import 'package:flutter/material.dart';
import 'package:ourrecipes/screens/authenticate/login.dart';
import 'package:ourrecipes/screens/authenticate/register.dart';

class Authenticate extends StatefulWidget {
  const Authenticate({Key? key}) : super(key: key);

  @override
  State<Authenticate> createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showLogin = true;

  void toggleShowLogin() {
    setState(() {
      showLogin = !showLogin;
      //print('showLogin now = ${showLogin}');
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLogin == true) {
      return Login(toggleView: toggleShowLogin);
    } else {
      return Register(toggleView: toggleShowLogin);
    }
  }
}
