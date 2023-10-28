import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:smart_radio/models/song.dart';
import 'dart:async';

import 'package:smart_radio/services/FirebaseUtil.dart';

String greeting = '';
List<Song> songsList = [];

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
    _timer = Timer.periodic(const Duration(seconds: 10), (Timer t) => refreshPlaylist());
    refreshPlaylist();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void refreshPlaylist() async {
    Map<String, dynamic> data = await fetchPlaylist();
    setState(() {
      // read the json file from the server
      greeting = data['greeting'];

      var songs = data['songs'];
      songsList.clear();
      // loop trough the songs and create a list of Song objects
      for (var song in songs) {
        songsList.add(Song(
          title: song['title'],
          artist: song['artist'],
          length: Duration(seconds: int.parse(song['duration'])),
          url: song['url'],
        ));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: songsList.length,
      itemBuilder: (context, index) {
        final song = songsList[index];

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
