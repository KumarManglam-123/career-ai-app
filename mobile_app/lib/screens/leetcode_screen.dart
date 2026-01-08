import 'package:flutter/material.dart';

class LeetCodeScreen extends StatefulWidget {
  const LeetCodeScreen({super.key});

  @override
  State<LeetCodeScreen> createState() => _LeetCodeScreenState();
}

class _LeetCodeScreenState extends State<LeetCodeScreen> {
  bool _isLoading = false;

  Future<void> _fetchProfile() async {
    setState(() {
      _isLoading = true;
    });

    try {
      // Backend API for LeetCode is not implemented yet
      throw Exception('LeetCode API not implemented in backend yet');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('LeetCode Profile'),
      ),
      body: Center(
        child: _isLoading
            ? const CircularProgressIndicator()
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'LeetCode integration is not available yet.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _fetchProfile,
                    child: const Text('Try Fetch Profile'),
                  ),
                ],
              ),
      ),
    );
  }
}
