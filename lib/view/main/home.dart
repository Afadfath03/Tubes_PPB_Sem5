import 'package:flutter/material.dart';

void main() => runApp(const PageHome());

class PageHome extends StatelessWidget {
  const PageHome({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('main_background.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
