import 'package:flutter/material.dart';
import 'package:ourrecipes/new/services/application_state.dart';
import 'package:ourrecipes/new/services/auth_create_dialog.dart';

// This function returns a list of "ActionWidgets" (buttons)
// that are destined for the end of the AppBar
List<Widget> appBarActionsList({
  required ApplicationLoginState loginState,
  required void Function(ApplicationLoginState newLoginState) updateLoginState,
  required void Function() signOut,
}) {
//  The list to be returned
  List<Widget> actionList = [];

  switch (loginState) {
    case ApplicationLoginState.loggedOut:
      {
        actionList.add(ActionButtonText(
            message: 'Login',
            updateState: updateLoginState,
            newState: ApplicationLoginState.emailAddress));
        actionList.add(ActionButtonText(
            message: 'Register',
            updateState: updateLoginState,
            newState: ApplicationLoginState.register));
        break;
      }
    case ApplicationLoginState.emailAddress:
      actionList.add(ActionButtonText(
          message: 'Register',
          updateState: updateLoginState,
          newState: ApplicationLoginState.register));
      break;
    case ApplicationLoginState.password:
      actionList.add(ActionButtonText(
          message: 'Register',
          updateState: updateLoginState,
          newState: ApplicationLoginState.register));
      break;
    case ApplicationLoginState.register:
      actionList.add(ActionButtonText(
          message: 'Login',
          updateState: updateLoginState,
          newState: ApplicationLoginState.emailAddress));
      break;
    case ApplicationLoginState.loggedIn:
      // Filter Recipes Button
      actionList.add(ActionButtonIcon(
        thisIcon: Icons.filter_alt,
        onPressed: () {
          updateLoginState(ApplicationLoginState.loggedInFilter);
        },
        toolTip: 'Filter Recipes',
      ));
      // Add Recipe Button
      actionList.add(ActionButtonIcon(
        thisIcon: Icons.add,
        onPressed: () {
          updateLoginState(ApplicationLoginState.loggedInAdd);
        },
        toolTip: 'Add Recipe',
      ));
      // Logout Button
      actionList.add(ActionButtonIcon(
        thisIcon: Icons.exit_to_app_outlined,
        onPressed: signOut,
        toolTip: 'Exit Application',
      ));

      break;
    case ApplicationLoginState.loggedInAdd:
      actionList.add(ActionButtonText(
          message: 'Cancel_Add',
          updateState: updateLoginState,
          newState: ApplicationLoginState.loggedIn));
      actionList.add(ActionButtonIcon(
        thisIcon: Icons.exit_to_app_outlined,
        onPressed: signOut,
        toolTip: 'Exit Application',
      ));
      break;
    case ApplicationLoginState.loggedInFilter:
      actionList.add(ActionButtonText(
          message: 'Cancel',
          updateState: updateLoginState,
          newState: ApplicationLoginState.loggedIn));
      actionList.add(ActionButtonIcon(
        thisIcon: Icons.exit_to_app_outlined,
        onPressed: signOut,
        toolTip: 'Exit Application',
      ));
      break;
    default:
      //actionList.add(Text(''));
      break;
  }
  return actionList;
}

// End of appBarActionList

// Definition of Exit Button
class ActionButtonIcon extends StatelessWidget {
  const ActionButtonIcon({
    Key? key,
    required this.thisIcon,
    required this.onPressed,
    required this.toolTip,
  }) : super(key: key);

  final IconData thisIcon;
  final void Function() onPressed;
  final String toolTip;
  @override
  Widget build(BuildContext context) => IconButton(
        onPressed: onPressed,
        icon: Icon(
          thisIcon,
        ),
        tooltip: toolTip,
      );
}

class ActionButtonText extends StatelessWidget {
  const ActionButtonText({
    Key? key,
    required this.message,
    required this.updateState,
    required this.newState,
  }) : super(key: key);

  final ApplicationLoginState newState;
  final void Function(ApplicationLoginState newState) updateState;
  final String message;

  @override
  Widget build(BuildContext context) => TextButton.icon(
        icon: const Icon(
          Icons.help,
        ), // Your icon here
        label: Text(
          message,
          style: TextStyle(color: Colors.black87),
        ), // Your text here
        onPressed: () {
          updateState(newState);
        },
      );
}
