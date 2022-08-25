import 'package:flutter/material.dart';
import 'package:ourrecipes/models/myuser.dart';
import 'package:ourrecipes/services/auth.dart';
import 'package:ourrecipes/reusableWidgets/text_widgets.dart';

class Register extends StatefulWidget {
  const Register({Key? key, required this.toggleView}) : super(key: key);

  final Function toggleView; //passed in to change stat in calling screen

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
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

  // Function when press Sign up to register button
  void executeRegisterFunction() async {
    // Does the form pass field validation checks?
    bool? valid = _formKey.currentState?.validate();
    if ((valid != null) && (valid)) {
      // Yes show show loading spinner widget
      updateLoading(true);
      // Attempt to register with Google.
      // If successful, wrapper widget will show valid user
      MyUser user = await _auth.registerWithEmailAndPassword(
          email: _emailController.text, passwd: _passwdController.text);
      // hide the loading spinner
      updateLoading(false);
      if (user.message.isNotEmpty) {
        // There was an error from Register process so show it
        setState(() {
          error = user.message;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[100],
      appBar: AppBar(
        backgroundColor: Colors.green[400],
        elevation: 0.0,
        title: const Center(child: Text('Sign Up for Our Shared Recipes')),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
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
              const SizedBox(
                height: 10.0,
              ),
              // Click this button to register and sign up for an account
              ReusableElevatedButton(
                context: context,
                buttonPrompt: 'REGISTER',
                onTap: executeRegisterFunction,
              ),
              const SizedBox(
                height: 10.0,
              ),
              reusableSignUpOption(context, false, () {
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
