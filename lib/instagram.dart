import 'package:flutter/material.dart';



class Instagram extends StatefulWidget {
  const Instagram({Key? key}) : super(key: key);

  @override
  State<Instagram> createState() => _InstagramState();
}

class _InstagramState extends State<Instagram> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children:  [
        Row(
          children: const [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Text('Instagram', style: TextStyle(fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold),),
            ),
          ],
        ),
      ],
    );
  }
}