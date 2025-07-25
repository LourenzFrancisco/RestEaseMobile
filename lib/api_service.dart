import 'dart:convert';
import 'package:http/http.dart' as http;
import 'config.dart';

Future<Map<String, dynamic>> loginUser(String email, String password) async {
  final baseUrl = await ApiConfig.getApiBaseUrl();
  final response = await http.post(
    Uri.parse('$baseUrl/api/api_login.php'),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({
      "email": email,
      "password": password,
    }),
  );

  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    return {'success': false, 'message': 'Server error: ${response.statusCode}'};
  }
}

Future<Map<String, dynamic>> registerUser({
  required String firstName,
  required String lastName,
  required String email,
  required String contactNo,
  required String password,
  required String confirmPassword,
  required bool terms,
}) async {
  final baseUrl = await ApiConfig.getApiBaseUrl();
  final response = await http.post(
    Uri.parse('$baseUrl/api/api_register.php'),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({
      "first_name": firstName,
      "last_name": lastName,
      "email": email,
      "contact_no": contactNo,
      "password": password,
      "confirm_password": confirmPassword,
      "terms": terms
    }),
  );

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    return data;
  } else {
    return {'success': false, 'message': 'Server error: ${response.statusCode}'};
  }
}

Future<List<Map<String, dynamic>>> fetchClientRequests(int userId) async {
  final baseUrl = await ApiConfig.getApiBaseUrl();
  final url = Uri.parse('$baseUrl/ClientSide/get_client_requests.php'); // Use config

  final response = await http.post(url, body: {'user_id': userId.toString()});
  if (response.statusCode == 200) {
    final List data = jsonDecode(response.body);
    return data.cast<Map<String, dynamic>>();
  } else {
    throw Exception('Failed to load requests');
  }
}

Future<List<Map<String, dynamic>>> fetchAcceptedRequests(int userId) async {
  final baseUrl = await ApiConfig.getApiBaseUrl();
  final url = Uri.parse('$baseUrl/ClientSide/get_accepted_requests.php'); // Use config
  final response = await http.post(url, body: {'user_id': userId.toString()});
  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    if (data['success'] == true) {
      return List<Map<String, dynamic>>.from(data['requests']);
    } else {
      return [];
    }
  } else {
    throw Exception('Failed to load accepted requests');
  }
}