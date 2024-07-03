

import 'dart:async';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:palestine_archive/auth/provider.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';


class webVideoPlayerScreen extends StatefulWidget {


  @override
  State<webVideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<webVideoPlayerScreen> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();

    _controller = VideoPlayerController.network(
        'http://127.0.0.1:3000/uploads/'+ Provider.of<AppProvider>(context,listen: false).selectedVideo.video_path

      /*'lib/node/uploads/'+ Provider.of<AppProvider>(context,listen: false).selectedVideo.video_path.split('/')[ Provider.of<AppProvider>
          (context,listen: false).selectedVideo.video_path.split('/').length-1]
*/


    );

    // Initialize the controller and store the Future for later use.
    _initializeVideoPlayerFuture = _controller.initialize();

    // Use the controller to loop the video.
    _controller.setLooping(true);
  }

  @override
  void dispose() {
    // Ensure disposing of the VideoPlayerController to free up resources.

    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('View Video'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 5,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            width: MediaQuery.of(context).size.width * 0.5,
            child: Column(
                children: [

                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height*0.6,
                    child: FutureBuilder(
                      future: _initializeVideoPlayerFuture,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          // If the VideoPlayerController has finished initialization, use
                          // the data it provides to limit the aspect ratio of the video.
                          return AspectRatio(
                            aspectRatio: _controller.value.aspectRatio,
                            // Use the VideoPlayer widget to display the video.
                            child: VideoPlayer(_controller),
                          );
                        } else {
                          // If the VideoPlayerController is still initializing, show a
                          // loading spinner.
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      },
                    ),
                  ),
                  const SizedBox(height: 20),


                  Row(

                    children: [

                      Expanded(child: SizedBox()),

                      Container(
                        alignment: Alignment.topLeft,
                        margin: EdgeInsets.only( top: 5),
                        child: Expanded(
                          child:Icon(Icons.remove_red_eye_rounded, color: Color(0xffeeac07),),

                        ),
                      ),

                      Container(
                          alignment: Alignment.topLeft,
                          margin: EdgeInsets.only( top: 5),
                          child:Text(
                            "عدد المشاهدات :${Provider.of<AppProvider>(context).selectedVideo.views}",
                            style: TextStyle(
                                fontSize: 14,

                                color: Color(0xFF00416b)),
                          )
                      )
                    ],
                  ),
                  const SizedBox(height: 20),
                  SizedBox(

                    child:
                    Text(Provider.of<AppProvider>(context).selectedVideo.description,
                      // maxLines: 2,
                      style: TextStyle(
                          color: Color(0xFF00416b),
                          fontSize: 20,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ]),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xffeeac07),
        onPressed: () {
          // Wrap the play or pause in a call to `setState`. This ensures the
          // correct icon is shown.
          setState(() {
            // If the video is playing, pause it.
            if (_controller.value.isPlaying) {
              _controller.pause();
            } else {
              // If the video is paused, play it.
              _controller.play();
            }
          });
        },
        // Display the correct icon depending on the state of the player.
        child: Icon(
          _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
        ),
      ),
    );
  }
}