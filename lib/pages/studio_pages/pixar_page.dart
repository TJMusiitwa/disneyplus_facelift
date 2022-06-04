import 'package:cached_network_image/cached_network_image.dart';
import 'package:disneyplus_facelift/nav_drawer.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:tmdb_dart/tmdb_dart.dart';

class PixarPage extends StatelessWidget {
  const PixarPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    var tmdb = GetIt.I<TmdbService>();

    var allPixar = tmdb.movie
        .discover(
          settings: MovieDiscoverSettings(
              withCompanies: [3],
              includeVideo: true,
              includeAdult: true,
              sortBy: SortBy.release_date.desc,
              releaseDateLTE:
                  Date(day: now.day, month: now.month, year: now.year)),
        )
        .then((value) => value.results);

    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            flexibleSpace: FlexibleSpaceBar(
              title: CachedNetworkImage(
                imageUrl:
                    'https://image.tmdb.org/t/p/w300/1TjvGVDMYsj6JBxOAkUHpPEwLf7.png',
                color: Colors.white,
                fit: BoxFit.scaleDown,
                width: 100,
                alignment: Alignment.bottomLeft,
                maxWidthDiskCache: 100,
                maxHeightDiskCache: 63,
              ),
              centerTitle: false,
              titlePadding: const EdgeInsets.only(left: 10, bottom: 10),
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
            pinned: false,
          ),
          SliverFillRemaining(
            child: FutureBuilder<List<MovieBase>>(
              future: allPixar,
              builder: (context, AsyncSnapshot<List<MovieBase>>? snapshot) {
                if (snapshot!.hasData) {
                  return GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            childAspectRatio: 0.6,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10),
                    itemCount: snapshot.data!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return SizedBox(
                        height: 220,
                        width: 100,
                        child: DecoratedBox(
                            decoration: BoxDecoration(
                          image: DecorationImage(
                            image: CachedNetworkImageProvider(
                              snapshot.data![index].posterPath == null
                                  ? 'https://image.tmdb.org/t/p/w300/1TjvGVDMYsj6JBxOAkUHpPEwLf7.png'
                                  : snapshot.data![index].posterPath!,
                            ),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        )),
                      );
                    },
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
          ),
        ],
      ),
      drawer: const NavDrawer(),
    );
  }
}
