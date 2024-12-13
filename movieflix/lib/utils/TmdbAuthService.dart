import 'package:http/http.dart' as http;
import 'package:movieflix/utils/settings.dart';
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';
const String _sessionUrl = "https://api.themoviedb.org/3/authentication/session/new";


//this class requests a token from TMDb.
class TmdbAuthService {
  final String _baseUrl = "https://api.themoviedb.org/3/authentication/token/new";
  final String _sessionUrl = "https://api.themoviedb.org/3/authentication/session/new";

  // Request a new token from TMDb
  Future<String?> requestToken() async {
    final url = Uri.parse("$_baseUrl?api_key=${Settings.api_key}");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['request_token'];
    } else {
      throw Exception("Failed to get request token: ${response.body}");
    }
  }

  // Create a session using the approved request token
  Future<String?> createSession(String requestToken) async {
    final url = Uri.parse("$_sessionUrl?api_key=${Settings.api_key}");
    final response = await http.post(
      url,
      body: json.encode({
        "request_token": requestToken,
      }),
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['session_id'];
    } else {
      throw Exception("Failed to create session: ${response.statusCode} - ${response.body}");
    }
  }

  // Simulate checking if the token is approved by trying to create a session
  Future<bool> isTokenApproved(String requestToken) async {
    try {
      String? sessionId = await createSession(requestToken);
      return sessionId != null;
    } catch (e) {
      return false;
    }
  }
}
