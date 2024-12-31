import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final CollectionReference makananCollection = FirebaseFirestore.instance.collection('makanan');
}