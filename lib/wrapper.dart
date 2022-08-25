import 'package:flutter/material.dart';
import 'package:ourrecipes/models/myuser.dart';
import 'package:ourrecipes/screens/home/homeScreen.dart';
import 'package:provider/provider.dart';
import 'screens/authenticate/authenticate.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MyUser currUser = Provider.of<MyUser>(context);
    //print('uid = ${currUser.uid}');

    if (currUser.uid == '') {
      // No user so show authenticate widget
      return const Authenticate();
    } else {
      // show the home screen for validated users
      return const HomeScreen();
    }
  }
}
