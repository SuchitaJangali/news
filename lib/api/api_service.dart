import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl;
  final Map<String, String> defaultHeaders;

  ApiService({
    required this.baseUrl,
    this.defaultHeaders = const {'Content-Type': 'application/json'},
  });

  /// Generic GET
  Future<Map<String, dynamic>> get(
      String endpoint, {
        Map<String, String>? headers,
        Map<String, String>? queryParams,
      }) async {
    try {
      Uri uri = Uri.parse('$baseUrl$endpoint').replace(queryParameters: queryParams);
      final response = await http.get(uri, headers: headers ?? defaultHeaders);
      return _decodeResponse(response);
    } catch (e) {
      throw Exception('GET request failed: $e');
    }
  }

  /// Generic POST
  Future<Map<String, dynamic>> post(
      String endpoint, {
        Map<String, String>? headers,
        dynamic body,
      }) async {
    try {
      Uri uri = Uri.parse('$baseUrl$endpoint');
      final response = await http.post(
        uri,
        headers: headers ?? defaultHeaders,
        body: json.encode(body),
      );
      return _decodeResponse(response);
    } catch (e) {
      throw Exception('POST request failed: $e');
    }
  }

  /// Optional: PUT
  Future<Map<String, dynamic>> put(
      String endpoint, {
        Map<String, String>? headers,
        dynamic body,
      }) async {
    try {
      Uri uri = Uri.parse('$baseUrl$endpoint');
      final response = await http.put(
        uri,
        headers: headers ?? defaultHeaders,
        body: json.encode(body),
      );
      return _decodeResponse(response);
    } catch (e) {
      throw Exception('PUT request failed: $e');
    }
  }

  /// Optional: DELETE
  Future<Map<String, dynamic>> delete(
      String endpoint, {
        Map<String, String>? headers,
      }) async {
    try {
      Uri uri = Uri.parse('$baseUrl$endpoint');
      final response = await http.delete(uri, headers: headers ?? defaultHeaders);
      return _decodeResponse(response);
    } catch (e) {
      throw Exception('DELETE request failed: $e');
    }
  }

  /// Common JSON Decode and Error handling
  Map<String, dynamic> _decodeResponse(http.Response response) {
    try {
      final Map<String, dynamic> responseBody = json.decode(response.body);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return responseBody;
      } else {
        throw Exception('HTTP Error: ${response.statusCode} → ${response.body}');
      }
    } catch (e) {
      throw Exception('Response decode failed: $e');
    }
  }
}
