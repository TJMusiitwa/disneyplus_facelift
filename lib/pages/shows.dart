import 'package:disneyplus_facelift/nav_drawer.dart';
import 'package:disneyplus_facelift/pages/show_details.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:tmdb_dart/tmdb_dart.dart';

class ShowsPage extends StatelessWidget {
  const ShowsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    var tmdb = GetIt.I<TmdbService>();
    var disneyPlusShows = tmdb.tv
        .discover(
            settings: TvDiscoverSettings(
                includeAdult: true,
                sortBy: SortBy.first_air_date.desc,
                firstAirDateLTE:
                    Date(day: now.day, month: now.month, year: now.year),
                withNetworks: [2739]),
            page: 1)
        .then((value) => value.results);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shows'),
      ),
      drawer: const NavDrawer(),
      body: FutureBuilder<List<TvBase>>(
          future: disneyPlusShows,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text(snapshot.data![index].name),
                    subtitle:
                        Text(snapshot.data![index].firstAirDate.toString()),
                    // leading: Image.network(
                    //   'https://image.tmdb.org/t/p/w300/${snapshot.data![index].posterPath}',
                    //   fit: BoxFit.cover,
                    // ),
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => ShowDetails(
                                showId: int.tryParse(
                                    snapshot.data![index].id.toString())!),
                            fullscreenDialog: true)),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            return const Center(child: CircularProgressIndicator());
          }),
    );
  }
}
