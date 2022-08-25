import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:ourrecipes/firebase_options.dart';

import 'package:ourrecipes/new/widgets/widgets.dart';
import 'package:ourrecipes/models/recipeModel.dart';

enum ApplicationLoginState {
  loggedOut,
  emailAddress,
  register,
  password,
  loggedIn,
  loggedInAdd,
  loggedInFilter,
}

class ApplicationState extends ChangeNotifier {
  ApplicationState() {
    init();
  }

// Properties

  ApplicationLoginState _loginState = ApplicationLoginState.loggedOut;

  ApplicationLoginState get loginState => _loginState;

  // Email
  String? _email;

  String? get email => _email;

  set email(String? newValue) {
    if (newValue != null) {
      _email = newValue;
      notifyListeners();
    }
  }

  // uid
  String? _uid;

  String? get uid => _uid;

  set uid(String? newValue) {
    if (newValue != null) {
      _uid = newValue;
      notifyListeners();
    }
  }

// Methods

  Future<void> init() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    // Initialise Recipe data
    recipeDataInit();
    // Initialise Guestbook entities
    guestBookInit();
  }

  void startLoginFlow() {
    _loginState = ApplicationLoginState.emailAddress;
    notifyListeners();
  }

  // Update the application login state and notify all listeners
  void updateLoginState(
    ApplicationLoginState newLoginState,
  ) {
    _loginState = newLoginState;
    notifyListeners();
  }

  // The Authorising Methods follow

  // Takes an email parameter and verifies that this is a valid email
  // and email/password is a valid authorisation method.
  Future<void> verifyEmail(
    String email,
    void Function(FirebaseAuthException e) errorCallback,
  ) async {
    try {
      var methods =
          await FirebaseAuth.instance.fetchSignInMethodsForEmail(email);
      if (methods.contains('password')) {
        _loginState = ApplicationLoginState.password;
      } else {
        _loginState = ApplicationLoginState.register;
      }
      _email = email;
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      errorCallback(e);
    }
  }

  Future<void> signInWithEmailAndPassword(
    String emailP,
    String passwordP,
    void Function(FirebaseAuthException e) errorCallback,
  ) async {
    try {
      var credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailP,
        password: passwordP,
      );
      email = emailP;
      uid = credential.user!.uid;
    } on FirebaseAuthException catch (e) {
      errorCallback(e);
    }
  }

  void cancelRegistration() {
    _loginState = ApplicationLoginState.emailAddress;
    notifyListeners();
  }

  Future<void> registerAccount(
      String emailP,
      String displayName,
      String password,
      void Function(FirebaseAuthException e) errorCallback) async {
    try {
      var credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: emailP, password: password);
      await credential.user!.updateDisplayName(displayName);
      email = emailP;
      uid = credential.user!.uid;
    } on FirebaseAuthException catch (e) {
      errorCallback(e);
    }
  }

  void signOut() {
    FirebaseAuth.instance.signOut();
  }

  // Database methods follow

  // GuestBook

  StreamSubscription<QuerySnapshot>? _guestBookSubscription;
  List<GuestBookMessage> _guestBookMessages = [];

  List<GuestBookMessage> get guestBookMessages => _guestBookMessages;

  // GuestBook Init
  void guestBookInit() {
    FirebaseAuth.instance.userChanges().listen((user) {
      if (user != null) {
        _loginState = ApplicationLoginState.loggedIn;
        _guestBookSubscription = FirebaseFirestore.instance
            .collection('guestbook')
            .orderBy('timestamp', descending: true)
            .snapshots()
            .listen((snapshot) {
          _guestBookMessages = [];
          for (final document in snapshot.docs) {
            _guestBookMessages.add(
              GuestBookMessage(
                name: document.data()['name'] as String,
                message: document.data()['text'] as String,
              ),
            );
          }
          notifyListeners();
        });
      } else {
        _loginState = ApplicationLoginState.loggedOut;
        _guestBookMessages = [];
        _guestBookSubscription?.cancel();
      }
      notifyListeners();
    });
  }

  // Add Guest Book Message
  Future<DocumentReference?> addMessageToGuestBook(String message) async {
    DocumentReference? docId;
    if (_loginState != ApplicationLoginState.loggedIn) {
      throw Exception('Must be logged in');
    }

    docId = await FirebaseFirestore.instance
        .collection('guestbook')
        .add(<String, dynamic>{
      'text': message,
      'timestamp': DateTime.now().millisecondsSinceEpoch,
      'name': FirebaseAuth.instance.currentUser!.displayName,
      'userId': FirebaseAuth.instance.currentUser!.uid,
    });
    if (docId != null) {
      print('DocId added = ${docId}');
    }
    return docId;
  }

  // Recipe definitions
// Recipes
  StreamSubscription<QuerySnapshot>? _recipesSubscription;
  List<Recipe> _recipeList = [];

  List<Recipe> get recipeList => _recipeList;

  // Initialise Recipe Data
  void recipeDataInit() {
    FirebaseAuth.instance.userChanges().listen((user) {
      if (user != null) {
        print('Recipe Data Init - Logged In');
        _loginState = ApplicationLoginState.loggedIn;
        _recipesSubscription = FirebaseFirestore.instance
            .collection('recipes')
            .orderBy('timestamp', descending: true)
            .snapshots()
            .listen((snapshot) {
          print('There are ${snapshot.docs.length} Recipes');
          _recipeList = [];
          for (final document in snapshot.docs) {
            //Map tmp1 = document.data();
            //print(tmp1);

            _recipeList.add(
              Recipe.fromDocSnapshot(document),

              //Recipe.fromMap(tmp1),
              /*            recipeId: document.data()['id'] as String,
                recipeName: document.data()['name'] as String,
                recipeUrl: document.data()['url'] as String,
                recipeDesc: document.data()['description'] as String,
                allergyTags: document.data()['allergyTags'].cast<String>(),
                categoryTags: document.data()['categoryTags'].cast<String>(),
                ingredientTags:
                    document.data()['ingredientTags'].cast<String>(),  */
              // ),
            );
          }
          notifyListeners();
        });
      } else {
        print('Recipe Data Init - NOT Logged In');
        _loginState = ApplicationLoginState.loggedOut;
        _recipeList = [];
        _recipesSubscription?.cancel();
      }
      notifyListeners();
    });
  }

  // Add Recipe to Database
  Future<DocumentReference?> addRecipeToDatabase(
      Recipe addRecipe, void Function(Exception e) errorCallback) async {
    if (_loginState != ApplicationLoginState.loggedInAdd) {
      throw Exception('Must be logged in');
    }
    try {
      return await FirebaseFirestore.instance
          .collection('recipes')
          .add(<String, dynamic>{
        'name': addRecipe.recipeName,
        'url': addRecipe.recipeUrl,
        'description': addRecipe.recipeDesc,
        'allergyTags': addRecipe.allergyTags,
        'ingredientTags': addRecipe.ingredientTags,
        'categoryTags': addRecipe.categoryTags,
        'timestamp': DateTime.now().millisecondsSinceEpoch,
        'userId': FirebaseAuth.instance.currentUser!.uid,
      });
    } catch (e) {
      errorCallback(e as Exception);
      return null;
    }
  }
}

class GuestBookMessage {
  GuestBookMessage({required this.name, required this.message});
  final String name;
  final String message;
}

class GuestBook extends StatefulWidget {
  const GuestBook({
    required this.addMessage,
    required this.messages,
    super.key,
  });
  final FutureOr<void> Function(String message) addMessage;
  final List<GuestBookMessage> messages;

  @override
  State<GuestBook> createState() => _GuestBookState();
}

class _GuestBookState extends State<GuestBook> {
  final _formKey = GlobalKey<FormState>(debugLabel: '_GuestBookState');
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: 'Leave a message',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter your message to continue';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(width: 8),
                StyledButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      await widget.addMessage(_controller.text);
                      _controller.clear();
                    }
                  },
                  child: Row(
                    children: const [
                      Icon(Icons.send),
                      SizedBox(width: 4),
                      Text('SEND'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 8),
        for (var message in widget.messages)
          Paragraph('${message.name}: ${message.message}'),
        const SizedBox(height: 8),
      ],
    );
  }
}
