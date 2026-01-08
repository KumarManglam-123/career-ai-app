import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = "https://career-ai-app-8x7g.onrender.com";


  // 🔹 CHAT API
  static Future<String> chat(String query) async {
    final response = await http.post(
      Uri.parse("$baseUrl/chat"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"query": query}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data["reply"];
    } else {
      throw Exception("Chat API failed");
    }
  }

  // 🔹 RESUME PARSE + ATS API
  static Future<Map<String, dynamic>> parseResume(
      File file, String jobDescription) async {
    var request =
        http.MultipartRequest("POST", Uri.parse("$baseUrl/upload"));

    request.files.add(
      await http.MultipartFile.fromPath("file", file.path),
    );

    request.fields["job_description"] = jobDescription;

    var response = await request.send();
    var responseData = await response.stream.bytesToString();

    if (response.statusCode == 200) {
      return jsonDecode(responseData);
    } else {
      throw Exception("Resume parsing failed");
    }
  }
}
