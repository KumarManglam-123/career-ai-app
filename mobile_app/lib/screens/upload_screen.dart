import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import '../services/api_service.dart';
import 'parsed_resume_screen.dart';

class UploadScreen extends StatefulWidget {
  const UploadScreen({super.key});

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  File? selectedFile;
  bool loading = false;
  String error = "";

  final TextEditingController jdController = TextEditingController();

  Future<void> pickFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null && result.files.single.path != null) {
      setState(() {
        selectedFile = File(result.files.single.path!);
      });
    }
  }

  Future<void> parseResume() async {
    if (selectedFile == null) {
      setState(() => error = "Please select a resume PDF");
      return;
    }

    setState(() {
      loading = true;
      error = "";
    });

    try {
      final data = await ApiService.parseResume(
        selectedFile!,
        jdController.text,
      );

      if (!mounted) return;

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => ParsedResumeScreen(data: data),
        ),
      );
    } catch (e) {
      setState(() => error = "Failed to parse resume");
    } finally {
      setState(() => loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Upload Resume")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ElevatedButton(
              onPressed: pickFile,
              child: const Text("Pick Resume PDF"),
            ),
            if (selectedFile != null)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  "Selected: ${selectedFile!.path.split('/').last}",
                ),
              ),
            const SizedBox(height: 16),
            TextField(
              controller: jdController,
              maxLines: 4,
              decoration: const InputDecoration(
                hintText: "Paste Job Description",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: loading ? null : parseResume,
                child: loading
                    ? const CircularProgressIndicator()
                    : const Text("Parse Resume"),
              ),
            ),
            if (error.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: Text(
                  error,
                  style: const TextStyle(color: Colors.red),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
