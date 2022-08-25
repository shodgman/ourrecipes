import 'package:flutter/material.dart';
import 'package:ourrecipes/reusableWidgets/text_widgets.dart';
import 'package:ourrecipes/reusableWidgets/loading_spinner.dart';
import 'package:ourrecipes/new/widgets/widgets.dart';

class AuthVerifyEmailForm extends StatefulWidget {
  const AuthVerifyEmailForm({
    Key? key,
    required this.callback,
  }) : super(key: key);
// Parameters
  final void Function(String email) callback;
  //final void Function(ApplicationLoginState newState) updateLoginState;

  @override
  State<AuthVerifyEmailForm> createState() => _AuthVerifyEmailFormState();
}

class _AuthVerifyEmailFormState extends State<AuthVerifyEmailForm> {
  bool loading = false;
  final _formKey = GlobalKey<FormState>(debugLabel: '_EmailFormState');
  final TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.dispose();
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
      widget.callback(_emailController.text);
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
            Header('Enter your Email Address'),
            const SizedBox(
              height: 20.0,
            ),
            ReusableTextEntryField(
              preTextValue: 'Email',
              icon: Icons.email_outlined,
              isPasswordType: false,
              textController: _emailController,
              validator: validateEmail,
              autoFocus: true,
            ),
            const SizedBox(
              height: 20.0,
            ),
            ReusableElevatedButton(
              context: context,
              buttonPrompt: 'NEXT',
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

String? validateEmail(String? tic) {
  //print('email is ${tic}');
  if ((tic == null) || (tic.isEmpty)) {
    return 'Please enter your email address';
  } else {
    return null;
  }
}
