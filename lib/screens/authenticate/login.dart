import 'package:flutter/material.dart';
import 'package:ourrecipes/models/myuser.dart';
import 'package:ourrecipes/reusableWidgets/loading_spinner.dart';
import 'package:ourrecipes/reusableWidgets/text_widgets.dart';
import 'package:ourrecipes/services/auth.dart';

class Login extends StatefulWidget {
  const Login({Key? key, required this.toggleView}) : super(key: key);

  final Function toggleView; //passed in to change stat in calling screen
  //const Login({required this.toggleView});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final AuthService _auth = AuthService();

  // text field state
  String email = '';
  String password = '';
  String error = '';
  bool loading = false;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwdController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _emailController.dispose();
    _passwdController.dispose();
    super.dispose();
  }

  // Function to update the loading field
  void updateLoading(bool newVal) {
    setState(() {
      loading = newVal;
    });
  }

  // Function when press Login button
  void executeLoginFunction() async {
    bool? valid = _formKey.currentState?.validate();
    //print('Valid = ${valid}');
    if ((valid != null) && (valid)) {
      updateLoading(true);
      //setState(() {
      //  loading = true;
      // });
      MyUser user = await _auth.loginWithEmailAndPassword(
          email: _emailController.text, passwd: _passwdController.text);
      updateLoading(false);
      if (user.message.isNotEmpty) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(user.message)));
        //myShowToast(user.message, context, duration: 2);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? const LoadingSpinner()
        : Scaffold(
            backgroundColor: Colors.green[100],
            appBar: AppBar(
              backgroundColor: Colors.green[400],
              elevation: 0.0,
              title: const Center(child: Text('Login to Our Shared Recipes')),
              actions: [
                TextButton.icon(
                  icon: const Icon(
                    Icons.help,
                  ), // Your icon here
                  label: const Text('Register'), // Your text here
                  onPressed: () {},
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.person,
                  ),
                ),
              ],
            ),
            body: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              padding:
                  const EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20.0,
                    ),
                    ReusableTextEntryField(
                      preTextValue: 'Email',
                      icon: Icons.email_outlined,
                      isPasswordType: false,
                      textController: _emailController,
                      validator: validator_Email,
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    ReusableTextEntryField(
                      preTextValue: 'Password',
                      icon: Icons.lock_outline,
                      isPasswordType: true,
                      textController: _passwdController,
                      validator: validator_Password,
                    ),
                    ReusableElevatedButton(
                      context: context,
                      buttonPrompt: 'LOGIN',
                      onTap: executeLoginFunction,
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    reusableSignUpOption(context, true, () {
                      widget.toggleView();
                    }),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      error,
                      style: TextStyle(color: Colors.red, fontSize: 16.0),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}

String? validator_Password(String? tic) {
  //print('In password validator');
  if ((tic == null) || (tic.length < 6)) {
    //print('Passwd is ${tic}');
    return 'Password must be 6 chars or more';
  } else {
    return null;
  }
}

String? validator_Email(String? tic) {
  //print('email is ${tic}');
  if ((tic == null) || (tic.isEmpty)) {
    return 'Please enter your email address';
  } else {
    return null;
  }
}
