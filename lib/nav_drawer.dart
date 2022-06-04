import 'package:disneyplus_facelift/pages/downloads.dart';
import 'package:disneyplus_facelift/pages/everything.dart';
import 'package:disneyplus_facelift/pages/movies.dart';
import 'package:disneyplus_facelift/pages/shows.dart';
import 'package:disneyplus_facelift/pages/studio_pages/marvel_page.dart';
import 'package:disneyplus_facelift/pages/studio_pages/national_geographic.dart';
import 'package:disneyplus_facelift/pages/watchlist.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'pages/studio_pages/pixar_page.dart';
import 'pages/studio_pages/star_wars_page.dart';

class NavDrawer extends StatelessWidget {
  const NavDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: MediaQuery.of(context).size.width,
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ListTile(
                leading: const Icon(CupertinoIcons.square_stack_3d_up),
                title: const Text('Everything'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const EverythingPage()));
                },
              ),
              ListTile(
                leading: const Icon(CupertinoIcons.film),
                title: const Text('Movies'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const MoviesPage()));
                },
              ),
              ListTile(
                leading: const Icon(CupertinoIcons.tv),
                title: const Text('Shows'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const ShowsPage()));
                },
              ),
              ListTile(
                leading: const Icon(CupertinoIcons.checkmark),
                title: const Text('Watchlist'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const WatchlistPage()));
                },
              ),
              ListTile(
                leading: const Icon(CupertinoIcons.arrow_down),
                title: const Text('Downloads'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const DownloadsPage()));
                },
              ),
              const ListTile(
                title: Text('Disney'),
              ),
              ListTile(
                title: const Text('Marvel'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const MarvelPage()));
                },
              ),
              ListTile(
                title: const Text('Star Wars'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const StarWarsPage()));
                },
              ),
              ListTile(
                title: const Text('Pixar'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const PixarPage()));
                },
              ),
              ListTile(
                title: const Text('National Geographic'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const NationalGeographicPage()));
                },
              ),
              const ListTile(
                title: Text('Disney+ Originals'),
              ),
              const ListTile(
                title: Text('Categories'),
              ),
              const ListTile(
                title: Text('Coming Soon'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
