import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:tmdb_dart/tmdb_dart.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class ShowDetails extends StatelessWidget {
  const ShowDetails({Key? key, required this.showId}) : super(key: key);
  final int showId;

  @override
  Widget build(BuildContext context) {
    var tmdb = GetIt.I<TmdbService>();

    Future<TvShow> showDetails = tmdb.tv.getDetails(showId,
        appendSettings: const AppendSettings(
          includeCredits: true,
          includeImages: true,
          includeSimilarContent: true,
          includeRecommendations: true,
          includeVideos: true,
        ));

    var seasonDetails = tmdb.tv.getSeasonDetails(showId,
        appendSettings: const AppendSettings(
          includeImages: true,
          includeReleaseDates: true,
        ));
    return Scaffold(
      //appBar: AppBar(),
      body: FutureBuilder<TvShow>(
        future: showDetails,
        builder: (BuildContext context, AsyncSnapshot<TvShow?> snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                    Positioned(
                      right: 10,
                      bottom: 20,
                      child: IconButton(
                        icon: const Icon(Icons.more_horiz_outlined),
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30),
                                topRight: Radius.circular(30),
                              ),
                            ),
                            barrierColor: Colors.black87,
                            builder: (_) {
                              return BottomSheet(
                                  onClosing: (() => print('closing')),
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(30),
                                      topRight: Radius.circular(30),
                                    ),
                                  ),
                                  builder: (_) {
                                    return ClipRRect(
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(30),
                                        topRight: Radius.circular(30),
                                      ),
                                      child: Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.5,
                                        padding: const EdgeInsets.all(15),
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                const Spacer(),
                                                Center(
                                                    child: Text(
                                                        snapshot.data!.name)),
                                                const Spacer(),
                                                Align(
                                                  alignment: Alignment.topRight,
                                                  child: IconButton(
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                      icon: const Icon(
                                                          Icons.close_rounded)),
                                                )
                                              ],
                                            ),
                                            ListTile(
                                              leading: const Icon(
                                                  Icons.arrow_downward),
                                              title: const Text('Download'),
                                              onTap: () {
                                                Navigator.pop(context);
                                              },
                                            ),
                                            ListTile(
                                              leading: const Icon(
                                                  Icons.share_outlined),
                                              title: const Text('Share'),
                                              onTap: () {
                                                Navigator.pop(context);
                                              },
                                            ),
                                            ListTile(
                                              leading: const Icon(Icons.search),
                                              title:
                                                  const Text('More like this'),
                                              onTap: () {
                                                Navigator.pop(context);
                                              },
                                            ),
                                            ListTile(
                                              leading: const Icon(Icons.cast),
                                              title: const Text('Cast on TV'),
                                              onTap: () {
                                                Navigator.pop(context);
                                              },
                                            ),
                                            const Spacer(),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                IconButton(
                                                    onPressed: () {},
                                                    icon: const Icon(
                                                        Icons.favorite_border)),
                                                IconButton(
                                                    onPressed: () {},
                                                    icon: const Icon(
                                                        Icons.thumb_down)),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  });
                            },
                          );
                        },
                      ),
                    )
                  ],
                ),

                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Center(
                    child: Text(
                        '${snapshot.data!.firstAirDate!.year} • ${snapshot.data!.numOfSeasons} Season(s) • ${snapshot.data!.numOfEpisodes} Episodes • ${snapshot.data!.type!}',
                        style: Theme.of(context).textTheme.subtitle2,
                        textAlign: TextAlign.center),
                  ),
                ),
                // Container(
                //   padding: const EdgeInsets.all(15),
                //   decoration: BoxDecoration(
                //       borderRadius: BorderRadius.circular(30),
                //       color: Colors.grey.shade900),
                //   child: FutureBuilder(
                //     future: seasonDetails,
                //     builder: (BuildContext context,
                //         AsyncSnapshot<TvSeason?> snapshot) {
                //       return ListView.builder(
                //         primary: false,
                //         shrinkWrap: true,
                //         itemCount: snapshot.data!.episodes.length,
                //         itemBuilder: (BuildContext context, int index) {
                //           var eps = snapshot.data!.episodes[index];
                //           return ListTile(
                //             title: Text(
                //                 'S${eps.seasonNumber} • Episode ${eps.episodeNumber} min'),
                //             //subtitle: Text(snapshot.data?[index].name ?? ''),
                //           );
                //         },
                //       );
                //     },
                //   ),
                // ),
                Center(
                  child: Text(
                    snapshot.data!.genres.map((e) => e.name).join(','),
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.grey.shade900),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Center(
                          child: Text(
                            'Trailers & Info',
                            style: Theme.of(context)
                                .textTheme
                                .headline5!
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        width: double.infinity,
                        height: 230,
                        child: ListView.separated(
                          itemCount: snapshot.data!.videos.length,
                          scrollDirection: Axis.horizontal,
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
                                          //showLiveFullscreenButton: false,
                                          disableDragSeek: true),
                                    ),
                                    progressColors: const ProgressBarColors(
                                      backgroundColor: Colors.deepPurple,
                                      playedColor: Colors.lightBlue,
                                      //handleColor: Colors.deepPurpleAccent,
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
                                'Creator',
                                style: Theme.of(context).textTheme.labelLarge,
                              ),
                              Text(
                                snapshot.data?.createdBy.first.name ?? '',
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
                      const SizedBox(height: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Executive Producer',
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                          Text(
                            snapshot.data?.credits?.crew
                                    .firstWhere((element) =>
                                        element.job == 'Director' ||
                                        element.job == 'Executive Producer')
                                    .name ??
                                'No Director',
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
