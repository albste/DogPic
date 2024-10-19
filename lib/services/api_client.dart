// ignore_for_file: depend_on_referenced_packages

import 'package:http/http.dart' as http;

class ApiClient {
  Future<http.Response> get(String url) async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return response;
    } else {
      throw Exception('Failed to load data');
    }
  }
}
