import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  // collection references
  final CollectionReference categoryCollection =
      FirebaseFirestore.instance.collection('categories');
}
