import 'package:flutter/material.dart';

class DownloadsPage extends StatelessWidget {
  const DownloadsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          title: Text('Downloads'),
          pinned: true,
          expandedHeight: 200,
        ),
      ],
    );
  }
}
