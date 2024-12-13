import 'package:flutter/material.dart';

class CardWidget extends StatelessWidget {
  final String topText;
  final String bottomText;
  final String leadingImagePath; // Path to the image asset

  const CardWidget({
    required this.topText,
    required this.bottomText,
    required this.leadingImagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              topText,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 4),
            Row(
              children: [
                Image.asset(
                  leadingImagePath,
                  width: 24, // Adjust the width as needed
                  height: 24, // Adjust the height as needed
                ),
                SizedBox(width: 8),
                Text(bottomText),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
