import 'package:flutter/material.dart';
import 'package:virag/models/music.dart';
import 'package:virag/services/music_operations.dart';
class Search extends StatefulWidget {
  final Function(Music) onSongSelected;
  final Widget Function(Music?) miniPlayer;
  const Search({Key? key, required this.onSongSelected, required this.miniPlayer}) : super(key: key);
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  String _searchText = '';
  List<Music> _songs = MusicOperations.getMusic();

  List<Music> get _filteredSongs {
    return _songs.where((song) {
      return song.name.toLowerCase().contains(_searchText.toLowerCase());
    }).toList();
  }

  Widget createAppBar(String message) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      title: Text(
        message,
        style: TextStyle(color: Colors.white),
      ),
      actions: [
        Padding(
          padding: EdgeInsets.only(right: 10.0),
          child: Icon(Icons.search, color: Colors.white),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.blueGrey.shade300,
            Colors.black,
            Colors.black,
            Colors.black,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        children: [
          createAppBar('Search Section'),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  _searchText = value;
                });
              },
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Search songs',
                hintStyle: TextStyle(color: Colors.white),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(color: Colors.white),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(color: Colors.white),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(color: Colors.white),
                ),
                suffixIcon: Icon(Icons.search, color: Colors.white),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _filteredSongs.length,
              itemBuilder: (context, index) {
                final song = _filteredSongs[index];
                return ListTile(
                  title: Text(song.name, style: TextStyle(color: Colors.white)),
                  onTap: () {
                    widget.onSongSelected(song); // Call the callback function
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
