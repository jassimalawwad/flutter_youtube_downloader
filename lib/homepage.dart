import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'download_youtube.dart';
import 'myfiles.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomePage extends StatefulWidget {
  //hide android navigation bar
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  final tabs = [
    Center(
      child: Column(
        children: [
          const Spacer(),
          RichText(
            text: const TextSpan(
                text: 'No Ads, \nNo Watermarks, \nJust',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                    fontFamily: 'Commissioner'),
                children: [
                  TextSpan(
                    text: ' Download!',
                    style: TextStyle(
                        color: Colors.greenAccent,
                        fontSize: 26,
                        fontFamily: 'Commissioner'),
                  ),
                ]),
          ),
          const Spacer(),
        ],
      ),
    ),
    const Center(child: DownloadYoutube()),
    const Center(child: Myflies()),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: Colors.black,
        //align title to center

        title: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 20),
          child: Text('Youtube downloader',
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
              GButton(icon: FontAwesomeIcons.youtube, text: 'Youtube'),
              GButton(icon: FontAwesomeIcons.download, text: 'My Files'),
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
