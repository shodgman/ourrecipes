import 'package:flutter/material.dart';
import 'package:ourrecipes/new/services/auth_mainform.dart';
import 'package:provider/provider.dart';

import '../widgets/widgets.dart';

import '../services/application_state.dart';
import '../services/auth_appbar.dart';
import '../services/auth_mainform.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ApplicationState>(
        builder: (context, appState, _) => Scaffold(
              appBar: AppBar(
                title: Text('Shared Recipes'),
                actions: appBarActionsList(
                    loginState: appState.loginState,
                    updateLoginState: appState.updateLoginState,
                    signOut: appState.signOut),
              ),
              body: Stack(children: [
                //  Backgroung image under everything
                Image.asset(
                  'assets/images/myrecipe1000.png',
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  fit: BoxFit.cover,
                ),
                ListView(
                  children: <Widget>[
                    AuthMainForm(
                      email: appState.email,
                      loginState: appState.loginState,
                      updateLoginState: appState.updateLoginState,
                      startLoginFlow: appState.startLoginFlow,
                      verifyEmail: appState.verifyEmail,
                      signInWithEmailAndPassword:
                          appState.signInWithEmailAndPassword,
                      cancelRegistration: appState.cancelRegistration,
                      registerAccount: appState.registerAccount,
                      signOut: appState.signOut,
                      addRecipe: appState.addRecipeToDatabase,
                    ),
                    Divider(
                      color: Colors.green,
                    )
                  ],
                ),
              ]),
            ));
  }
}

class DialogLevel extends StatelessWidget {
  const DialogLevel({
    Key? key,
    required this.loginState,
  }) : super(key: key);

  final ApplicationLoginState loginState;
  @override
  Widget build(BuildContext context) {
    switch (loginState) {
      case ApplicationLoginState.loggedInAdd:
        return Container(
          //color: Theme.of(context).backgroundColor.withOpacity(1.0),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          foregroundDecoration: BoxDecoration(
            color: Theme.of(context).backgroundColor.withOpacity(0.8),
          ),
          decoration: const BoxDecoration(
            image: DecorationImage(
                alignment: Alignment(-.2, 0),
                image: AssetImage('assets/images/myrecipe1000.png'),
                fit: BoxFit.cover),
          ),
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
          child: const Text('Logged In Add'),
        );
        break;
      default:
        return Container();
    }
  }
}
