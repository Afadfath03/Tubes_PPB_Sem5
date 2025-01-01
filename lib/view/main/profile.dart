import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tubes_ppb_sem5/view/main/profile/upload.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File? _profileImage;
  String? _profileImageUrl; // URL dari foto profil di Firebase
  final List<Map<String, dynamic>> _recipes = []; // Data untuk grid resep
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _fetchProfileImage(); // Ambil URL foto profil dari Firestore
  }

  Future<void> _fetchProfileImage() async {
    final userDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc('RW7xppDpyNfBdcNh5a3HxpD9yJd2') // Ganti dengan ID dokumen user Anda
        .get();

    if (userDoc.exists && userDoc.data()!['profileImageUrl'] != null) {
      setState(() {
        _profileImageUrl = userDoc.data()!['profileImageUrl'];
      });
    }
  }

  Future<void> _pickProfileImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
      await _uploadProfileImage();
    }
  }

  Future<void> _uploadProfileImage() async {
    if (_profileImage == null) return;

    try {
      final storageRef = FirebaseStorage.instance
          .ref()
          .child('profile_images/${DateTime.now().millisecondsSinceEpoch}.jpg');
      final uploadTask = await storageRef.putFile(_profileImage!);
      final imageUrl = await uploadTask.ref.getDownloadURL();

      // Simpan URL ke Firestore
      await FirebaseFirestore.instance
          .collection('users')
          .doc('RW7xppDpyNfBdcNh5a3HxpD9yJd2') // Ganti dengan ID dokumen user Anda
          .update({'profileImageUrl': imageUrl});

      setState(() {
        _profileImageUrl = imageUrl;
      });
    } catch (e) {
      print('Error uploading profile image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.orange),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
          GestureDetector(
            onTap: _pickProfileImage,
            child: CircleAvatar(
              radius: 50,
              backgroundImage: _profileImage != null
                  ? FileImage(_profileImage!)
                  : (_profileImageUrl != null
                      ? NetworkImage(_profileImageUrl!)
                      : const AssetImage('assets/images/profile.JPG'))
                      as ImageProvider,
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
            onPressed: () async {
              // Navigasi ke UploadPage dan tambahkan resep baru
              final newRecipe = await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => UploadPage()),
              );
              if (newRecipe != null) {
                setState(() {
                  _recipes.add(newRecipe);
                });
              }
            },
            child: const Text('Upload'),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: _recipes.length,
              itemBuilder: (context, index) {
                final recipe = _recipes[index];
                return ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Column(
                    children: [
                      Image.file(
                        recipe['image'],
                        fit: BoxFit.cover,
                        height: 100,
                        width: double.infinity,
                      ),
                      const SizedBox(height: 5),
                      Text(
                        recipe['title'],
                        style:
                            const TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
