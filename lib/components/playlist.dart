import 'package:flutter/material.dart';
import 'package:smart_radio/models/song.dart';
import 'dart:async';

class Playlist extends StatefulWidget {
  const Playlist({Key? key}) : super(key: key);

  @override
  PlaylistState createState() => PlaylistState();
}

class PlaylistState extends State<Playlist> {
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 30), (Timer t) => refreshPlaylist());
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  // Hard-coded playlist values
  List<Song> playlist = [
    Song(
      title: 'Sacrifice',
      artist: 'Simon & Garfunkel',
      length: const Duration(minutes: 3, seconds: 50),
    ),
    Song(
      title: 'Imagine',
      artist: 'John Lennon',
      length: const Duration(minutes: 3, seconds: 39),
    ),
    Song(
      title: 'What a Wonderful World',
      artist: 'Louis Armstrong',
      length: const Duration(minutes: 2, seconds: 39),
    ),
  ];

  void refreshPlaylist() async {
    setState(() {
      playlist = [
        Song(
          title: 'Ten Thousand Promises',
          artist: 'Simon & Garfunkel',
          length: const Duration(minutes: 3, seconds: 50),
        ),
        Song(
          title: 'Holy Cow',
          artist: 'John Lennon',
          length: const Duration(minutes: 3, seconds: 39),
        ),
        Song(
          title: 'Frozen',
          artist: 'Louis Armstrong',
          length: const Duration(minutes: 2, seconds: 39),
        ),
        Song(
          title: 'Sacrifice',
          artist: 'Simon & Garfunkel',
          length: const Duration(minutes: 3, seconds: 50),
        ),
        Song(
          title: 'Imagine',
          artist: 'John Lennon',
          length: const Duration(minutes: 3, seconds: 39),
        ),
        Song(
          title: 'What a Wonderful World',
          artist: 'Louis Armstrong',
          length: const Duration(minutes: 2, seconds: 39),
        ),
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: playlist.length,
      itemBuilder: (context, index) {
        final song = playlist[index];

        return ListTile(
          leading: const Icon(Icons.play_arrow),
          iconColor: Colors.teal.shade300,
          title: Text(song.title),
          subtitle: Text(song.artist),
          trailing: Text(song.length.toString().replaceAll('.000000', '').replaceAll('0:', '')),
        );
      },
    );
  }
}
