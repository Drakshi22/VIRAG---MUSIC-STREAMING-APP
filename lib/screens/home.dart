// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, missing_return, must_be_immutable, prefer_final_fields, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:virag/models/Category.dart';
import 'package:virag/models/music.dart';
import 'package:virag/screens/setting.dart';
import 'package:virag/services/Catergory_operations.dart';
import 'package:virag/services/music_operations.dart';

class Home extends StatelessWidget {
  Function _miniPlayer;
  Home(this._miniPlayer); 
  Widget createCategory(Category category) {
    return Container(
      color: Colors.blueGrey.shade400,
      child: Row(children: [
        Image.network(
          category.imageUrl,
          fit: BoxFit.cover,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Text(
            category.name,
            style: TextStyle(color: Colors.white),
          ),
        )
      ]),
    );
  }

  List<Widget> createListOfCatergories() {
    List<Category> categoryList =
        CategoryOperations.getCategories(); //recieve data
    //convert data to widget using map function
    List<Widget> categories = categoryList
        .map((Category category) => createCategory(category))
        .toList();
    return categories;
  }

  //create widget after making CreateMusicList
  Widget createMusic(Music music) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 200,
            width: 200,
            child: InkWell(
              onTap: () {
                _miniPlayer(music);
              },
              child: Image.network(
                music.image,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Text(
            music.name,
            style: TextStyle(color: Colors.white),
          ),
          Text(
            music.desc,
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget createMusicList(String label) {
    List<Music> musicList = MusicOperations.getMusic();
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Container(
            height: 300, //after running the code

            child: ListView.builder(
                // padding: EdgeInsets.all(5.0),
                scrollDirection: Axis.horizontal, //after running the code
                itemBuilder: (context, index) {
                  return createMusic(musicList[index]);
                },
                itemCount: musicList.length),
          ),
        ],
      ),
    );
  }

  Widget createGrid() {
    return Container(
      padding: const EdgeInsets.all(10),
      height: 285,
      child: GridView.count(
        childAspectRatio: 5 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        crossAxisCount: 2,
        children: createListOfCatergories(),
      ),
    );
  }

//Create widget after wrinting "Good Morning"
  Widget createAppBar(BuildContext context, String message) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      title: Text(message, style: TextStyle(color: Colors.white),),
      actions: [
      Padding(
        padding: EdgeInsets.only(right: 10.0),
        child: IconButton(
          icon: Icon(Icons.settings,color: Colors.white,),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SettingsPage()),
            );
          },
        ),
      ),
    ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SafeArea(
          child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
          colors: [
            Colors.blueGrey.shade300,
            Colors.black,
            Colors.black,
            Colors.black
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        )),
        child: Column(
          children: [
            createAppBar(context, 'Hello !'),
            SizedBox(
              height: 5,
            ),
            createGrid(),
            createMusicList('Made for you'),
            createMusicList('Popular PlayList')
          ],
        ),
      )),
    );
  }
}