import 'package:flutter/material.dart';

class NowPlayingPage extends StatefulWidget {
  const NowPlayingPage({super.key});

  @override
  State<NowPlayingPage> createState() => _NowPlayingPageState();
}

class _NowPlayingPageState extends State<NowPlayingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text("Now Playing"),),);
  }
}