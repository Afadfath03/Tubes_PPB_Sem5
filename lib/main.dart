import 'package:flutter/material.dart';
import 'package:tubes_ppb_sem5/view/main/user/login.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: PageLogin()
    );
  }
}
