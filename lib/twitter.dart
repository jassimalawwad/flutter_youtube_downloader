import 'package:flutter/material.dart';

class Twitter extends StatefulWidget {
  const Twitter({Key? key}) : super(key: key);

  @override
  State<Twitter> createState() => _TwitterState();
}

class _TwitterState extends State<Twitter> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: const Text('This is Twitter page'),
    );
  }
}
