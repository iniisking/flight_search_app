import 'dart:convert';
import 'package:http/http.dart' as http;

class DioClient {
  final String baseUrl;
  final Map<String, String> defaultParams;

  DioClient({required this.baseUrl})
    : defaultParams = {
        'access_key': '5fd3d4b8342593d90e29e4ad20e75120', // Your actual API key
      };

  Future<Map<String, dynamic>> get(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
  }) async {
    final params = {...defaultParams, ...?queryParameters};
    final uri = Uri.parse('$baseUrl$endpoint').replace(queryParameters: params);

    print('API Request: $uri'); // Debug logging

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print(
        'API Response: ${data['pagination']?['count'] ?? 0} flights found',
      ); // Debug logging
      return data;
    } else {
      throw Exception(
        'Failed to load data: ${response.statusCode} - ${response.body}',
      );
    }
  }
}
