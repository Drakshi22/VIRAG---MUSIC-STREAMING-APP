import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:virag/models/music.dart';
import 'package:virag/screens/home.dart';
import 'package:virag/screens/search.dart';
import 'package:virag/screens/yourlibrary.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String audioasset = "assets/";
  AudioPlayer _audioPlayer = AudioPlayer(); 
  var Tabs = [];
  int currentTabIndex = 0;
  bool isPlaying = false;
  Music? music;
  List<Music> library = [];

  Widget miniPlayer(Music? music, {bool stop = false}) {
    this.music = music;

    if (music == null) {
      return SizedBox();
    }
    if (stop) {
      isPlaying = false;
      _audioPlayer.stop();
    }
    setState(() {});
    Size deviceSize = MediaQuery.of(context).size;
    return AnimatedContainer(
      duration: const Duration(microseconds: 500),
      color: Colors.blueGrey,
      width: deviceSize.width,
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.network(
            music.image,
            fit: BoxFit.cover,
          ),
          Text(
            music.name,
            style: TextStyle(color: Colors.white),
          ),
          Row(
            children: [
              IconButton(
                onPressed: () {
                  int currentIndex = library.indexOf(this.music!);
                  if (currentIndex > 0) {
                    Music previousMusic = library[currentIndex - 1];
                    playSong(previousMusic);
                  }
                },
                icon: Icon(Icons.skip_previous, color: Colors.white),
              ),
              IconButton(
                onPressed: () async {
                  isPlaying = !isPlaying;
                  if (isPlaying) {
                    await _audioPlayer.play(UrlSource(music.audioURL));
                  } else {
                    await _audioPlayer.pause();
                  }
                  setState(() {});
                },
                icon: isPlaying
                    ? Icon(Icons.pause, color: Colors.white)
                    : Icon(Icons.play_arrow, color: Colors.white),
              ),
              IconButton(
                onPressed: () {
                  int currentIndex = library.indexOf(this.music!);
                  if (currentIndex < library.length - 1) {
                    _audioPlayer.pause();
                    Music nextMusic = library[currentIndex + 1];
                    playSong(nextMusic);
                  }
                },
                icon: Icon(Icons.skip_next, color: Colors.white),
              ),
              IconButton(
                  onPressed: () async {
                    String? filePath = await downloadSong(music.audioURL);
                    if (filePath != null) {
                      print('Song downloaded successfully: $filePath');
                    } else {
                         print('Failed to download song.');
                      }
                    },

                icon: Icon(Icons.file_download, color: Colors.white),
              ),
              IconButton(
                onPressed: () {
                  addToLibrary(music);
                },
                icon: Icon(Icons.library_add, color: Colors.white),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void addToLibrary(Music music) {
    setState(() {
      library.add(music);
    });
  }
  Future<String?> downloadSong(String audioURL) async {
  try {
    final response = await http.get(Uri.parse(audioURL));

    if (response.statusCode == 200) {
      Directory tempDir = await getTemporaryDirectory();
      String tempPath = tempDir.path;
      String fileName = DateTime.now().millisecondsSinceEpoch.toString() +
          audioURL.split('/').last;

      // Save the downloaded file in the temporary directory
      File file = File('$tempPath/$fileName');
      await file.writeAsBytes(response.bodyBytes);

      // Return the file path
      return file.path;
    } else {
      print('Failed to download song: ${response.statusCode}');
      return null;
    }
  } catch (e) {
    print('Error downloading song: $e');
    return null;
  }
}

  @override
  void initState() {
    super.initState();
    library = [];
    Tabs = [
      Home(miniPlayer),
      Search(onSongSelected: playSong, miniPlayer: miniPlayer),
      YourLibrary(library),
    ];
  }

  void playSong(Music song) async {
    setState(() {
      music = song;
      isPlaying = true;
    });
    await _audioPlayer.play(song.audioURL as Source);
    print('Playing song: ${song.name}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Tabs[currentTabIndex],
      backgroundColor: Colors.black,
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          miniPlayer(music),
          BottomNavigationBar(
            currentIndex: currentTabIndex,
            onTap: (currentIndex) {
              print("Current Index is $currentIndex");
              currentTabIndex = currentIndex;
              setState(() {});
            },
            selectedLabelStyle: TextStyle(color: Colors.white),
            backgroundColor: Colors.black45,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                  color: Colors.white,
                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.search,
                  color: Colors.white,
                ),
                label: 'Search',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.library_books,
                  color: Colors.white,
                ),
                label: 'Library',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
