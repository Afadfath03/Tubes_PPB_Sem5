import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final CollectionReference makananCollection =
      FirebaseFirestore.instance.collection('makanan');

  // Fungsi untuk mendapatkan data makanan
  Future<List<Map<String, dynamic>>> getMakanan() async {
    QuerySnapshot snapshot = await makananCollection.get();
    return snapshot.docs.map((doc) {
      return {
        'name': doc['name'],
        'img': doc['img'].toString(),
        'bahan': List<String>.from(doc['bahan']),
        'step': List<String>.from(doc['step']),
      };
    }).toList();
  }
  final CollectionReference favouritesCollection =
      FirebaseFirestore.instance.collection('favourites');
      
  // Fungsi untuk mendapatkan data favorit
  Future<List<Map<String, dynamic>>> getFavourites() async {
    QuerySnapshot snapshot = await favouritesCollection.get();
    return snapshot.docs.map((doc) {
      return {
        'name': doc['name'],
        'img': doc['img'].toString(),
        'bahan': List<String>.from(doc['bahan']),
        'step': List<String>.from(doc['step']),
      };
    }).toList();
  }
}
