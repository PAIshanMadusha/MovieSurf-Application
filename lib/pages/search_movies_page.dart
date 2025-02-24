import 'package:flutter/material.dart';

class SearchMoviesPage extends StatefulWidget {
  const SearchMoviesPage({super.key});

  @override
  State<SearchMoviesPage> createState() => _SearchMoviesPageState();
}

class _SearchMoviesPageState extends State<SearchMoviesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text("Search Movies")));
  }
}
