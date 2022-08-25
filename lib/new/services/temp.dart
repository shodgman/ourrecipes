import 'package:flutter/material.dart';
import 'package:ourrecipes/reusableWidgets/text_widgets.dart';
import 'package:ourrecipes/reusableWidgets/loading_spinner.dart';
import 'package:ourrecipes/new/widgets/widgets.dart';

class AuthRegisterForm extends StatefulWidget {
  const AuthRegisterForm({
    required this.registerAccount,
    required this.cancel,
    required this.email,
    super.key,
  });
  final String email;
  final void Function(String email, String displayName, String password)
      registerAccount;
  final void Function() cancel;

  @override
  State<AuthRegisterForm> createState() => _AuthRegisterFormState();
}

class _AuthRegisterFormState extends State<AuthRegisterForm> {
  bool loading = false;
  final _formKey = GlobalKey<FormState>(debugLabel: '_RegisterFormState');
  final TextEditingController _passwdController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _passwdController.dispose();
    _emailController.dispose();
    _nameController.dispose();
  }

  void updateLoading(bool newVal) {
    setState(() {
      loading = newVal;
    });
  }

  void executeLoginFunction() async {
    bool? valid = _formKey.currentState?.validate();
    if ((valid != null) && (valid)) {
      widget.registerAccount(
        _emailController.text,
        _nameController.text,
        _passwdController.text,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green.shade200,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Header('Register with your Name and Email Address'),
            const SizedBox(
              height: 20.0,
            ),
            ReusableTextEntryField(
              preTextValue: 'First & last name',
              icon: Icons.person_outline,
              isPasswordType: false,
              textController: _nameController,
              validator: validateName,
            ),
            const SizedBox(
              height: 20.0,
            ),
            ReusableTextEntryField(
              preTextValue: 'Enter your Email Address',
              icon: Icons.email_outlined,
              isPasswordType: false,
              textController: _emailController,
              validator: validateEmail,
            ),
            const SizedBox(
              height: 20.0,
            ),
            ReusableTextEntryField(
              preTextValue: 'Password',
              icon: Icons.password_outlined,
              isPasswordType: true,
              textController: _passwdController,
              validator: validatePassword,
            ),
            const SizedBox(
              height: 20.0,
            ),
            ReusableElevatedButton(
              context: context,
              buttonPrompt: 'LOGIN',
              onTap: executeLoginFunction,
            ),
            const SizedBox(
              height: 10.0,
            ),
            StyledButton(child: Text('CANCEL'), onPressed: widget.cancel)
          ],
        ),
      ),
    );
  }
}

String? validateName(String? tic) {
  if ((tic == null) || (tic.isEmpty)) {
    return 'Please enter a user name';
  } else {
    return null;
  }
}

String? validateEmail(String? tic) {
  if ((tic == null) || (tic.isEmpty)) {
    return 'Please enter your email address';
  } else {
    return null;
  }
}

String? validatePassword(String? tic) {
  if ((tic != null) && (tic.length < 6)) {
    return 'Password must contain at least 6 characters';
  } else {
    return null;
  }
}
