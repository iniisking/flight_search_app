import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class DioClient {
  final String baseUrl;
  final Map<String, String> defaultParams;

  DioClient({required this.baseUrl})
    : defaultParams = {
        'access_key': dotenv.env['AVIATION_STACK_API_KEY'] ?? '',
      };

  Future<Map<String, dynamic>> get(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
  }) async {
    final params = {...defaultParams, ...?queryParameters};
    final uri = Uri.parse('$baseUrl$endpoint').replace(queryParameters: params);

    debugPrint('API Request: $uri');

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      debugPrint(
        'API Response: ${data['pagination']?['count'] ?? 0} flights found',
      );
      return data;
    } else {
      throw Exception(
        'Failed to load data: ${response.statusCode} - ${response.body}',
      );
    }
  }
}
