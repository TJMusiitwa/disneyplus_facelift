import 'package:disneyplus_facelift/pages/downloads.dart';
import 'package:disneyplus_facelift/pages/everything.dart';
import 'package:disneyplus_facelift/pages/movies.dart';
import 'package:disneyplus_facelift/pages/shows.dart';
import 'package:disneyplus_facelift/pages/watchlist.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NavDrawer extends StatelessWidget {
  const NavDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: MediaQuery.of(context).size.width,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ListTile(
              leading: const Icon(CupertinoIcons.square_stack_3d_up),
              title: const Text('Everything'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const EverythingPage()));
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
          ],
        ),
      ),
    );
  }
}
