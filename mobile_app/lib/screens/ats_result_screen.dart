import 'package:flutter/material.dart';

class AtsResultScreen extends StatelessWidget {
  final Map<String, dynamic> data;

  const AtsResultScreen({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final parsed = data['parsed_data'];
    final ats = data['ats'];

    final int score = ats['score'];
    final List matched = ats['matched_skills'];
    final List missing = ats['missing_skills'];

    return Scaffold(
      appBar: AppBar(
        title: const Text('ATS Result'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            // ===== SCORE =====
            Text(
              'ATS Score',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 10),

            LinearProgressIndicator(
              value: score / 100,
              minHeight: 14,
              backgroundColor: Colors.grey.shade300,
              color: score >= 70 ? Colors.green : Colors.orange,
            ),

            const SizedBox(height: 8),
            Text(
              '$score / 100',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 30),

            // ===== MATCHED SKILLS =====
            Text(
              'Matched Skills',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 10),

            Wrap(
              spacing: 8,
              children: matched
                  .map<Widget>(
                    (s) => Chip(
                      label: Text(s),
                      backgroundColor: Colors.green.shade100,
                    ),
                  )
                  .toList(),
            ),

            const SizedBox(height: 30),

            // ===== MISSING SKILLS =====
            Text(
              'Missing Skills',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 10),

            Wrap(
              spacing: 8,
              children: missing
                  .map<Widget>(
                    (s) => Chip(
                      label: Text(s),
                      backgroundColor: Colors.red.shade100,
                    ),
                  )
                  .toList(),
            ),

            const SizedBox(height: 30),

            // ===== RAW DATA (OPTIONAL) =====
            Text(
              'Detected Email: ${parsed['email'] ?? "N/A"}',
            ),
            Text(
              'Detected Phone: ${parsed['phone'] ?? "N/A"}',
            ),
          ],
        ),
      ),
    );
  }
}
