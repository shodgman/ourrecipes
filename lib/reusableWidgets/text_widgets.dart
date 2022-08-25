import 'package:flutter/material.dart';
import 'package:flutter_toastr/flutter_toastr.dart';

class ReusableTextEntryField extends StatelessWidget {
  final String? preTextValue;
  final IconData icon;
  final bool isPasswordType;
  final TextEditingController textController;
  final String? Function(String?)? validator;
  final bool autoFocus;

  const ReusableTextEntryField({
    Key? key,
    required this.preTextValue,
    required this.icon,
    required this.isPasswordType,
    required this.textController,
    required this.validator,
    this.autoFocus = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textController,
      validator: validator,
      obscureText: isPasswordType,
      enableSuggestions: !isPasswordType,
      autocorrect: !isPasswordType,
      autofocus: autoFocus,
      cursorColor: Colors.white,
      style: TextStyle(color: Colors.white.withOpacity(0.9)),
      decoration: InputDecoration(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.8,
        ),
        prefixIcon: Icon(
          icon,
          color: Colors.white,
        ),
        //hintText: preTextValue,
        labelText: preTextValue,
        labelStyle: TextStyle(
          color: Colors.white.withOpacity(0.9),
        ),
        filled: true,
        fillColor: Colors.black.withOpacity(0.5),
        floatingLabelBehavior: FloatingLabelBehavior.never,
        //border: OutlineInputBorder(
        //    borderRadius: BorderRadius.circular(30.0),
        //   borderSide: const BorderSide(width: 0, style: BorderStyle.none)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: const BorderSide(width: 2, color: Colors.white)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: const BorderSide(width: 2, color: Colors.green)),
      ),
      keyboardType: isPasswordType
          ? TextInputType.visiblePassword
          : TextInputType.emailAddress,
    );
  }
}

// not used
TextFormField reusableTextField(
    String text,
    IconData icon,
    bool isPasswordType,
    TextEditingController textController,
    String? Function(String?)? validator) {
  return TextFormField(
    controller: textController,
    validator: validator,
    obscureText: isPasswordType,
    enableSuggestions: !isPasswordType,
    autocorrect: !isPasswordType,
    cursorColor: Colors.white,
    style: TextStyle(color: Colors.white.withOpacity(0.9)),
    decoration: InputDecoration(
      prefixIcon: Icon(
        icon,
        color: Colors.white,
      ),
      labelText: text,
      labelStyle: TextStyle(
        color: Colors.white.withOpacity(0.9),
      ),
      filled: true,
      fillColor: Colors.black.withOpacity(0.2),
      floatingLabelBehavior: FloatingLabelBehavior.never,
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: const BorderSide(width: 0, style: BorderStyle.none)),
    ),
    keyboardType: isPasswordType
        ? TextInputType.visiblePassword
        : TextInputType.emailAddress,
  );
}

// reusable Signup Button
class ReusableElevatedButton extends StatelessWidget {
  final BuildContext context;
  final String buttonPrompt;
  final Function onTap;

  const ReusableElevatedButton({
    Key? key,
    required this.context,
    required this.buttonPrompt,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      height: 50,
      margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(90.0)),
      child: ElevatedButton(
        onPressed: () {
          onTap();
        },
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.pressed)) {
              return Colors.black26;
            }
            return Theme.of(context).primaryColorDark;
          }),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          ),
        ),
        child: Text(
          buttonPrompt,
          style: const TextStyle(
              color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ),
    );
  }
} //ReusableElevatedButton

Container reusableSignUpButton(
  BuildContext context,
  bool isLogin,
  Function onTap,
) {
  return Container(
    width: MediaQuery.of(context).size.width,
    height: 50,
    margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(90.0)),
    child: ElevatedButton(
      onPressed: () {
        onTap();
      },
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.pressed)) {
            return Colors.black26;
          }
          return Colors.white;
        }),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        ),
      ),
      child: Text(
        isLogin ? "LOG IN" : "SIGN UP",
        style: const TextStyle(
            color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 16),
      ),
    ),
  );
}

Row reusableSignUpOption(
  BuildContext context,
  bool isLoginScreen,
  Function onPress,
) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(
        isLoginScreen ? "Don't have an account? " : "Have an account? ",
        style: const TextStyle(color: Colors.black45),
      ),
      GestureDetector(
        onTap: () {
          //print("Pressed ");
          onPress();
        },
        child: Text(
          isLoginScreen ? "Sign Up" : "Log In",
          style: const TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ],
  );
}

// Toast Message
myShowToast(String msg, BuildContext context, {int? duration, int? position}) {
  FlutterToastr.show(msg, context, duration: duration, position: position);
}
