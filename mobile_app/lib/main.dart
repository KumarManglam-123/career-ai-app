import 'package:flutter/material.dart';
import 'screens/upload_screen.dart';

void main() {
  runApp(const CareerAIApp());
}

class CareerAIApp extends StatelessWidget {
  const CareerAIApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Career AI',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: const UploadScreen(),
    );
  }
}
