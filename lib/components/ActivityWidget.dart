/*import 'package:flutter/material.dart';
import 'package:palestine_archive/Models/ActivityModel.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

import '../Models/VideoModel.dart';
import '../app_router/app_router.dart';
import '../auth/provider.dart';
import '../screens/WachVedioScreen.dart';

class ActivityWidget extends StatefulWidget {
  late ActivityModel? activity;
  ActivityWidget({
    this.activity,

  });



  @override
  _ActivityWidgetState createState() => _ActivityWidgetState();
}

class _ActivityWidgetState extends State<ActivityWidget> {

  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;
  @override
  void initState() {
    super.initState();
   /* _controller = VideoPlayerController.asset(
      ( (VideoModel) widget.activity.ActivityObject).!
      ,

    );*/

    // Initialize the controller and store the Future for later use.
    _initializeVideoPlayerFuture = _controller.initialize();

    // Use the controller to loop the video.
    // _controller.setLooping(true);
  }



  Widget build(BuildContext context) {
    return
      GestureDetector(
        onTap: () {
          AppRouter.appRouter.goToWidget(VideoPlayerScreen1());
          // AppRouter.appRouter.goToWidget(WatchMoviesView(movieID: '',));},
        },
        child: Card(
          margin: EdgeInsets.only(bottom: 20),
          child: Container(
            width: MediaQuery.of(context)
                .size
                .width *
                0.35,
            height: MediaQuery.of(context)
                .size
                .height *
                0.2,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    color: Colors.black
                        .withOpacity(0.4),
                    offset: Offset(0, 25),
                    blurRadius: 10,
                    spreadRadius: -2
                )
              ],
              color:  !Provider.of<AppProvider>(context ).darkTheme?Colors.white:Colors.black12.withOpacity(0.001),

              borderRadius:
              BorderRadius.circular(10.0),
            ),
            child: Row(
              children: [

                Container(
                    width: MediaQuery.of(context)
                        .size
                        .width *
                        0.35,
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black
                                  .withOpacity(0.4),
                              offset: Offset(0, 25),
                              blurRadius: 10,
                              spreadRadius: -2)
                        ],
                        //     color: Colors.green,
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage("https://www.shutterstock.com/image-vector/film-production-concept-vector-illustration-260nw-422984515.jpg"))

                    ),
                    child: widget.activity.activityType=="Video"?VideoPlayer
                      (_controller):null



                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Container(
                      height:200,
                      child: Column(

                        children: [

                          Text("Film Name : ${widget.title}"
                            ,style: TextStyle(
                              color: Color(0xFF00416b),
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                            overflow: TextOverflow.fade,),
                          Text("About The Film : ${widget.disc}",
                              overflow: TextOverflow.fade,
                              style: TextStyle(
                                color: Colors.grey,

                                fontSize: 14,
                              )

                          ),
                          Row(
                            children: [
                              Container(
                                alignment: Alignment.topLeft,
                                //margin: EdgeInsets.only( top: 5),
                                child: Expanded(
                                  child:Icon(Icons.remove_red_eye_rounded, color: Color(0xffeeac07),),

                                ),
                              ),
                              Container(
                                  alignment: Alignment.topLeft,
                                  // margin: EdgeInsets.only( top: 5),
                                  child:Text(
                                    "عدد المشاهدات :${5}",
                                    style: TextStyle(
                                        fontSize: 14,

                                        color: Color(0xFF00416b)),
                                  )
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),

                )
              ],

            ),
          ),
        ),
      );
  }
}
 */