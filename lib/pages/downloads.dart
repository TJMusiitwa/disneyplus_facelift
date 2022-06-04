import 'package:disneyplus_facelift/nav_drawer.dart';
import 'package:flutter/material.dart';

class DownloadsPage extends StatelessWidget {
  const DownloadsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            flexibleSpace: FlexibleSpaceBar(
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Downloads',
                    style: Theme.of(context).textTheme.headline5!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  Text('0 Videos • 0 GB',
                      style: Theme.of(context).textTheme.labelSmall),
                ],
              ),
              centerTitle: false,
              titlePadding: const EdgeInsets.only(left: 10, bottom: 20),
            ),
            pinned: true,
            expandedHeight: 200,
          ),
        ],
      ),
      drawer: const NavDrawer(),
    );
  }
}
