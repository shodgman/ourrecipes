import 'package:flutter/material.dart';
import 'package:ourrecipes/reusableWidgets/image_widgets.dart';
import 'package:ourrecipes/services/auth.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[100],
      appBar: AppBar(
        backgroundColor: Colors.green[400],
        elevation: 0.0,
        title: Text('Welcome to Our Shared Recipes'),
        actions: [
          IconButton(
            tooltip: 'Settings',
            icon: const Icon(
              Icons.settings,
            ), // Your icon here
            onPressed: () async {
              //await _auth.logOut();
            },
          ),
          SizedBox(
            width: 5,
          ),
          IconButton(
            tooltip: 'Logout',
            onPressed: () async {
              await _auth.logOut();
            },
            icon: const Icon(
              Icons.exit_to_app_outlined,
            ),
          ),
        ],
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        //decoration: backgroundDecoration(),
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: 80,
              ),
              Text(
                "Coming Soon!",
                style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 40,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
