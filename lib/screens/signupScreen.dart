import 'package:flutter/material.dart';
import 'package:ourrecipes/screens/loginScreen.dart';
import '../reusableWidgets/image_widgets.dart';
import '../reusableWidgets/text_widgets.dart';
import 'home/homeScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_toastr/flutter_toastr.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
// Toast Message
  _ShowToast(String msg, BuildContext context, {int? duration, int? position}) {
    FlutterToastr.show(msg, context, duration: duration, position: position);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: backgroundDecoration(),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "OUR SHARED RECIPES",
                  style: TextStyle(
                    color: Colors.black45,
                    fontWeight: FontWeight.bold,
                    fontSize: 40,
                  ),
                ),
                logoImage("assets/images/veges.jpg"),
                reusableTextField(
                  "Enter Username",
                  Icons.person_outline,
                  false,
                  _usernameController,
                  (String? tic) {
                    if ((tic == null) || (tic.isEmpty)) {
                      return 'Enter your email address';
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                reusableTextField(
                  "Enter Email Address",
                  Icons.person_outline,
                  false,
                  _emailController,
                  (String? tic) {
                    if ((tic == null) || (tic.isEmpty)) {
                      return 'Enter your email address';
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                reusableTextField(
                  "Password",
                  Icons.lock_outline,
                  true,
                  _passwordController,
                  (String? tic) {
                    if ((tic == null) || (tic.isEmpty)) {
                      return 'Enter your email address';
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                // pressing SignUp will create a user and return to login screen
                reusableSignUpButton(context, false, () {
                  FirebaseAuth.instance
                      .createUserWithEmailAndPassword(
                          email: _emailController.text,
                          password: _passwordController.text)
                      .then((value) => {
                            // On success Go to home screen
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const HomeScreen()))
                          })
                      .onError((error, stackTrace) =>
                          {myShowToast(error.toString(), context)});
                  // return to login screen
                }),
                //reusableSignUpOption(context, false),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
