import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:tmdb_dart/tmdb_dart.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class MovieDetails extends StatelessWidget {
  const MovieDetails({Key? key, required this.movieId}) : super(key: key);

  final int movieId;

  @override
  Widget build(BuildContext context) {
    var tmdb = GetIt.I<TmdbService>();

    var movieDetails = tmdb.movie.getDetails(movieId,
        appendSettings: const AppendSettings(
          includeCredits: true,
          includeImages: true,
          includeSimilarContent: true,
          includeRecommendations: true,
          includeVideos: true,
        ));
    return Scaffold(
      //appBar: AppBar(),
      body: FutureBuilder<Movie>(
        future: movieDetails,
        builder: (BuildContext context, AsyncSnapshot<Movie> snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          return SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      height: 500,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        ),
                      ),
                      child: ClipRRect(
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20),
                          ),
                          child: snapshot.data!.posterPath!.isEmpty
                              ? CachedNetworkImage(
                                  imageUrl: snapshot.data!.backdropPath!,
                                  fit: BoxFit.cover,
                                  alignment: Alignment.topCenter,
                                )
                              : snapshot.data!.backdropPath!.isEmpty
                                  ? Image.asset('assets/icon.png')
                                  : CachedNetworkImage(
                                      imageUrl: snapshot.data!.posterPath!,
                                      fit: BoxFit.cover,
                                      alignment: Alignment.topCenter,
                                    )),
                    ),
                    const Positioned(
                        top: kToolbarHeight, right: 10, child: CloseButton()),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Center(
                    child: Text(
                        '${snapshot.data!.releaseDate!.year} • ${snapshot.data!.runtime} mins',
                        style: Theme.of(context).textTheme.subtitle2,
                        textAlign: TextAlign.center),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.grey.shade900),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Flexible(
                            fit: FlexFit.tight,
                            child: Text(
                              snapshot.data!.title,
                              softWrap: true,
                              overflow: TextOverflow.clip,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline5!
                                  .copyWith(fontWeight: FontWeight.bold),
                            ),
                          ),
                          Text(
                            ' | ',
                            style: Theme.of(context).textTheme.headline5,
                          ),
                          Text(
                            snapshot.data!.voteAverage.toStringAsFixed(1),
                            style: Theme.of(context).textTheme.headline5,
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: Text(
                          snapshot.data!.overview!,
                          style: Theme.of(context).textTheme.bodyText2,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Center(
                        child: Text(
                          snapshot.data!.genres.map((e) => e.name).join(','),
                          style: Theme.of(context).textTheme.subtitle2,
                        ),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        height: 230,
                        child: ListView.separated(
                          itemCount: snapshot.data!.videos.length,
                          scrollDirection: Axis.horizontal,
                          clipBehavior: Clip.antiAlias,
                          itemBuilder: (BuildContext context, int index) {
                            var video = snapshot.data?.videos[index];
                            return Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: YoutubePlayerBuilder(
                                  player: YoutubePlayer(
                                    controller: YoutubePlayerController(
                                      initialVideoId: video!.key!,
                                      flags: const YoutubePlayerFlags(
                                          autoPlay: false,
                                          mute: false,
                                          controlsVisibleAtStart: true,
                                          disableDragSeek: true),
                                    ),
                                    progressColors: const ProgressBarColors(
                                      backgroundColor: Colors.deepPurple,
                                      playedColor: Colors.lightBlue,
                                      handleColor: Colors.deepPurpleAccent,
                                    ),
                                  ),
                                  builder: (context, player) => player,
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) =>
                              const SizedBox(width: 10),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Director',
                                style: Theme.of(context).textTheme.labelLarge,
                              ),
                              Text(
                                snapshot.data?.credits?.crew
                                        .firstWhere((element) =>
                                            element.job == 'Director')
                                        .name ??
                                    'N/A',
                                style: Theme.of(context).textTheme.subtitle1,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Executive Producer',
                                style: Theme.of(context).textTheme.labelLarge,
                              ),
                              Text(
                                snapshot.data?.credits?.crew
                                        .firstWhere((element) =>
                                            element.job == 'Executive Producer')
                                        .name ??
                                    'N/A',
                                style: Theme.of(context).textTheme.subtitle1,
                              ),
                            ],
                          ),
                          Text(
                            snapshot.data?.productionCompanies
                                    .map((e) => e.name)
                                    .join('\n') ??
                                '',
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      Text(
                        'Starring',
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                      Text(
                        snapshot.data?.credits?.cast
                                .take(10)
                                .map((element) => element.name)
                                .join(', ') ??
                            'No Cast',
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                DecoratedBox(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.grey.shade900),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(30),
                        child: Center(
                          child: Text(
                            'More Like This',
                            style: Theme.of(context)
                                .textTheme
                                .headline5!
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      GridView.builder(
                        shrinkWrap: true,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                childAspectRatio: 0.6,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10),
                        primary: false,
                        padding: const EdgeInsets.all(10),
                        itemCount: snapshot.data!.recommendations.length,
                        itemBuilder: (BuildContext context, int index) {
                          return SizedBox(
                            height: 220,
                            width: 100,
                            child: DecoratedBox(
                                decoration: BoxDecoration(
                              image: DecorationImage(
                                image: CachedNetworkImageProvider(
                                  snapshot
                                      .data!.recommendations[index].posterPath!,
                                ),
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            )),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
