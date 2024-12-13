import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:tmdb_api/tmdb_api.dart';
import '../models/movie.dart';
import '../utils/settings.dart';
import '../widgets/bottomNavigationBar.dart';
import 'movieDetails.dart';

const apiKey = Settings.api_key;
const apiToken = Settings.api_token;

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final tmdbWithCustomLogs = TMDB(
    ApiKeys(apiKey, apiToken),
    logConfig: const ConfigLogger(
      showLogs: true, // must be true, then only all other logs will be shown
      showErrorLogs: true,
    ),
  );

  List<Movie> trendingMovies = []; // To hold the fetched movies
  List<Movie> topRatedMovies = []; // To hold top rated movies
  List<Movie> upcomingMovies = []; //
  List<Movie> popularMovies = [];

  bool isLoadingTrending = true;
  bool isLoadingTopRated = true;
  bool isLoadingUpcoming = true;
  bool isLoadingPopular = true;


  @override
  void initState() {
    super.initState();
    fetchTrendingMovies();
    fetchTopRatedMovies();
    fetchUpcomingMovies();
    fetchPopular();

  }

  Future<void> fetchPopular() async {
    try {
      List<Movie> moviesList = await getPopular();
      setState(() {
        popularMovies = moviesList;
        isLoadingPopular = false;
      });
    } catch (e) {
      print("An error occurred while fetching the data: $e");
      setState(() {
        isLoadingPopular = false;
      });
    }
  }

  Future<List<Movie>> getPopular() async {
    try {
      Map result = await tmdbWithCustomLogs.v3.movies.getPopular();
      if (result.containsKey('results') && result['results'] is List) {
        var resultsList = result['results'];
        if (resultsList.isNotEmpty) {
          List<Movie> moviesList = [];
          int count = resultsList.length < 5 ? resultsList.length : 5;

          for (int i = 0; i < count; i++) {
            var movieData = resultsList[i];
            String backdropPath = movieData['backdrop_path'] ?? '';
            String title = movieData['title'] ?? 'Unknown Title';
            double voteAverage = movieData['vote_average'] ?? 0.0;

            int id = movieData['id'] ?? 0;

            String originalTitle = movieData['original_title'] ?? 'Unknown Original Title';
            String overview = movieData['overview'] ?? 'No overview available.';
            String posterPath = movieData['poster_path'] ?? '';
            String mediaType = movieData['media_type'] ?? 'Unknown';
            bool adult = movieData['adult'] ?? false;
            String originalLanguage = movieData['original_language'] ?? 'Unknown';
            List<int> genreIds = movieData['genre_ids'] != null ? List<int>.from(movieData['genre_ids']) : [];

            // Handle popularity as a double
            double popularity = movieData['popularity'] ?? 0.0;

            String releaseDate = movieData['release_date'] ?? 'Unknown';
            bool video = movieData['video'] ?? false;
            int voteCount = movieData['vote_count'] ?? 0;

            Movie movie = Movie(
                backdropPath,
                id,
                title,
                originalTitle,
                overview,
                posterPath,
                mediaType,
                adult,
                originalLanguage,
                genreIds,
                popularity,
                releaseDate,
                video,
                voteAverage,
                voteCount
            );
            moviesList.add(movie);
          }
          return moviesList;
        } else {
          print("The 'results' list is empty.");
          return [];
        }
      } else {
        print("'results' key is missing or not a list.");
        return [];
      }
    } catch (e) {
      print("An error occurred while fetching the data: $e");
      return [];
    }
  }


  Future<void> fetchUpcomingMovies() async {
    try {
      List<Movie> moviesList = await getUpcoming();
      setState(() {
        upcomingMovies = moviesList;
        isLoadingUpcoming = false;
      });
    } catch (e) {
      print("An error occurred while fetching the data: $e");
      setState(() {
        isLoadingUpcoming = false;
      });
    }
  }

  Future<List<Movie>> getUpcoming() async {
    try {
      Map result = await tmdbWithCustomLogs.v3.movies.getUpcoming();
      if (result.containsKey('results') && result['results'] is List) {
        var resultsList = result['results'];
        if (resultsList.isNotEmpty) {
          List<Movie> moviesList = [];
          int count = resultsList.length < 5 ? resultsList.length : 5;

          for (int i = 0; i < count; i++) {
            var movieData = resultsList[i];
            String backdropPath = movieData['backdrop_path'] ?? '';
            String title = movieData['title'] ?? 'Unknown Title';
            double voteAverage = movieData['vote_average'] ?? 0.0;

            int id = movieData['id'] ?? 0;

            String originalTitle = movieData['original_title'] ?? 'Unknown Original Title';
            String overview = movieData['overview'] ?? 'No overview available.';
            String posterPath = movieData['poster_path'] ?? '';
            String mediaType = movieData['media_type'] ?? 'Unknown';
            bool adult = movieData['adult'] ?? false;
            String originalLanguage = movieData['original_language'] ?? 'Unknown';
            List<int> genreIds = movieData['genre_ids'] != null ? List<int>.from(movieData['genre_ids']) : [];

            // Handle popularity as a double
            double popularity = movieData['popularity'] ?? 0.0;

            String releaseDate = movieData['release_date'] ?? 'Unknown';
            bool video = movieData['video'] ?? false;
            int voteCount = movieData['vote_count'] ?? 0;

            Movie movie = Movie(
                backdropPath,
                id,
                title,
                originalTitle,
                overview,
                posterPath,
                mediaType,
                adult,
                originalLanguage,
                genreIds,
                popularity,
                releaseDate,
                video,
                voteAverage,
                voteCount
            );
            moviesList.add(movie);
          }
          return moviesList;
        } else {
          print("The 'results' list is empty.");
          return [];
        }
      } else {
        print("'results' key is missing or not a list.");
        return [];
      }
    } catch (e) {
      print("An error occurred while fetching the data: $e");
      return [];
    }
  }




  Future<void> fetchTopRatedMovies() async {
    try {
      List<Movie> moviesList = await getTopRated();
      setState(() {
        topRatedMovies = moviesList;
        isLoadingTopRated = false;
      });
    } catch (e) {
      print("An error occurred while fetching the data: $e");
      setState(() {
        
        isLoadingTopRated = false;
      });
    }
  }

  Future<List<Movie>> getTopRated() async {
    try {
      Map result = await tmdbWithCustomLogs.v3.movies.getTopRated();
      if (result.containsKey('results') && result['results'] is List) {
        var resultsList = result['results'];
        if (resultsList.isNotEmpty) {
          List<Movie> moviesList = [];
          int count = resultsList.length < 5 ? resultsList.length : 5;

          for (int i = 0; i < count; i++) {
            var movieData = resultsList[i];
            String backdropPath = movieData['backdrop_path'] ?? '';
            String title = movieData['title'] ?? 'Unknown Title';
            double voteAverage = movieData['vote_average'] ?? 0.0;

            int id = movieData['id'] ?? 0;

            String originalTitle = movieData['original_title'] ?? 'Unknown Original Title';
            String overview = movieData['overview'] ?? 'No overview available.';
            String posterPath = movieData['poster_path'] ?? '';
            String mediaType = movieData['media_type'] ?? 'Unknown';
            bool adult = movieData['adult'] ?? false;
            String originalLanguage = movieData['original_language'] ?? 'Unknown';
            List<int> genreIds = movieData['genre_ids'] != null ? List<int>.from(movieData['genre_ids']) : [];

            // Handle popularity as a double
            double popularity = movieData['popularity'] ?? 0.0;

            String releaseDate = movieData['release_date'] ?? 'Unknown';
            bool video = movieData['video'] ?? false;
            int voteCount = movieData['vote_count'] ?? 0;

            Movie movie = Movie(
                backdropPath,
                id,
                title,
                originalTitle,
                overview,
                posterPath,
                mediaType,
                adult,
                originalLanguage,
                genreIds,
                popularity,
                releaseDate,
                video,
                voteAverage,
                voteCount
            );
            moviesList.add(movie);
          }
          return moviesList;
        } else {
          print("The 'results' list is empty.");
          return [];
        }
      } else {
        print("'results' key is missing or not a list.");
        return [];
      }
    } catch (e) {
      print("An error occurred while fetching the data: $e");
      return [];
    }
  }

  Future<void> fetchTrendingMovies() async {
    try {
      List<Movie> moviesList = await getTrending();
      setState(() {
        trendingMovies = moviesList;
        isLoadingTrending = false;
      });
    } catch (e) {
      print("An error occurred while fetching the data: $e");
      setState(() {
        isLoadingTrending = false;
      });
    }
  }

  Future<void> getTrendingMovies() async {
    try {
      List<Movie> moviesList = await getTrending();
      setState(() {
        trendingMovies = moviesList;
        isLoadingTrending = false;
      });
    } catch (e) {
      print("An error occurred while fetching the data: $e");
      setState(() {
        isLoadingTrending = false;
      });
    }
  }

  Future<List<Movie>> getTrending() async {
    try {
      Map result = await tmdbWithCustomLogs.v3.trending.getTrending();
      if (result.containsKey('results') && result['results'] is List) {
        var resultsList = result['results'];
        if (resultsList.isNotEmpty) {
          List<Movie> moviesList = [];
          int count = resultsList.length < 5 ? resultsList.length : 5;

          for (int i = 0; i < count; i++) {
            var movieData = resultsList[i];
            String backdropPath = movieData['backdrop_path'] ?? '';
            String title = movieData['title'] ?? 'Unknown Title';
            double voteAverage = movieData['vote_average'] ?? 0.0;

            int id = movieData['id'] ?? 0;

            String originalTitle = movieData['original_title'] ?? 'Unknown Original Title';
            String overview = movieData['overview'] ?? 'No overview available.';
            String posterPath = movieData['poster_path'] ?? '';
            String mediaType = movieData['media_type'] ?? 'Unknown';
            bool adult = movieData['adult'] ?? false;
            String originalLanguage = movieData['original_language'] ?? 'Unknown';
            List<int> genreIds = movieData['genre_ids'] != null ? List<int>.from(movieData['genre_ids']) : [];

            // Handle popularity as a double
            double popularity = movieData['popularity'] ?? 0.0;

            String releaseDate = movieData['release_date'] ?? 'Unknown';
            bool video = movieData['video'] ?? false;
            int voteCount = movieData['vote_count'] ?? 0;

            print("Vote count $voteCount");

            Movie movie = Movie(
                backdropPath,
                id,
                title,
                originalTitle,
                overview,
                posterPath,
                mediaType,
                adult,
                originalLanguage,
                genreIds,
                popularity,  // Use double instead of List<double>
                releaseDate,
                video,
                voteAverage,
                voteCount
            );
            moviesList.add(movie);
            print("MOVIE TITLE: ${movie.title}"); // Debugging: Print each movie title
          }
          return moviesList;
        } else {
          print("The 'results' list is empty.");
          return [];
        }
      } else {
        print("'results' key is missing or not a list.");
        return [];
      }
    } catch (e) {
      print("An error occurred while fetching the data: $e");
      return [];
    }
  }





  @override
  Widget build(BuildContext context) {
    // Mock list of movies


    return Scaffold(
      appBar: AppBar(
        title: SizedBox(
          height: 40,
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Search...',
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: Colors.white,
              contentPadding: EdgeInsets.symmetric(vertical: 10),
            ),
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white10,
      ),
      body:  isLoadingTrending
          ? Center(child: CircularProgressIndicator())
          : trendingMovies.isEmpty
          ? Center(child: Text("No movies available"))
          : SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Carousel Slider
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CarouselSlider(
                options: CarouselOptions(
                  height: 270,
                  aspectRatio: 16 / 9,
                  viewportFraction: 0.8,
                  initialPage: 0,
                  enableInfiniteScroll: true,
                  reverse: false,
                  autoPlay: true,
                  autoPlayInterval: Duration(seconds: 3),
                  autoPlayAnimationDuration: Duration(milliseconds: 800),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enlargeCenterPage: true,
                  scrollDirection: Axis.horizontal,
                ),
                items: trendingMovies.map((movie) {
                  return Builder(
                    builder: (BuildContext context) {
                      return GestureDetector(
                        onTap: () {
                          // Navigate to the Movie Details Screen
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MovieDetails(movie: movie), // Pass movie data
                            ),
                          );
                        },
                        child: Column(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width,
                              margin: EdgeInsets.symmetric(horizontal: 5.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                  image: NetworkImage(
                                      'https://image.tmdb.org/t/p/w500${movie.posterPath}'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              height: 180,
                            ),
                            SizedBox(height: 8),
                            Text(
                              movie.title,
                              style: TextStyle(
                                  fontSize: 10.0,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 4),
                            RatingBarIndicator(
                              rating: movie.voteAverage / 2, // Assuming the rating is out of 10, scale it to 5
                              itemBuilder: (context, index) => Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              itemCount: 5,
                              itemSize: 20.0,
                              direction: Axis.horizontal,
                            ),
                          ],
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
            ),

            // Top Rated Movies
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Top Rated',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 220, // Increased height to accommodate image, title, and rating
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: topRatedMovies.length,
                itemBuilder: (context, index) {
                  final movie = topRatedMovies[index]; // Store movie object for easy access
                  return GestureDetector(
                    onTap: () {
                      // Navigate to the MovieDetailsPage when tapped
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MovieDetails(movie: movie),
                        ),
                      );
                    },
                    child: Container(
                      width: 120,
                      margin: EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 120,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                image: NetworkImage(
                                  'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            movie.title,
                            style: TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 4),
                          RatingBarIndicator(
                            rating: movie.voteAverage / 2,
                            itemBuilder: (context, index) => Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            itemCount: 5,
                            itemSize: 15.0,
                            direction: Axis.horizontal,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),


            // Upcoming Movies
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Upcoming',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 220, // Increased height to accommodate image, title, and rating
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: upcomingMovies.length,
                itemBuilder: (context, index) {
                  final movie = upcomingMovies[index]; // Store the movie object for easy access
                  return GestureDetector(
                    onTap: () {
                      // Navigate to the MovieDetailsPage when tapped
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MovieDetails(movie: movie),
                        ),
                      );
                    },
                    child: Container(
                      width: 120,
                      margin: EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 120,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                image: NetworkImage(
                                  'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            movie.title,
                            style: TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 4),
                          RatingBarIndicator(
                            rating: movie.voteAverage / 2,
                            itemBuilder: (context, index) => Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            itemCount: 5,
                            itemSize: 15.0,
                            direction: Axis.horizontal,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),


            // Popular Movies
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Popular',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 220, // Increased height to accommodate image, title, and rating
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: topRatedMovies.length,
                itemBuilder: (context, index) {
                  final movie = topRatedMovies[index]; // Store the movie object for easy access
                  return GestureDetector(
                    onTap: () {
                      // Navigate to the MovieDetailsPage when tapped
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MovieDetails(movie: movie),
                        ),
                      );
                    },
                    child: Container(
                      width: 120,
                      margin: EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 120,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                image: NetworkImage(
                                  'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            movie.title,
                            style: TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 4),
                          RatingBarIndicator(
                            rating: movie.voteAverage / 2,
                            itemBuilder: (context, index) => Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            itemCount: 5,
                            itemSize: 15.0,
                            direction: Axis.horizontal,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),


          ],
        ),
      ),
      bottomNavigationBar: const BottomNavWidget(),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: HomePage(),
    debugShowCheckedModeBanner: false,
  ));
}
