import 'package:flutter/material.dart';

class ParsedResumeScreen extends StatelessWidget {
  final Map<String, dynamic> data;

  const ParsedResumeScreen({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Parsed Resume")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Email: ${data['email']}"),
                    Text("Phone: ${data['phone']}"),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),
            const Text("Skills", style: TextStyle(fontSize: 18)),
            Wrap(
              spacing: 8,
              children: List.generate(
                data['skills'].length,
                (index) => Chip(label: Text(data['skills'][index])),
              ),
            ),

            const SizedBox(height: 30),
            Center(
              child: Column(
                children: [
                  Text(
                    "${data['ats_score']}%",
                    style: const TextStyle(
                        fontSize: 40, fontWeight: FontWeight.bold),
                  ),
                  const Text("ATS Score"),
                ],
              ),
            ),

            const SizedBox(height: 30),
            const Text("AI Suggestions",
                style: TextStyle(fontSize: 18)),
            ...data['suggestions']
                .map<Widget>((s) => Text("• $s"))
                .toList(),
          ],
        ),
      ),
    );
  }
}
