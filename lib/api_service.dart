import 'dart:convert';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> loginUser(String email, String password) async {
  final url = Uri.parse('http://192.168.100.75/RestEase/api_login.php'); // DITO AY KUNG ANONG IPV4 NG LAPTOP MO
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
  final url = Uri.parse('http://192.168.100.75/RestEase/api_register.php');  // DITO AY KUNG ANONG IPV4 NG LAPTOP MO
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