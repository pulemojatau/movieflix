import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class Watchlist extends StatefulWidget {
  const Watchlist({super.key});

  @override
  State<Watchlist> createState() => _WatchlistState();
}

class _WatchlistState extends State<Watchlist> {
  final List<Movie> watchlistMovies = [
    Movie(
      title: "Inception",
      posterPath: "https://picsum.photos/200/300", // Placeholder image URL
      overview: "A skilled thief is given a chance to have his past crimes erased if he can plant an idea in someone's mind.",
      rating: 8.8,
    ),
    Movie(
      title: "Interstellar",
      posterPath: "https://picsum.photos/200/300", // Placeholder image URL
      overview: "A group of explorers travel through a wormhole in space in an attempt to ensure humanity's survival.",
      rating: 8.6,
    ),
    // Add more movies as required
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Watchlist'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: watchlistMovies.length,
          itemBuilder: (context, index) {
            final movie = watchlistMovies[index];
            return MovieCard(movie: movie);
          },
        ),
      ),
    );
  }
}

// Define the Movie model
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

// MovieCard Widget
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
            // Movie Poster with Icon on top-right corner
            Stack(
              children: [
                Container(
                  width: 100,
                  height: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    image: DecorationImage(
                      image: NetworkImage(movie.posterPath),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                // Icon on top-right corner
                Positioned(
                  top: 5,
                  right: 5,
                  child: Icon(
                    Icons.bookmark, // or any icon you prefer
                    color: Colors.redAccent,
                    size: 24,
                  ),
                ),
              ],
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
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3, // Limit the overview to 3 lines
                  ),
                  SizedBox(height: 8),
                  // Rating Display
                  Row(
                    children: [
                      RatingBarIndicator(
                        rating: movie.rating / 2, // Convert to 5-star scale
                        itemBuilder: (context, index) => Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        itemCount: 5,
                        itemSize: 18.0,
                        direction: Axis.horizontal,
                      ),
                      SizedBox(width: 8),
                      Text(
                        '${movie.rating}', // Show numeric rating
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[800],
                        ),
                      ),
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
