import 'package:flutter/material.dart';
import '../services/api_service.dart';

class GitHubScreen extends StatefulWidget {
  const GitHubScreen({super.key});

  @override
  State<GitHubScreen> createState() => _GitHubScreenState();
}

class _GitHubScreenState extends State<GitHubScreen> {
  final TextEditingController _controller = TextEditingController();

  bool isLoading = false;
  String? errorMessage;
  Map<String, dynamic>? profile;

  Future<void> fetchGitHub() async {
    final username = _controller.text.trim();
    if (username.isEmpty) return;

    setState(() {
      isLoading = true;
      errorMessage = null;
      profile = null;
    });

    try {
      final data = await ApiService.fetchGitHub(username);
      setState(() {
        profile = data;
      });
    } catch (e) {
      setState(() {
        errorMessage = 'GitHub user not found';
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('GitHub Profile')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: 'GitHub Username',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: isLoading ? null : fetchGitHub,
              child: isLoading
                  ? const CircularProgressIndicator()
                  : const Text('Fetch Profile'),
            ),
            const SizedBox(height: 20),

            if (errorMessage != null)
              Text(errorMessage!,
                  style: const TextStyle(color: Colors.red)),

            if (profile != null) ...[
              Text('Name: ${profile!['name'] ?? 'N/A'}'),
              Text('Public Repos: ${profile!['public_repos']}'),
              Text('Followers: ${profile!['followers']}'),
            ],
          ],
        ),
      ),
    );
  }
}
