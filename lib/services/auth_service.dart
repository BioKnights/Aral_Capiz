import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthService {

  // 👉 CHANGE THIS depending on device:
  // Windows desktop:
  // static const String baseUrl = "http://127.0.0.1/language_game_api";
  //
  // Android Emulator:
  // static const String baseUrl = "http://10.0.2.2/language_game_api";

  static const String baseUrl = "http://localhost/language_game_api";
  // ← use emulator

  static Future<bool> registerUser(String username, String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse("$baseUrl/register.php"),
        body: {
          "username": username,
          "email": email,
          "password": password,
        },
      );

      print("REGISTER RESPONSE: ${response.body}");

      final data = jsonDecode(response.body);

      return data["status"] == "success";
    } catch (e) {
      print("REGISTER ERROR: $e");
      return false;
    }
  }

  static Future<bool> loginUser(String username, String password) async {
    try {
      final response = await http.post(
        Uri.parse("$baseUrl/login.php"),
        body: {
          "username": username,
          "password": password,
        },
      );

      print("LOGIN RESPONSE: ${response.body}");

      final data = jsonDecode(response.body);

      return data["status"] == "success";
    } catch (e) {
      print("LOGIN ERROR: $e");
      return false;
    }
  }
}
