import 'package:flutter/material.dart';

import 'bottomNavigationBar.dart';



class MovieCard extends StatelessWidget {
  final Movie movie;

  MovieCard({required this.movie});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5, // Adds a shadow to the card
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10), // Rounded corners
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            // Movie Poster
            Container(
              width: 100,
              height: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                  image: NetworkImage(
                    'https://image.tmdb.org/t/p/w500${movie.posterPath}', // Movie poster URL
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(width: 10),
            // Movie Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Movie Title
                  Text(
                    movie.title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  // Movie Overview
                  Text(
                    movie.overview,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                    overflow: TextOverflow.ellipsis, // Adds ellipsis for long text
                    maxLines: 3, // Restrict the number of lines
                  ),
                  SizedBox(height: 10),
                  // Add more movie details here (e.g., release date, rating)
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.amber, size: 16),
                      SizedBox(width: 5),
                      Text('Rating: 4.5'), // Replace with actual rating
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );

  }

}

class Movie {
  final String title;
  final String posterPath;
  final String overview;
  final double rating; // Add a rating property

  Movie({
    required this.title,
    required this.posterPath,
    required this.overview,
    required this.rating,
  });
}
