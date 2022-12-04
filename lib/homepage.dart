import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:the_real_downloader/download_youtube.dart';
import 'package:the_real_downloader/instagram.dart';
import 'package:the_real_downloader/twitter.dart';

class HomePage extends StatefulWidget {
  //hide android navigation bar
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  final tabs = [
    // ignore: prefer_const_constructors
    Padding(
      padding: const EdgeInsets.all(20.0),
      child: const Center(
        child: Text(
            'No Ads, \nNo Watermarks, \nNo Bullshit, \n\nJust Download!',
            style: TextStyle(
                color: Colors.white, fontSize: 40, fontFamily: 'Commissioner')),
      ),
    ),
    const Center(child: DownloadYoutube()),
    const Center(child: Instagram()),
    const Center(child: Twitter())
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      appBar: AppBar(
        toolbarHeight: 150,
        backgroundColor: Colors.black,


        title: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 100),
          child: Text('The real downloader',
              style: TextStyle(
                  letterSpacing: 1,
                  color: Colors.greenAccent,
                  fontSize: 27,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Commissioner')),
        ),
      ),
      body: Container(
        child: tabs[_currentIndex],
      ),
      bottomNavigationBar: Container(
        color: Colors.black,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GNav(
            selectedIndex: _currentIndex,
            gap: 8,
            backgroundColor: Colors.black,
            color: Colors.white,
            activeColor: Colors.white,
            tabBackgroundColor: Colors.grey.shade800,
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            tabs: const [
              GButton(icon: Icons.home, text: 'Home'),
              GButton(icon: Icons.personal_video, text: 'Youtube'),
              GButton(icon: Icons.favorite_border, text: 'Instagram'),
              GButton(icon: Icons.stay_primary_portrait, text: 'Twitter'),
            ],
            onTabChange: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
        ),
      ),
    );
  }
}
