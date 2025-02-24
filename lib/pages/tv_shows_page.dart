import 'package:flutter/material.dart';

class TvShowsPage extends StatefulWidget {
  const TvShowsPage({super.key});

  @override
  State<TvShowsPage> createState() => _TvShowsPageState();
}

class _TvShowsPageState extends State<TvShowsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text("Tv Shows")));
  }
}
