import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

import '../../../auth/provider.dart';
import '../../../components/AspectRatioVideo.dart';
import '../../../core/utils/color_constants.dart';
import '../../../core/utils/global_constants.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_textfield.dart';
import '../../../widgets/height_space.dart';
import '../../settings/services/settings_services.dart';



class UploadVideoScreen extends StatefulWidget {
  static const route = '/create-video';
  const UploadVideoScreen({super.key});

  @override
  State<UploadVideoScreen> createState() => _CreateVillageScreenState();
}

class _CreateVillageScreenState extends State<UploadVideoScreen> {



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

  File? imageFile  ;
  String path ="";
  Future<void> _disposeVideoController() async {
    if (_toBeDisposed != null) {
      await _toBeDisposed!.dispose();
    }
    _toBeDisposed = _controller;
    _controller = null;
  }
  @override
  void dispose() {
    _disposeVideoController();
    // Ensure disposing of the VideoPlayerController to free up resources.
    //_controller.dispose();

    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        floatingActionButton:  Column(
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
        // appBar: CustomAppBar(image: logo),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const HeightSpace(10),
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: Text(
                      "Upload Video ",
                      style: TextStyle(
                        fontSize: heightValue37,
                        fontWeight: FontWeight.w900,
                        height: 1.5,
                      ),
                    ),
                  ),
                  formUI()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget formUI() {
    return Consumer<AppProvider>(builder: (context, provider, x) {

      return Form(
        key: provider.addVideoKey,
        child: Center(
          child: SizedBox(
            width: 400,
            child: Column(
              children: [
                Card(
                  child:
                  SizedBox(
                    width: 270,
                    height: 270,
                    child:
                    !kIsWeb && defaultTargetPlatform == TargetPlatform.android
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
                CustomTextField(
                  labelText: "Video Description",
                  hintText: "Enter Village name",
                  controller: provider.descriptionController,
                  // validator: validateName,
                ),

                CustomTextField(
                  labelText: "Video Location",
                  hintText: "Enter Video Location",
                  controller: provider.locationController,
                  // validator: validateEmail,
                ),



                CustomButton(
                  buttonText: "Uplaod Video",
                  buttonColor: primaryAppColor,
                  buttonTextColor: scaffoldBackgroundColor,
                  borderRadius: heightValue30,
                  onTap: () {

                  },
                ),
              ],
            ),
          ),
        ),
      );});

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
