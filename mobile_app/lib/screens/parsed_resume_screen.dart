import 'package:flutter/material.dart';

class ParsedResumeScreen extends StatelessWidget {
  final Map<String, dynamic> data;

  const ParsedResumeScreen({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final skills = List<String>.from(data['skills'] ?? []);
    final projects = List<String>.from(data['projects'] ?? []);
    final suggestions = List<String>.from(data['suggestions'] ?? []);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Parsed Resume"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            /// EMAIL
            _infoCard(
              icon: Icons.email,
              title: "Email",
              value: data['email'] ?? "Not found",
            ),

            /// PHONE
            _infoCard(
              icon: Icons.phone,
              title: "Phone",
              value: data['phone'] ?? "Not found",
            ),

            /// ATS SCORE
            _infoCard(
              icon: Icons.analytics,
              title: "ATS Score",
              value: "${data['ats_score'] ?? 0} / 100",
            ),

            const SizedBox(height: 20),

            /// SKILLS
            const Text(
              "Skills",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: skills
                  .map(
                    (skill) => Chip(
                      label: Text(skill),
                      backgroundColor: Colors.deepPurple.shade50,
                    ),
                  )
                  .toList(),
            ),

            /// PROJECTS SECTION (⭐ NEW ⭐)
            if (projects.isNotEmpty) ...[
              const SizedBox(height: 25),
              const Text(
                "Projects",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),

              ...projects.map(
                (project) => Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    leading: const Icon(
                      Icons.work_outline,
                      color: Colors.deepPurple,
                    ),
                    title: Text(project),
                  ),
                ),
              ),
            ],

            /// SUGGESTIONS
            if (suggestions.isNotEmpty) ...[
              const SizedBox(height: 25),
              const Text(
                "Suggestions to Improve Resume",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),

              ...suggestions.map(
                (s) => Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    children: [
                      const Icon(Icons.check_circle,
                          color: Colors.green, size: 20),
                      const SizedBox(width: 8),
                      Expanded(child: Text(s)),
                    ],
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  /// REUSABLE INFO CARD
  Widget _infoCard({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Icon(icon, color: Colors.deepPurple),
        title: Text(title),
        subtitle: Text(value),
      ),
    );
  }
}
