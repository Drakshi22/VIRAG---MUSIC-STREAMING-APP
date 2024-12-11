import 'package:flutter/material.dart';
import 'package:virag/models/music.dart';
import 'package:virag/services/music_operations.dart';

class YourLibrary extends StatefulWidget {
  final List<Music> library;
  YourLibrary(this.library);

  @override
  _YourLibraryState createState() => _YourLibraryState();
}

class _YourLibraryState extends State<YourLibrary> {
  List<Music> allMusic = [];

  @override
  void initState() {
    super.initState();
    // ignore: unnecessary_null_comparison
    if (widget.library.isEmpty || widget.library == null) {
      allMusic = MusicOperations.getMusic() ?? [];
    } else {
      allMusic = widget.library;
    }
  }
  void clearLibrary() {
    setState(() {
      allMusic = [];
    });
  }
  void addToLibrary(Music music) {
    setState(() {
      if (!allMusic.contains(music)) {
        allMusic.add(music);
      }
    });
  }
  void removeFromLibrary(Music music) {
    setState(() {
      allMusic.remove(music);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        title: Text('Your Library', style: TextStyle(color: Colors.white)),
       backgroundColor: Color.fromARGB(255, 136, 157, 168),
      ),
      body: Container(
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
        child: ListView.builder(
          itemCount: allMusic.length,
          itemBuilder: (context, index) {
            Music music = allMusic[index];
            return ListTile(
              leading: Image.network(music.image),
              title: Text(
                music.name,
                style: TextStyle(color: Colors.white), 
              ),
              onTap: () {
              },
              trailing: IconButton(
                icon: Icon(Icons.delete,color: Colors.white,),
                onPressed: () {
                  removeFromLibrary(music);
                },
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: clearLibrary,
        tooltip: 'Clear Library',
        child: Icon(Icons.delete),
      ),
    );
  }
}
