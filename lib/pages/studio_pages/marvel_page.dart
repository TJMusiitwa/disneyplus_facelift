import 'package:cached_network_image/cached_network_image.dart';
import 'package:disneyplus_facelift/nav_drawer.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:tmdb_dart/tmdb_dart.dart';

class MarvelPage extends StatelessWidget {
  const MarvelPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    TmdbService tmdb = GetIt.I<TmdbService>();

    Future<List<MovieBase>> allPixar = tmdb.movie
        .discover(
          settings: MovieDiscoverSettings(
              withCompanies: [420],
              includeVideo: true,
              includeAdult: true,
              language: 'en',
              sortBy: SortBy.release_date.desc,
              releaseDateLTE:
                  Date(day: now.day, month: now.month, year: now.year)),
        )
        .then((value) => value.results);

    return Scaffold(
      body: FutureBuilder<List<MovieBase>>(
        future: allPixar,
        builder: (context, AsyncSnapshot<List<MovieBase>>? snapshot) {
          if (snapshot!.hasData) {
            return CustomScrollView(
              slivers: <Widget>[
                SliverAppBar(
                  flexibleSpace: FlexibleSpaceBar(
                    title: CachedNetworkImage(
                      imageUrl:
                          'https://image.tmdb.org/t/p/original/hUzeosd33nzE5MCNsZxCGEKTXaQ.png',
                      //fit: BoxFit.scaleDown,
                      width: 100,
                      //filterQuality: FilterQuality.high,
                      alignment: Alignment.bottomLeft,
                      maxWidthDiskCache: 100,
                      maxHeightDiskCache: 63,
                    ),
                    centerTitle: false,
                    titlePadding: const EdgeInsets.only(left: 10, bottom: 30),
                  ),
                  expandedHeight: 170,
                  actions: [
                    IconButton(
                      icon: const Icon(Icons.close_outlined),
                      onPressed: () {
                        Scaffold.of(context).openDrawer();
                      },
                    ),
                  ],
                  pinned: true,
                ),
                SliverGrid(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 0.6,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10),
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      return SizedBox(
                        height: 220,
                        width: 100,
                        child: DecoratedBox(
                            decoration: BoxDecoration(
                          image: DecorationImage(
                            image: CachedNetworkImageProvider(
                              snapshot.data![index].posterPath == null
                                  ? 'https://image.tmdb.org/t/p/w300/aGeUvfSNA8gRl6ZjvmLQOsb7PMw.png'
                                  : snapshot.data![index].posterPath!,
                            ),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        )),
                      );
                    },
                    childCount: snapshot.data!.length,
                  ),
                )
              ],
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      drawer: const NavDrawer(),
    );
  }
}
