import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ourrecipes/new/services/application_state.dart';
import 'package:ourrecipes/new/services/auth_recipelist.dart';
import 'package:ourrecipes/new/widgets/widgets.dart';
import 'package:ourrecipes/new/services/auth_emailverfyform.dart';
import 'package:ourrecipes/new/services/auth_passwordverifyform.dart';
import 'package:ourrecipes/new/services/auth_registerform.dart';
import 'package:ourrecipes/new/services/auth_create_dialog.dart';
import 'package:ourrecipes/models/recipeModel.dart';
import 'package:ourrecipes/new/services/auth_adjust_filter_settings.dart';

// This widget returns the body of a scaffold i.e. the mainform
class AuthMainForm extends StatelessWidget {
  const AuthMainForm({
    Key? key,
    required this.loginState,
    required this.updateLoginState,
    required this.email,
    required this.startLoginFlow,
    required this.verifyEmail,
    required this.signInWithEmailAndPassword,
    required this.cancelRegistration,
    required this.registerAccount,
    required this.signOut,
    required this.addRecipe,
  }) : super(key: key);
//  The calling parameters in detail
  final ApplicationLoginState loginState;
  final void Function(ApplicationLoginState update) updateLoginState;
  final String? email;
  final void Function() startLoginFlow;
  final void Function(
    String email,
    void Function(Exception e) error,
  ) verifyEmail;
  final void Function(
    String email,
    String password,
    void Function(Exception e) error,
  ) signInWithEmailAndPassword;
  final void Function() cancelRegistration;
  final void Function(
    String email,
    String displayName,
    String password,
    void Function(Exception e) error,
  ) registerAccount;
  final void Function() signOut;
  final void Function(Recipe addRecipe, void Function(Exception e) error)
      addRecipe;
// End of Parameters
  @override
  Widget build(BuildContext context) {
    switch (loginState) {
      case ApplicationLoginState.loggedOut:
        return AuthMsgForm(message: 'Logged Out');
      case ApplicationLoginState.emailAddress:
        return AuthVerifyEmailForm(
            callback: (email) => verifyEmail(
                email, (e) => _showErrorDialog(context, 'Invalid email', e)));
      //return AuthVerifyEmailForm(updateLoginState: updateLoginState);
      case ApplicationLoginState.password:
        return AuthVerifyPasswordForm(
          email: email!,
          login: (email, password) {
            signInWithEmailAndPassword(email, password,
                (e) => _showErrorDialog(context, 'Failed to sign in', e));
          },
        );
      case ApplicationLoginState.register:
        //return AuthMsgForm(message: 'Register');
        return AuthRegisterForm(
          email: email,
          cancel: () {
            cancelRegistration();
          },
          registerAccount: (
            email,
            displayName,
            password,
          ) {
            registerAccount(
                email,
                displayName,
                password,
                (e) =>
                    _showErrorDialog(context, 'Failed to create account', e));
          },
        );
      case ApplicationLoginState.loggedIn:
        //return AuthMsgForm(message: 'Logged In as ${email}, ');
        // Show the recipes
        return const AuthRecipeList();

      case ApplicationLoginState.loggedInAdd:
        return CreateRecipe(addRecipe: (Recipe r) {
          addRecipe(r,
              (e) => _showErrorDialog(context, 'Failed to create Recipe', e));
        });

      case ApplicationLoginState.loggedInFilter:
        return const AdjustFilterSettings();

      default:
        return Row(
          children: const [
            Text("Internal error, this shouldn't happen..."),
          ],
        );
    }
  }
}

void _showErrorDialog(BuildContext context, String title, Exception e) {
  showDialog<void>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(
          title,
          style: const TextStyle(fontSize: 24),
        ),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text(
                '${(e as dynamic).message}',
                style: const TextStyle(fontSize: 18),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          StyledButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text(
              'OK',
              style: TextStyle(color: Colors.green),
            ),
          ),
        ],
      );
    },
  );
}

class AuthMsgForm extends StatelessWidget {
  const AuthMsgForm({
    Key? key,
    required this.message,
  }) : super(key: key);
// Parameters
  final String message;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).backgroundColor.withOpacity(0.4),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
      child: Text(
        message,
        style: TextStyle(
          color: Colors.black87,
          fontSize: 24,
        ),
      ),
    );
  }
}
