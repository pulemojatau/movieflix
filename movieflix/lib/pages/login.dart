import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../utils/TmdbAuthService.dart';


class AuthPage extends StatefulWidget {
  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final TmdbAuthService _authService = TmdbAuthService();

  Future<void> _authenticateUser() async {
    try {
      // Step 1: Request token
      String? requestToken = await _authService.requestToken();
      print("Token: $requestToken");

      if (requestToken != null) {
        // Step 2: Redirect to TMDb login page
        await launchTmdbLogin(requestToken);

        // Step 3: Poll for token approval before creating session
        bool isApproved = await _pollForTokenApproval(requestToken);

        if (isApproved) {
          // Create session if the token is approved
          String? sessionId = await _authService.createSession(requestToken);
          if (sessionId != null) {
            print("User session created: $sessionId");
            // Save the session ID securely
          } else {
            print("Failed to create session");
          }
        } else {
          print("Token was not approved by the user.");
        }
      } else {
        print("Failed to get request token.");
      }
    } catch (e) {
      print("Authentication failed: $e");
    }
  }

  // Function to poll the TMDb API to check if the token has been approved
  Future<bool> _pollForTokenApproval(String requestToken) async {
    const int maxRetries = 10; // Poll for a maximum of 10 times
    const Duration pollInterval = Duration(seconds: 5); // Poll every 5 seconds

    for (int i = 0; i < maxRetries; i++) {
      bool isApproved = await _authService.isTokenApproved(requestToken);

      if (isApproved) {
        return true; // Token is approved, proceed
      }

      await Future.delayed(pollInterval);
    }

    return false; // Timeout
  }

  // Redirect User to TMDb for Authentication
  Future<void> launchTmdbLogin(String requestToken) async {
    final String loginUrl = "https://www.themoviedb.org/authenticate/$requestToken";
    final Uri url = Uri.parse(loginUrl);

    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      throw Exception("Could not launch $loginUrl");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TMDb Authentication'),
        backgroundColor: Colors.transparent, // Make AppBar background transparent
        elevation: 0, // Remove shadow
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0x02c6341a), // Start color
                Color(0xd6a80e0e), // End color
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0x02c6341a), // Start color
              Color(0xd6a80e0e), // End color
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: ElevatedButton(
            onPressed: _authenticateUser,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.yellow, // Set your desired background color here
            ),
            child: const Text('Login with TMDb'),
          ),
        ),
      ),
    );
  }

}
