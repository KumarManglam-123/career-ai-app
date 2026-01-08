import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
        scaffoldBackgroundColor: const Color(0xFFF8F5FF),
        textTheme: GoogleFonts.poppinsTextTheme(),
        primaryColor: const Color(0xFF6C63FF),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFF8F5FF),
          elevation: 0,
          foregroundColor: Colors.black,
        ),
      ),
      home: const UploadScreen(),
    );
  }
}
