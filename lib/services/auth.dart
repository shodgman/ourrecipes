import 'package:firebase_auth/firebase_auth.dart';
import 'package:ourrecipes/models/myuser.dart';
import 'package:ourrecipes/reusableWidgets/text_widgets.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Create User instance based on Firebase login
  MyUser _myUserFromFirebaseUser(User? fireuser) {
    // convert the Firebase User to our user class
    return MyUser(uid: (fireuser != null) ? fireuser.uid : '');
  }

  String _reportFirebaseError(Object e) {
    String result = e.toString();
    print(result);
    if (result.contains(']')) {
      return result.substring(result.indexOf('] ') + 1);
    }
    return result;
  }

  // Getter - On Auth changes stream
  Stream<MyUser> get user {
    return _auth
        .userChanges()
        // now map to a MyUser object
        //.map((User? user) => _myUserFromFirebaseUser(user));
        .map(_myUserFromFirebaseUser);
  }

  // Sign in anonymously
  Future<MyUser> loginAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      // return our user class
      return _myUserFromFirebaseUser(result.user);
    } catch (e) {
      MyUser user = MyUser(uid: '');
      user.message = _reportFirebaseError(e);
      // empty uid  when not logged in
      return user;
    }
  }

  // Sign in with email
  Future<MyUser> loginWithEmailAndPassword(
      {required String email, required String passwd}) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: passwd);
      // return our user class
      return _myUserFromFirebaseUser(result.user);
    } catch (e) {
      MyUser user = MyUser(uid: '');
      user.message = _reportFirebaseError(e);
      // empty uid  when not logged in
      return user;
    }
  }

  // Register with email and password - creates an account
  Future registerWithEmailAndPassword(
      {required String email, required String passwd}) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: passwd);
      // return our user class
      return _myUserFromFirebaseUser(result.user);
    } catch (e) {
      MyUser user = MyUser(uid: '');
      user.message = _reportFirebaseError(e);
      // empty uid  when not logged in
      return user;
    }
  }

  // Sign out
  Future logOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      _reportFirebaseError(e);
      return null;
    }
  }
}
