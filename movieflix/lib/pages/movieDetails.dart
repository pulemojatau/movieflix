import '../models/movie.dart';
import '../utils/hexcolor.dart';
import 'package:flutter/material.dart';

class MovieDetails extends StatefulWidget {
  final Movie movie;  // Declare the movie object as a final variable

  const MovieDetails({super.key, required this.movie});  // Pass the movie object through the constructor

  @override
  State<MovieDetails> createState() => _MovieDetailsState();
}

class _MovieDetailsState extends State<MovieDetails> {
  Color grey = HexColor("4d514b");

  @override
  Widget build(BuildContext context) {
    // You can now access the movie object via widget.movie
    final movie = widget.movie;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('Details'),
        centerTitle: true,
        backgroundColor: Colors.grey,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient:
          //it has begin , end , stops , for controlling how the gradient color allighb
          LinearGradient(
            colors: [Color(0x02c6341a), Color(0xd6a80e0e)],
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(

                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  gradient:
                  //it has begin , end , stops , for controlling how the gradient color allighb
                  const LinearGradient(
                    colors: [Color(0xFF2C2C2C), Color(0xFFB0B0B0)],
                  ),

                    borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: NetworkImage("https://image.tmdb.org/t/p/w500${movie.posterPath}"),  // Use the movie's image URL
                    fit: BoxFit.cover,
                  ),
                ),
                height: 200,
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                // gradient:
                // //it has begin , end , stops , for controlling how the gradient color allighb
                // LinearGradient(
                //   colors: [Color(0x02c6341a), Color(0xd6a80e0e)],
                // ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          // Wrap the Column in Expanded so it takes up the remaining space in the Row
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,  // Align the text to the left
                              children: [
                                Text(
                                  movie.title,  // Use movie title here
                                  style: const TextStyle(
                                    fontSize: 17.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  maxLines: 1,  // Limits the text to a single line
                                  overflow: TextOverflow.ellipsis,  // Adds "..." at the end if the text overflows
                                ),
                                Text(
                                  "Release-Date: ${movie.release_date}",  // Display release date dynamically
                                  style: const TextStyle(
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            decoration: const BoxDecoration(
                              gradient:
                              //it has begin , end , stops , for controlling how the gradient color allighb
                              LinearGradient(
                                colors: [Color(0x02c6341a), Color(0xd6a80e0e)],
                              ),
                            ),
                            width: 30.0,
                            height: 30.0,
                            margin: const EdgeInsets.all(10.0),
                            child: Image.asset(
                              'images/imdb-icon.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                          Text(
                            "${movie.voteAverage.toStringAsFixed(1)}/10",  // Display movie rating with 1 decimal place
                            style: const TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                        ],
                      ),

                      const Divider(
                        color: Colors.black,
                        thickness: 1.0,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(10.0),
              child: const Row(
                children: [
                  Text(
                    "Synopsis",
                    style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.all(10.0),
              child: Text(movie.overview),  // Display movie description
            ),
          ],
        ),
      ),
    );
  }
}
