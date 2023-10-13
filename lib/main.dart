import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:smart_radio/components/playlist.dart';

void main() {
  runApp(const MyApp());
}

List<String> songsList = [
  "https://songlanka.sgp1.digitaloceanspaces.com/mp3/Mahada-Premadare-Cover-Ishara-Akalanka-www.song.lk.mp3",
  "https://songlanka.sgp1.digitaloceanspaces.com/mp3/Kaviya-Oba-Reliving-Prime-Classics-Umara-Sinhawansa-www.song.lk.mp3",
  "https://songlanka.sgp1.digitaloceanspaces.com/mp3/Supem-Hangum-Oben-Epa-Cover-Naduni-Yameesha-www.song.lk.mp3",
];

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Radio',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const SmartRadioHome(title: 'Smart Radio'),
    );
  }
}

class SmartRadioHome extends StatefulWidget {
  const SmartRadioHome({super.key, required this.title});

  final String title;

  @override
  State<SmartRadioHome> createState() => _SmartRadioHomeState();
}

class _SmartRadioHomeState extends State<SmartRadioHome> {
  AudioPlayer player = AudioPlayer();
  static const Playlist playlist = Playlist();

  void _playSong() async {
    await player.stop();
    await player.dispose();

    player = AudioPlayer();
    await player.play(UrlSource(songsList[0]));
  }

  void _prevSong() async {
    await player.stop();
    await player.dispose();

    player = AudioPlayer();
    await player.play(UrlSource(songsList[1]));
  }

  void _nextSong() async {
    await player.stop();
    await player.dispose();

    player = AudioPlayer();
    await player.play(UrlSource(songsList[2]));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.teal.shade800,
            foregroundColor: Colors.white,
          ),
        ),
        home: Scaffold(
      appBar: AppBar(
        // backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Expanded(
                child: Text(
                'Good Morning ⛅',
                style: TextStyle(fontSize: 25, color: Colors.teal),
            )),
            const Row(
              children: <Widget>[
                Expanded(
                  child: SizedBox(
                    height: 490.0,
                    child: playlist,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextButton(
                  onPressed: _prevSong,
                  style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all<Color>(Colors.teal.shade600),
                  ),
                  child: const Icon(
                    Icons.skip_previous_outlined,
                    size: 72.0,
                  ),
                ),
                TextButton(
                  onPressed: _playSong,
                  style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all<Color>(Colors.teal.shade600),
                  ),
                  child: const Icon(
                    Icons.play_circle_outline_rounded,
                    size: 96.0,
                  ),
                ),
                TextButton(
                  onPressed: _nextSong,
                  style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all<Color>(Colors.teal.shade600),
                  ),
                  child: const Icon(
                    Icons.skip_next_outlined,
                    size: 72.0,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ));
  }
}
