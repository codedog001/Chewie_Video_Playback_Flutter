//Link: https://www.youtube.com/watch?v=XSn5EwWBG-4

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Video Player',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  File videoFile;
  final picker = ImagePicker();
  final List<DeviceOrientation> deviceOrientationsOnEnterFullScreen = [
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight
  ];

  _takeVid() async {
    final pickedFile = await picker.getVideo(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        videoFile = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Video Player'),
      ),
      body: Center(
        child: ListView(
          children: [
            Column(
              children: [
                SizedBox(
                  height: 50,
                ),

                //Video
                Container(
                  color: Colors.brown,
                  height: MediaQuery.of(context).size.height * (40 / 100),
                  width: MediaQuery.of(context).size.height * (100 / 100),
                  child: videoFile == null
                      ? Center(
                          child: Icon(
                            Icons.videocam,
                            color: Colors.red,
                            size: 50,
                          ),
                        )
                      : Expanded(
                          child: mounted
                              ? Chewie(
                                  controller: ChewieController(
                                    videoPlayerController:
                                        VideoPlayerController.file(videoFile),
                                    aspectRatio: 16 / 9,
                                    autoPlay: true,
                                    allowPlaybackSpeedChanging: true,
                                    looping: true,
                                    deviceOrientationsOnEnterFullScreen:
                                        deviceOrientationsOnEnterFullScreen,
                                  ),
                                )
                              : Container(),
                        ),
                ),

                ElevatedButton.icon(
                  onPressed: () {
                    _takeVid();
                  },
                  icon: Icon(Icons.video_call),
                  label: Text('Pick it'),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
