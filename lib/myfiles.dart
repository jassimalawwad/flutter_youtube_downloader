import 'package:flutter/material.dart';

class Myflies extends StatefulWidget {
  const Myflies({Key? key}) : super(key: key);

  @override
  State<Myflies> createState() => _MyfilesState();
}

class _MyfilesState extends State<Myflies> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                ),
                child: const Text(
                  'Under Development',
                  style: TextStyle(fontSize: 30, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
