import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:palestine_archive/Models/VideoModel.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:video_player/video_player.dart';

import '../app_router/app_router.dart';
import '../auth/provider.dart';
import '../features/PostScreen/Videos/VideoPlayer.dart';
import '../screens/WachVedioScreen.dart';

class VideoWidget extends StatefulWidget {
  VideoModel videoModel;

  VideoWidget({
   required this.videoModel
});



  @override
  _VideoWidgetState createState() => _VideoWidgetState();
}

class _VideoWidgetState extends State<VideoWidget> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    //"http://10.0.2.2:3000/uploads/${provider.selectedPrisoner.photo_url!}"
    print( widget.videoModel.video_path!);
    super.initState();

    _controller = VideoPlayerController.network(
      widget.videoModel.video_path!
      ,

    );

    // Initialize the controller and store the Future for later use.
    _initializeVideoPlayerFuture = _controller.initialize();

    // Use the controller to loop the video.
   // _controller.setLooping(true);
  }



  Widget build(BuildContext context) {
    return Consumer<AppProvider>(builder: (context, provider, x) {

      return
    GestureDetector(
    onTap: ()async{
      if(ResponsiveBreakpoints.of(context).isMobile) {
        await provider.getSelectedVideo(
            widget.videoModel.id);
        AppRouter.appRouter.goToWidget(
            VideoPlayerScreen1());
      }else{
        await provider.getSelectedVideo(
            widget.videoModel.id,'http://localhost:3000');
        AppRouter.appRouter.goToWidget(
            webVideoPlayerScreen());
      }

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

            Stack(
              children: [Container(
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
                        image: NetworkImage(ResponsiveBreakpoints.of(context).isMobile?
                        "https://www.shutterstock.com/image-vector/film-production-concept-vector-illustration-260nw-422984515.jpg":
                        "https://t4.ftcdn.net/jpg/01/98/91/61/360_F_198916185_VKZVR6qSUSh212tbkQwoxVnkZt3mgC62.jpg"

                        ))

                ),
                child: VideoPlayer(_controller
                )



              ),
              Positioned(
                bottom: 0,
                  child: Row(
                children: [
                  Container(
                    alignment: Alignment.topLeft,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.5)
                    ),
                    //margin: EdgeInsets.only( top: 5),
                    child: Expanded(
                      child:Icon(Icons.remove_red_eye_rounded, color: Color(0xffeeac07),),

                    ),
                  ),
                  Container(
                      alignment: Alignment.topLeft,

                      decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.5)
                      ),
                      child:Text(
                        "عدد المشاهدات :${NumberFormat.compact(
                         // decimalDigits: 0,
                          locale: 'en_IN',
                         // symbol: '',
                        ).format(widget.videoModel.views)}",
                        style: TextStyle(
                            fontSize: 12,

                            color: Color(0xFF00416b)),
                      )
                  )
                ],
              ))
              ],
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  height:200,
                  child: Column(

                    children: [

                     /* Text("Film Name : ${widget.title}"
                        ,style: TextStyle(
                          color: Color(0xFF00416b),
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                        overflow: TextOverflow.fade,),*/
                      Expanded(
                        child: Text("About The Video : ${widget.videoModel.description}",
                            overflow: TextOverflow.fade,
                            style: TextStyle(
                              color: Colors.grey,
                        
                              fontSize: 16,
                            )
                        
                        ),
                      ),

                    ],
                  ),
                ),
              ),

            )
          ],

        ),
      ),
    ),
  );});
  }
}