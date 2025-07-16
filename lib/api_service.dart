import 'dart:convert';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> loginUser(String email, String password) async {

  final url = Uri.parse('http://192.168.142.227/RestEase/api/api_login.php'); // DITO AY KUNG ANONG IPV4 NG LAPTOP MO

  final response = await http.post(
    url,
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

  final url = Uri.parse('http://192.168.142.227/RestEase/api/api_register.php');  // DITO AY KUNG ANONG IPV4 NG LAPTOP MO

  final response = await http.post(
    url,
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

  final url = Uri.parse('http://192.168.142.227/RestEase/ClientSide/get_client_requests.php');

  final response = await http.post(url, body: {'user_id': userId.toString()});
  if (response.statusCode == 200) {
    final List data = jsonDecode(response.body);
    return data.cast<Map<String, dynamic>>();
  } else {
    throw Exception('Failed to load requests');
  }
}

Future<List<Map<String, dynamic>>> fetchAcceptedRequests(int userId) async {
  final url = Uri.parse('http://192.168.142.227/RestEase/ClientSide/get_accepted_requests.php');
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