import 'package:disneyplus_facelift/nav_drawer.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:tmdb_dart/tmdb_dart.dart';

class EverythingPage extends StatelessWidget {
  const EverythingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var tmdb = GetIt.I<TmdbService>();
    var trending = tmdb.tv.discover();

    //var backdropPath = trending['backdrop_path'];
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            expandedHeight: 250,
            actions: const [
              CircleAvatar(
                backgroundImage: AssetImage('assets/simba.jpg'),
                radius: 30,
              )
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                'https://image.tmdb.org/t/p/w300/qJRB789ceLryrLvOKrZqLKr2CGf.jpg',
                fit: BoxFit.cover,
                alignment: Alignment.topCenter,
                height: 400,
              ),
              stretchModes: const [StretchMode.blurBackground],
              centerTitle: false,
              title: const Text('Everything'),
            ),
          ),
        ],
      ),
      drawer: const NavDrawer(),
    );
  }
}
