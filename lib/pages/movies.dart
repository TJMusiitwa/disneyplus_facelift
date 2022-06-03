import 'package:disneyplus_facelift/nav_drawer.dart';
import 'package:disneyplus_facelift/pages/movie_details.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:tmdb_dart/tmdb_dart.dart';

class MoviesPage extends StatelessWidget {
  const MoviesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var tmdb = GetIt.I<TmdbService>();
    var disneyMovies = tmdb.movie
        .discover(
            settings: MovieDiscoverSettings(
                includeAdult: true,
                includeVideo: true,
                sortBy: SortBy.release_date,
                withCompanies: [420]))
        .then((value) => value.results);

    return Scaffold(
      drawer: const NavDrawer(),
      body: CustomScrollView(
        slivers: <Widget>[
          const SliverAppBar(
            pinned: true,
            expandedHeight: 200,
            flexibleSpace: FlexibleSpaceBar(
              background: ColoredBox(color: Colors.deepPurpleAccent),
              centerTitle: false,
              title: Text('Movies'),
            ),
          ),
          SliverFillRemaining(
            child: FutureBuilder<List<MovieBase>>(
              future: disneyMovies,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(snapshot.data![index].title),
                        subtitle:
                            Text(snapshot.data![index].releaseDate.toString()),
                        // leading: Image.network(
                        //   'https://image.tmdb.org/t/p/w300/${snapshot.data![index].posterPath}',
                        //   fit: BoxFit.cover,
                        // ),
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => MovieDetails(
                                    movieId: snapshot.data![index].id),
                                fullscreenDialog: true)),
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }
                return const Center(child: CircularProgressIndicator());
              },
            ),
          ),
        ],
      ),
    );
  }
}
