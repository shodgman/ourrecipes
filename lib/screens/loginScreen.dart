import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ourrecipes/screens/home/homeScreen.dart';
import '../reusableWidgets/image_widgets.dart';
import '../reusableWidgets/text_widgets.dart';
import 'package:flutter_toastr/flutter_toastr.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
// Toast Message
  _ShowToast(String msg, BuildContext context, {int? duration, int? position}) {
    FlutterToastr.show(msg, context, duration: duration, position: position);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: backgroundDecoration(),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Column(
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
                  // create a login button.
                  reusableSignUpButton(context, true, () {
                    FirebaseAuth.instance
                        .signInWithEmailAndPassword(
                            email: _emailController.text,
                            password: _passwordController.text)
                        .then((value) => {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const HomeScreen()))
                            })
                        .onError((error, stackTrace) => {
                              myShowToast(error.toString(), context,
                                  duration: FlutterToastr.lengthLong,
                                  position: FlutterToastr.bottom)
                            });
                  }),
                  //reusableSignUpOption(context, true),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
