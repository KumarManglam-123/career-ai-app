import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = "http://127.0.0.1:8000";

  static Future<Map<String, dynamic>> parseResume(
    File resumeFile,
    String jobDescription,
  ) async {
    final uri = Uri.parse("$baseUrl/upload");
    final request = http.MultipartRequest("POST", uri);

    request.files.add(
      await http.MultipartFile.fromPath(
        "file",
        resumeFile.path,
      ),
    );

    request.fields["job_description"] = jobDescription;

    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Failed to parse resume");
    }
  }
}
