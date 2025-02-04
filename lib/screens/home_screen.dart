import 'package:flutflix/api/api.dart';
import 'package:flutflix/models/movie.dart';
import 'package:flutflix/widgets/movies_slider.dart';
import 'package:flutflix/widgets/trending_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState  extends State<HomeScreen> {

  late Future<List<Movie>> trendingMovies;
  late Future<List<Movie>> topRatedMovies;
  late Future<List<Movie>> upComingMovies;

  @override
  void initState() {
    super.initState();
    trendingMovies = Api().getTrendingMovies();
    topRatedMovies = Api().getTopRatedMovies();
    upComingMovies = Api().getUpcomingMovies();
  }

  @override
  Widget build(BuildContext context) {
   return Scaffold(
    appBar: AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      // title: Image.asset(
      //   'assets/photo.png',
      //   fit: BoxFit.cover,
      //   height: 40,
      //   filterQuality: FilterQuality.high,
      // ),
      title: const Text("FLUTFLIX",
            style: TextStyle(
            color: Color.fromARGB(255, 26, 149, 249),
          ),
        ),
      centerTitle: true,
    ),

    body: SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Trending Movies',
              style: GoogleFonts.aBeeZee(fontSize: 25),
              ),
            const SizedBox(height: 32),

            SizedBox(
              child: FutureBuilder(
                future: trendingMovies,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {

                    return Center(
                      child: Text(snapshot.error.toString()),
                    );
                  }else if(snapshot.hasData) {
                    // final data = snapshot.data;
                    
                    return TrendingSlider(snapshot: snapshot);
                  }else {
                    return const Center(child: CircularProgressIndicator(),);
                  }
                },
              ),
            ),

            const SizedBox(height: 32),

            Text(
              'Top rated movies',
              style: GoogleFonts.aBeeZee(
                fontSize: 25,
              )
            ),
            
            const SizedBox(height: 32),

            SizedBox(
              child: FutureBuilder(
                future: topRatedMovies,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {

                    return Center(
                      child: Text(snapshot.error.toString()),
                    );
                  }else if(snapshot.hasData) {
                    // final data = snapshot.data;
                    
                    return MoviesSlider(snapshot: snapshot);
                  }else {
                    return const Center(child: CircularProgressIndicator(),);
                  }
                },
              ),
            ),

            const SizedBox(height: 32),

            Text(
              'Upcoming movies',
              style: GoogleFonts.aBeeZee(
                fontSize: 25,
              )
            ),

            const SizedBox(height: 32),

            SizedBox(
              child: FutureBuilder(
                future: upComingMovies,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {

                    return Center(
                      child: Text(snapshot.error.toString()),
                    );
                  }else if(snapshot.hasData) {
                    // final data = snapshot.data;
                    
                    return MoviesSlider(snapshot: snapshot);
                  }else {
                    return const Center(child: CircularProgressIndicator(),);
                  }
                },
              ),
            ),
            
          ],
        ),
      ),
    ),
   );
  }
}





