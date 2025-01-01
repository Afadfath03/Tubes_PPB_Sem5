import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UploadPage extends StatefulWidget {
  const UploadPage({Key? key}) : super(key: key);

  @override
  _UploadPageState createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  final _titleController = TextEditingController();
  final _durationController = TextEditingController();
  final _servingController = TextEditingController();
  final _recipeController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  File? _recipeImage;

  // Fungsi untuk memilih gambar
  Future<void> _pickRecipeImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _recipeImage = File(pickedFile.path);
      });
    }
  }

  // Validasi apakah semua input sudah diisi
  bool _isFormValid() {
    return _titleController.text.isNotEmpty &&
        _durationController.text.isNotEmpty &&
        _servingController.text.isNotEmpty &&
        _recipeController.text.isNotEmpty &&
        _recipeImage != null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Add Recipe', style: TextStyle(color: Colors.orange)),
        centerTitle: true,
      ),
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          left: 16,
          right: 16,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            // Input Judul Resep
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: 'Title',
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: (_) => setState(() {}), // Update tombol save
            ),
            const SizedBox(height: 16),
            // Input Durasi dan Porsi
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _durationController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Duration',
                      hintText: 'e.g. 15 min',
                      filled: true,
                      fillColor: Colors.grey[200],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    onChanged: (_) => setState(() {}),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextField(
                    controller: _servingController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Serving',
                      hintText: 'e.g. 2 servings',
                      filled: true,
                      fillColor: Colors.grey[200],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    onChanged: (_) => setState(() {}),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Input Deskripsi Resep
            TextField(
              controller: _recipeController,
              maxLines: 5,
              decoration: InputDecoration(
                labelText: 'Recipe',
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: (_) => setState(() {}),
            ),
            const SizedBox(height: 16),
            // Upload Foto
            GestureDetector(
              onTap: _pickRecipeImage,
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.orange),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text(
                    _recipeImage == null ? 'Upload Photo' : 'Photo Selected',
                    style: const TextStyle(color: Colors.orange),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Tombol Save
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: _isFormValid()
                    ? Colors.orange
                    : Colors.grey, // Tombol aktif jika valid
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
              onPressed: _isFormValid()
                  ? () {
                      // Kirim data kembali ke profile.dart
                      Navigator.pop(context, {
                        'title': _titleController.text,
                        'duration': _durationController.text,
                        'serving': _servingController.text,
                        'recipe': _recipeController.text,
                        'image': _recipeImage,
                      });
                    }
                  : null, // Nonaktif jika form tidak valid
              child: const Text('Save'),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
