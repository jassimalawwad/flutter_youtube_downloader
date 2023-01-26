// ignore_for_file: avoid_print

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import 'package:permission_handler/permission_handler.dart';

class DownloadYoutube extends StatefulWidget {
  const DownloadYoutube({super.key});

  @override
  State<DownloadYoutube> createState() => _DownloadYoutubeState();
}

class _DownloadYoutubeState extends State<DownloadYoutube> {
  final TextEditingController _urlTextFiledController = TextEditingController();
  String videoTitle = '';
  String videoThumbnail = '';
  String videoDuration = '';
  String videoChannelName = '';
  bool _downloading = false;
  double progress = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
                controller: _urlTextFiledController,
                onChanged: (val) {
                  setState(() {
                    getVideoInfo(val);
                  });
                },
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey.shade900,
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.grey.shade900, width: 1.0),
                    borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                  ),
                  border: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.grey.shade900, width: 1.0),
                    borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.grey.shade900, width: 1.0),
                    borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                  ),
                  hintText: 'Paste YouTube video URL',
                  hintStyle: const TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              //get image from url only if the url is not empty
              child: videoThumbnail != ''
                  ? Image.network(videoThumbnail)
                  : const SizedBox(),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Text(
                textAlign: TextAlign.center,
                videoTitle,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Text(videoChannelName,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold)),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: TextButton(
                style: TextButton.styleFrom(
                  minimumSize: const Size(150, 50),
                  backgroundColor: Colors.grey.shade800,
                ),
                onPressed: () {
                  downloadVideo(_urlTextFiledController.text);
                },
                child: const Text('Download',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold)),
              ),
            ),
            _downloading
                ? Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 10),
                    child: LinearProgressIndicator(
                      minHeight: 20,
                      value: progress,
                      backgroundColor: Colors.grey.shade800,
                      valueColor: const AlwaysStoppedAnimation<Color>(
                          Colors.greenAccent),
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }

  Future<String?> getDownloadPath() async {
    Directory? directory;
    try {
      if (Platform.isAndroid) {
        directory = Directory('/storage/emulated/0/Download');
      } else {
        directory = await getApplicationDocumentsDirectory();
      }
    } catch (e) {
      print(e);
    }
    return directory?.path;
  }

  //functions
  Future<void> getVideoInfo(url) async {
    var youtubeInfo = YoutubeExplode();
    var video = await youtubeInfo.videos.get(url);
    setState(() {
      videoTitle = video.title;
      videoThumbnail = video.thumbnails.highResUrl.toString();
      videoDuration = video.duration.toString();
      videoChannelName = video.author;
    });
  }

  Future<void> downloadVideo(id) async {
    var permission = await Permission.storage.request();
    if (permission.isGranted) {
      //download the video
      if (_urlTextFiledController.text != '') {
        setState(() => _downloading = true);
        var youtubeExplode = YoutubeExplode();
        //get the video metadata
        var video = await youtubeExplode.videos.get(id);
        var manifest =
            await youtubeExplode.videos.streamsClient.getManifest(id);
        var streams = manifest.muxed.withHighestBitrate();
        var audio = streams;
        var audioStream = youtubeExplode.videos.streamsClient.get(audio);

        //get the app directory

        var downloadPath = await getDownloadPath();
        var file = File('$downloadPath/${video.id}.mp4');
        //if file exists create a new file
        if (await file.exists()) {
          file = File('$downloadPath/${video.id}1.mp4');
        }

        //download the video
        var output = file.openWrite(mode: FileMode.writeOnlyAppend);
        var size = audio.size.totalBytes;
        var count = 0;

        await for (final data in audioStream) {
          //keep track of the download progress
          count += data.length;
          double val = ((count / size));
          var msg = '${video.title} Downloaded to $downloadPath';
          for (val; val == 1.0; val++) {
            // ignore: use_build_context_synchronously
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(msg)));
          }
          setState(() {
            progress = val;
            // Write the data to the file
            output.add(data);
          });
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text(
          'Please enter the url',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        )));
        setState(() {
          _downloading = false;
        });
      }
    } else {
      await Permission.storage.request();
    }
  }
}
