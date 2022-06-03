import 'package:flutter/material.dart';

class WatchlistPage extends StatelessWidget {
  const WatchlistPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          title: Text('Watchlist'),
          pinned: true,
          expandedHeight: 200,
        ),
      ],
    );
  }
}
