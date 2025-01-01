import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Map<String, dynamic>? userData;

  // register
  Future<User?> registerAccount(
      String email, String password, String fullName) async {
    try {
      UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = userCredential.user;

      if (user != null) {
        String nickname = _firstName(fullName);
        await _firestore.collection('users').doc(user.uid).set({
          'fullName': fullName,
          'email': email,
          'nickname': nickname,
        });
      }

      return user;
    } catch (e) {
      throw Exception("Gagal register: $e");
    }
  }

  // login
  Future<User?> logInAccount(String email, String password) async {
    try {
      UserCredential userCredential =
          await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = userCredential.user;

      if (user != null) {
        DocumentSnapshot userDoc =
            await _firestore.collection('users').doc(user.uid).get();
        if (userDoc.exists) {
          userData = userDoc.data() as Map<String, dynamic>?;
          print(userData);
        } else {
          await _firebaseAuth.signOut();
          throw Exception("user tidak ditemukan");
        }
      }
      return user;
    } catch (e) {
      throw Exception("user tidak ditemukan");
    }
  }

  // sign out
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  String _firstName(String fullName) => fullName.split(' ')[0];
}
