import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:palestine_archive/components/VideoWidget.dart';

import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

import '../Models/ActivityModel.dart';
import '../Models/MartyrModel.dart';
import '../Models/NewsModel.dart';
import '../Models/PrisonerModel.dart';
import '../app_router/app_router.dart';
import '../auth/provider.dart';
import '../data.dart';
import '../widgets/activity_details_container.dart';
import 'WachVedioScreen.dart';


class ActivitiesScreen extends StatefulWidget {
  @override
  State<ActivitiesScreen> createState() => _ActivitiesScreenState();
}

class _ActivitiesScreenState extends State<ActivitiesScreen> {
  List<ActivityCard> filteredActivities = [];
  List<ActivityCard> ActivityCardList=[];


  getAllActivities() async {
    ActivityCardList=[];

    Provider.of<AppProvider>(context,listen: false).ActivityFilterList.forEach((element) {
      ActivityCardList.add(
          ActivityCard(activity: element,));
    });

    setState(() {
      filteredActivities = ActivityCardList;
    });
  }
  @override
  Widget build(BuildContext context) {


    return Scaffold(
        body: Consumer<AppProvider>(builder: (context, provider, x) {

          return SafeArea(

            child: Container(
                decoration: const BoxDecoration(
                  color: Colors.black26,
                  image: DecorationImage(
                    image: NetworkImage(
                        'https://i.pinimg.com/564x/93/f2/7a/93f27a7f4785ac818ef5e6bbcfc83353.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
                height: 880,
                child:
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start, children: [
                  SizedBox(height: 20),
                  Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.arrow_back_ios),
                          color: Colors.white,
                          onPressed: () {
                            AppRouter.appRouter.hideDialoug();
                          },
                        ),
                        Expanded(child: SizedBox()),

                        SizedBox(
                          height: 45,
                          width: MediaQuery.of(context).size.width*0.8,
                          child: TextField(
                            style: GoogleFonts.poppins(
                              color: const Color(0xff020202),
                              fontSize: 20,
                              fontWeight: FontWeight.w100,
                              letterSpacing: 0.5,
                            ),
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: const Color(0xfff1f1f1),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide.none,
                              ),
                              hintText: "Search for Activity...",
                              hintStyle: GoogleFonts.poppins(
                                  color: const Color(0xffb2b2b2),
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                  letterSpacing: 0.5,
                                  decorationThickness: 6),
                              prefixIcon: const Icon(Icons.search),
                              prefixIconColor: Colors.black,
                            ),
                          ),
                        ),
                        Expanded(child: SizedBox()),
                      ]),
                  SizedBox(height: 10,),
                  const Row(
                      children: [ Text('${'My Activities Screen'} :\n',
                          style: TextStyle(
                            color: Color(0xFF00416b),
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          )),
                        Expanded(child: SizedBox()),

                      ]),
                  provider.ActivityFilterList.isNotEmpty? Expanded(

                    child: ListView.builder(

                        itemCount: provider.ActivityFilterList.length
                        ,
                        itemBuilder: (BuildContext context, int index) {
                          return ActivityCard(activity:
                          provider.ActivityFilterList[index]);
                          ;

                        } ),
                  ):
                  Center(child: Text('No Activities Yet...'),)

                  ,

                ]

                )),

          );
        }));
  }
}