

import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:palestine_archive/app_router/app_router.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

import '../Models/ImageUploadModel.dart';
import '../auth/provider.dart';
import '../components/AspectRatioVideo.dart';

class AddNewVediorPage extends StatefulWidget {


  @override
  State<AddNewVediorPage> createState() => _AddNewVediorPageState();
}

class _AddNewVediorPageState extends State<AddNewVediorPage> {
  File? imageFile;
  var id, name, file, extention, imagePath;

  String? _retrieveDataError;
  VideoPlayerController? _toBeDisposed;

  final ImagePicker _picker = ImagePicker();
 // late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;
  bool isVideo = false;
String videoUrl ="";
  late XFile? videoFile;
  VideoPlayerController? _controller;

  @override
  void initState() {
    // Create and store the VideoPlayerController. The VideoPlayerController
    // offers several different constructors to play videos from assets, files,
    super.initState();
    // Create and store the VideoPlayerController. The VideoPlayerController
    // offers several different constructors to play videos from assets, files,
    // or the internet.
  //  _controller =VideoPlayerController.asset("../node/uploads/1716305800688-gaza.mp4");
   /* _controller = VideoPlayerController.networkUrl(
      Uri.parse(
        'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
      ),
    );*/

    // Initialize the controller and store the Future for later use.
   // _initializeVideoPlayerFuture = _controller.initialize();

    // Use the controller to loop the video.
    //_controller.setLooping(true);
  }

  @override
  void dispose() {
    _disposeVideoController();
    // Ensure disposing of the VideoPlayerController to free up resources.
    //_controller.dispose();

    super.dispose();
  }

  Future<void> _disposeVideoController() async {
    if (_toBeDisposed != null) {
      await _toBeDisposed!.dispose();
    }
    _toBeDisposed = _controller;
    _controller = null;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffeeac07),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[


          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: FloatingActionButton(
              backgroundColor:Color(0xffeeac07),
              onPressed: () {
                isVideo = true;
                _onImageButtonPressed(ImageSource.gallery, context: context);
              },
              heroTag: 'video0',
              tooltip: 'Pick Video from gallery',
              child: const Icon(Icons.video_library),
            ),
          ),
          if (_picker.supportsImageSource(ImageSource.camera))
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: FloatingActionButton(
                backgroundColor: Color(0xffeeac07),
                onPressed: () {
                  isVideo = true;
                  _onImageButtonPressed(ImageSource.camera, context: context);
                },
                heroTag: 'video1',
                tooltip: 'Take a Video',
                child: const Icon(Icons.videocam),
              ),
            ),

        ],
      ),
      body: SafeArea(
          child: Stack(
            children: [
              Column(
                children: [
                  headerChat(),
                  bodyChat(),

                ],

              ),

              inputChat('add'.tr(), null)
            ],
          )
      ),
    );
  }


  Widget headerChat(){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,

        children: [
          Row(
            children: [
              IconButton(onPressed: () {
                Navigator.pop(context);
              },
                  icon: Icon(Icons.arrow_back_ios, size: 25,color: Colors.white,)),
              Text('Add New Vedio', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),)
            ],
          ),
          Row(
            children: [

              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.black12
                ),
                child: Icon(Icons.add, size: 25, color: Colors.white,),
              )
            ],
          )

        ],
      ),
    );
  }

  Widget bodyChat(){

    return Expanded(
      child: SingleChildScrollView(
        child:Consumer<AppProvider>(builder: (context, provider, x) {
          return Container
    (
          height: MediaQuery.of(context).size.height+150,
          padding:  EdgeInsets.only(left: 20, right: 20, top: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40),
              topRight: Radius.circular(40),
            ),
            color: Color(0xffb8b8b8),
          ),
          child: Form(
            key: provider.addVideoKey,
            child: ListView(
              physics: BouncingScrollPhysics(),
              children: [
                Card(
                  child:
                  SizedBox(
                    width: 270,
                    height: 270,
                    child:  !kIsWeb && defaultTargetPlatform == TargetPlatform.android
                          ? FutureBuilder<void>(
                        future: retrieveLostData(),
                        builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
                          switch (snapshot.connectionState) {
                            case ConnectionState.none:
                            case ConnectionState.waiting:
                              return Container(
                                  height: MediaQuery.of(context)
                                      .size
                                      .width *
                                      0.6,
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.black
                                              .withOpacity(0.4),
                                          offset: Offset(0, 25),
                                          blurRadius: 10,
                                          spreadRadius: -2)
                                    ],
                                    color: Colors.white,
                                    borderRadius:
                                    BorderRadius.circular(10.0),

                                  ),
                                child: Center(
                                  child: Icon(Icons.video_call),
                                ), );
                            case ConnectionState.done:
                              return _handlePreview();
                            case ConnectionState.active:
                              if (snapshot.hasError) {
                                return Text(
                                  'Pick image/video error: ${snapshot.error}}',
                                  textAlign: TextAlign.center,
                                );
                              } else {
                                return Container(
                                    height: MediaQuery.of(context)
                                    .size
                                    .width *
                                    0.6,
                          decoration: BoxDecoration(
                          boxShadow: [
                          BoxShadow(
                          color: Colors.black
                              .withOpacity(0.4),
                          offset: Offset(0, 25),
                          blurRadius: 10,
                          spreadRadius: -2)
                          ],
                          color: Colors.white,
                          borderRadius:
                          BorderRadius.circular(10.0),

                          ),
                                  child: Center(
                                    child: Icon(Icons.video_call),
                                  ),

                                );
                              }
                          }
                        },
                      )
                          : _handlePreview(),

                  ),
                ),
                SizedBox(height: 10,),

                inputChat("عنوان الفيديو و نبذة عنه" , provider.descriptionController),
                inputChat("موقع الفيديو" , provider.locationController),

                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),

          );}),
        ),
      );
  }



  Widget inputChat(String text , TextEditingController? controller, ){
    return
      Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          color: Colors.white,
          height: text.contains("نبذة")?500:text !='add'.tr()?100:50,
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
          child: text !='add'.tr() ?TextField(
             keyboardType: !text.contains("نبذة")?TextInputType.text:TextInputType.multiline,
            controller: controller,
            maxLines: null,
            expands: text.contains("نبذة")?true:false,
            decoration: InputDecoration(
              hintText: "$text",
              filled: true,
              //fillColor: Colors.purple.shade100,

              labelStyle: TextStyle(fontSize: 12),
              contentPadding: EdgeInsets.all(20),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.purple.shade100),
                  borderRadius: BorderRadius.circular(25)
              ),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.purple.shade100),
                  borderRadius: BorderRadius.circular(25)
              ),

            ),
          ):
          Row(
              children: [
                SizedBox(
                  width: 200,
                  child: ElevatedButton(
                      onPressed: (() async {
                        if (  Provider.of<AppProvider>(context , listen: false).addVideoKey.currentState!.validate()) {
                          // await SignIn(provider.loginEmailController.text,provider.passwordLoginController.text);
                          await  Provider.of<AppProvider>(context , listen: false).addVideo(
                              videoUrl
                          );
                          print(videoUrl);
                        }

                        else {
                          print('not valid');
                        }
                      }),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xffeeac07), side: BorderSide.none, shape: const StadiumBorder()),
                    child:  Text(text, style: TextStyle(color: Colors.white)),
                  ),
                ),
                Expanded(child: SizedBox())
              ] ),
        ),

      );
  }


  Future getVideo() async {

    Future<XFile?> _videoFile =
    ImagePicker().pickVideo(source: ImageSource.gallery);
    _videoFile.then((file) async {
      setState(() {
        videoFile = file;
        _controller = VideoPlayerController.file(videoFile as File);

        // Initialize the controller and store the Future for later use.
      //  _initializeVideoPlayerFuture = _controller.initialize();

        // Use the controller to loop the video.
       // _controller.setLooping(true);
      });
    });
  }
  Widget _previewVideo() {
    final Text? retrieveError = _getRetrieveErrorWidget();
    if (retrieveError != null) {
      return retrieveError;
    }
    if (_controller == null) {
      return Container(
          height: MediaQuery.of(context)
              .size
              .width *
              0.6,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  color: Colors.black
                      .withOpacity(0.4),
                  offset: Offset(0, 25),
                  blurRadius: 10,
                  spreadRadius: -2)
            ],
            color: Colors.white,
            borderRadius:
            BorderRadius.circular(10.0),

          )
      ,child: Center(
        child: Icon(Icons.video_call),
      ),
      );
    }
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: AspectRatioVideo(_controller),
    );
  }
  Text? _getRetrieveErrorWidget() {
    if (_retrieveDataError != null) {
      final Text result = Text(_retrieveDataError!);
      _retrieveDataError = null;
      return result;
    }
    return null;
  }
  Widget _handlePreview() {

    return _previewVideo();

  }
  Future<void> retrieveLostData() async {
    final LostDataResponse response = await _picker.retrieveLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      if (response.type == RetrieveType.video) {
        isVideo = true;
        await _playVideo(response.file);
      }
    } else {
      _retrieveDataError = response.exception!.code;
    }
  }
  Future<void> _playVideo(XFile? file) async {
    if (file != null && mounted) {
      await _disposeVideoController();
      late VideoPlayerController controller;
      if (kIsWeb) {
        controller = VideoPlayerController.networkUrl(Uri.parse(file.path));
      } else {
        controller = VideoPlayerController.file(File(file.path));
      }
      _controller = controller;
      // In web, most browsers won't honor a programmatic call to .play
      // if the video has a sound track (and is not muted).
      // Mute the video so it auto-plays in web!
      // This is not needed if the call to .play is the result of user
      // interaction (clicking on a "play" button, for example).
      const double volume = kIsWeb ? 0.0 : 1.0;
      await controller.setVolume(volume);
      await controller.initialize();
      await controller.setLooping(true);
      await controller.play();
      videoUrl = file.path;
      setState(() {});
    }
  }
  Future<void> _onImageButtonPressed(
      ImageSource source, {
        required BuildContext context,
        bool isMultiImage = false,
        bool isMedia = false,
      }) async {
    if (_controller != null) {
      await _controller!.setVolume(0.0);
    }
    if (context.mounted) {
      if (isVideo) {
        final XFile? file = await _picker.pickVideo(
            source: source, maxDuration: const Duration(seconds: 10));
        await _playVideo(file);
      }
    }
  }
}

