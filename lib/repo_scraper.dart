import 'dart:convert';
import 'package:http/http.dart' as http;

class RepoScraper {
  Future<String> scrapeRepo(String repoUrl, String docUrl, List<String> selectedFileTypes) async {
    final response = await http.post(
      Uri.parse('http://localhost:5000/scrape'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'repoUrl': repoUrl,
        'docUrl': docUrl,
        'selectedFileTypes': selectedFileTypes,
      }),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body)['response'];
    } else {
      throw Exception('Failed to scrape repo');
    }
  }
}