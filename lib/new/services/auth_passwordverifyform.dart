import 'package:flutter/material.dart';
import 'package:ourrecipes/reusableWidgets/text_widgets.dart';
import 'package:ourrecipes/reusableWidgets/loading_spinner.dart';
import 'package:ourrecipes/new/widgets/widgets.dart';

class AuthVerifyPasswordForm extends StatefulWidget {
  const AuthVerifyPasswordForm({
    Key? key,
    required this.email,
    required this.login,
  }) : super(key: key);
// Parameters
  final String email;
  final void Function(String e, String p) login;

  @override
  State<AuthVerifyPasswordForm> createState() => _AuthVerifyPasswordFormState();
}

class _AuthVerifyPasswordFormState extends State<AuthVerifyPasswordForm> {
  bool loading = false;
  final _formKey = GlobalKey<FormState>(debugLabel: '_PasswordFormState');
  final TextEditingController _passwdController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _passwdController.dispose();
  }

  void updateLoading(bool newVal) {
    setState(() {
      loading = newVal;
    });
  }

  void executeLoginFunction() async {
    bool? valid = _formKey.currentState?.validate();
    //print('Valid = ${valid}');
    if ((valid != null) && (valid)) {
      updateLoading(true);
      widget.login(widget.email, _passwdController.text);
      updateLoading(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).backgroundColor.withOpacity(0.4),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Header('Enter password for ${widget.email}'),
            const SizedBox(
              height: 20.0,
            ),
            ReusableTextEntryField(
              preTextValue: 'Password',
              icon: Icons.password_outlined,
              isPasswordType: true,
              textController: _passwdController,
              validator: validatePassword,
              autoFocus: true,
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
          ],
        ),
      ),
    );
  }
}

String? validatePassword(String? tic) {
  if ((tic != null) && (tic.length < 6)) {
    return 'Password must contain at least 6 characters';
  } else {
    return null;
  }
}
