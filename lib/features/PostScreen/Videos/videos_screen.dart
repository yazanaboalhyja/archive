import 'package:flutter/material.dart';
import 'package:palestine_archive/Models/VideoModel.dart';
import 'package:palestine_archive/components/VideoWidget.dart';

import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../auth/provider.dart';
import '../../../core/utils/color_constants.dart';

import '../../../widgets/circular_loader.dart';
import '../../../widgets/width_space.dart';
import '../../auth/providers/user_provider.dart';
import '../../dashboard/services/dashboard_services.dart';
import 'addNewVideo.dart';


class VideosScreen extends StatefulWidget {
  static const route = '/videos-screen';
  VideosScreen({super.key });

  @override
  State<VideosScreen> createState() => VildeosScreenState();
}

class VildeosScreenState extends State<VideosScreen> {

  late Future future;
  List<VideoModel> mainData = [];
  List<VideoWidget> WidgetList = [];
  List<VideoWidget> filteredList = [];

  getAllVideo() async {
    await Provider.of<AppProvider>(context, listen: false).getVideos('http://localhost:3000');
    mainData =   Provider.of<AppProvider>(context, listen: false).VideoFilterList;
    WidgetList=[];

    mainData.forEach((element) {
      WidgetList.add(VideoWidget(
        videoModel: element, ));

    });
    print(WidgetList.length.toString()+'***************');
    setState(() {
      filteredList = WidgetList;

    });
  }


  @override
  void initState() {
    super.initState();
    future = getAllVideo();
    //getAllTransactions();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context, listen: false).user;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryAppColor,
        tooltip: 'Upload Video',
        onPressed: (){

          Navigator.push(context, MaterialPageRoute(builder: (context) => UploadVideoScreen(),))   ;

        },
        child: const Icon(Icons.add, color: Colors.white, size: 28),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Text(
                      "Videos Screen",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const WidthSpace(20),
                    Container(
                      height: 25,
                      width: 25,
                      decoration: BoxDecoration(
                        border: Border.all(color: greyScale600),
                        shape: BoxShape.circle,
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.question_mark_rounded,
                          size: 20,
                          color: greyScale600,
                        ),
                      ),
                    )
                  ],
                ),
                const Icon(Icons.notifications)
              ],
            ),
          ),
          if (ResponsiveBreakpoints.of(context).isMobile)
            Expanded(
              //height: 350,
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  childAspectRatio: 2,
                ),
                itemCount:filteredList.length,
                itemBuilder: (BuildContext context, int index) {
                  return FutureBuilder(
                    future: future,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        return SizedBox(
                          width: MediaQuery.of(context).size.width*0.75,
                          height:MediaQuery.of(context).size.width*0.2,
                          child:filteredList[index] ,
                        )

                          ;

                      } else {}
                      return const CircularLoader();
                    },
                  );
                },
              ),
            ),
          if (ResponsiveBreakpoints.of(context).isTablet)
            Expanded(
              //height: 350,
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1.5,
                ),
                itemCount: filteredList.length,
                itemBuilder: (BuildContext context, int index) {
                  return FutureBuilder(
                    future: future,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        return filteredList [index];
                      } else {}
                      return const CircularLoader();
                    },
                  );
                },
              ),
            ),
          if (ResponsiveBreakpoints.of(context).isDesktop)
            Expanded(
              //height: 350,
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  childAspectRatio: 5,
                ),
                itemCount: filteredList.length,
                itemBuilder: (BuildContext context, int index) {
                  return FutureBuilder(
                    future: future,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        return    SizedBox(
                          width: MediaQuery.of(context).size.width*0.75,
                          height:MediaQuery.of(context).size.height*0.0001,
                          child:filteredList[index] ,
                        );

                      } else {}
                      return const CircularLoader();
                    },
                  );
                },
              ),
            ),
        ],
      ),
    );
  }

}
