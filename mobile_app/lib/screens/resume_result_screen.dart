import 'package:flutter/material.dart';

class ResumeResultScreen extends StatelessWidget {
  final Map<String, dynamic> data;

  const ResumeResultScreen({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final parsed = data['parsed_data'] ?? {};

    final email = parsed['email'] ?? 'Not found';
    final phone = parsed['phone'] ?? 'Not found';
    final skills = List<String>.from(parsed['skills'] ?? []);
    final preview = parsed['raw_text_preview'] ?? '';

    return Scaffold(
      appBar: AppBar(title: const Text('Parsed Resume')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _card(
              title: '📧 Email',
              content: email,
            ),
            _card(
              title: '📞 Phone',
              content: phone,
            ),
            _skillsCard(skills),
            _card(
              title: '📄 Resume Text Preview',
              content: preview,
              isScrollable: true,
            ),
          ],
        ),
      ),
    );
  }

  Widget _card({
    required String title,
    required String content,
    bool isScrollable = false,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            isScrollable
                ? SizedBox(
                    height: 150,
                    child: SingleChildScrollView(
                      child: Text(content),
                    ),
                  )
                : Text(content),
          ],
        ),
      ),
    );
  }

  Widget _skillsCard(List<String> skills) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '🛠 Skills',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: skills
                  .map(
                    (skill) => Chip(
                      label: Text(skill),
                      backgroundColor: Colors.blue.shade50,
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
