import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'http://127.0.0.1:8000';

  // ---------------- RESUME PARSE ----------------
  static Future<Map<String, dynamic>> parseResume(File file) async {
    final uri = Uri.parse('$baseUrl/parse-resume');
    final request = http.MultipartRequest('POST', uri);

    request.files.add(
      await http.MultipartFile.fromPath('file', file.path),
    );

    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Parse failed (${response.statusCode})');
    }
  }

  // ---------------- GITHUB FETCH ----------------
  static Future<Map<String, dynamic>> fetchGitHub(String username) async {
    final uri = Uri.parse('https://api.github.com/users/$username');
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('GitHub user not found');
    }
  }

  // ---------------- AI CHAT ----------------
  static Future<String> chat(String message) async {
    final uri = Uri.parse('$baseUrl/chat');

    final response = await http.post(
      uri,
      headers: {'Content-Type': 'application/x-www-form-urlencoded'},
      body: {'message': message},
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body)['reply'];
    } else {
      throw Exception('Chat failed');
    }
  }
}
