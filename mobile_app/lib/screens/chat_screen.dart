import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl =
      "https://career-ai-app-8x7g.onrender.com";

  static Future<Map<String, dynamic>> parseResumeWeb(
    Uint8List bytes,
    String filename,
    String jd,
  ) async {
    final uri = Uri.parse("$baseUrl/parse-resume");

    final request = http.MultipartRequest("POST", uri)
      ..files.add(
        http.MultipartFile.fromBytes(
          "file",
          bytes,
          filename: filename,
        ),
      )
      ..fields["job_description"] = jd;

    final response = await request.send();
    final res = await http.Response.fromStream(response);

    if (res.statusCode == 200) {
      return jsonDecode(res.body);
    } else {
      throw Exception("Failed to parse resume");
    }
  }

  static Future<String> chat(String query) async {
    final res = await http.post(
      Uri.parse("$baseUrl/chat"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"query": query}),
    );

    if (res.statusCode == 200) {
      return jsonDecode(res.body)["reply"];
    } else {
      throw Exception("Chat failed");
    }
  }
}
