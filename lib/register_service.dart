import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:language_game/services/api_config.dart';


class RegisterService {
  Future<bool> register(String username, String email, String password) async {
    final url = Uri.parse("${ApiConfig.baseUrl}/register.php");

    final response = await http.post(
      url,
      body: {
        "username": username,
        "email": email,
        "password": password,
      },
    );

    print(response.body);

    final data = jsonDecode(response.body);

    return data["status"] == "success";
  }
}
