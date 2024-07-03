import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:palestine_archive/Models/MartyrModel.dart';
import 'package:palestine_archive/Models/NewsModel.dart';
import 'package:palestine_archive/Models/PrisonerModel.dart';
import 'package:palestine_archive/Models/VideoModel.dart';
import 'package:palestine_archive/Models/VillageModel.dart';
import 'package:palestine_archive/app_router/app_router.dart';
import 'package:palestine_archive/features/actvities/screens/user_activties_screen.dart';
import 'package:provider/provider.dart';


import '../../../Models/ActivityModel.dart';
import '../../../auth/provider.dart';
import '../../../core/utils/color_constants.dart';
import '../../../core/utils/global_constants.dart';
import '../../../widgets/home.dart';
import '../services/activties_services.dart';
import '../widgets/activity_details_container.dart';

class ActivityDetailsScreen extends StatefulWidget {
  static const String route = "/transaction-details";
  final ActivityModel activity;
   ActivityDetailsScreen({
    Key? key,
    required this.activity,
  }) : super(key: key);

  @override
  State<ActivityDetailsScreen> createState() => _ActivityDetailsScreenState();
}

class _ActivityDetailsScreenState extends State<ActivityDetailsScreen> {
  //final ActivityCard activity;
  final ActivityServices activityServices = ActivityServices();

List<ActivityDetailsContainer> cardList=[];
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    buildActivityCard();
  }
  void buildActivityCard(){
    cardList.clear();
    switch(widget.activity.activityType) {
      case 'Prisoner': {
        PrisonerModel model =widget.activity.ActivityObject as PrisonerModel;
       cardList =[
         ActivityDetailsContainer(content: model.name??'',
           label: "prisoner_name".tr(),
         ),
         ActivityDetailsContainer(content:  model.date_of_birth??''.split('T').first + ' ${model.date_of_birth??''.split('T').last.split('.').first}',
           label: "birth_date".tr(),
         ),
         ActivityDetailsContainer(content:  model.date_of_arrest??''.split('T').first + ' ${model.date_of_arrest??''.split('T').last.split('.').first}',
           label: "arrest_date".tr(),
         ),
         ActivityDetailsContainer(content: model.place_of_birth??'',
           label: "birth_place".tr(),
         ),
       ];
      }
      break;
      case 'Martyr': {
        MartyrModel model =widget.activity.ActivityObject as MartyrModel;
        cardList =[
          ActivityDetailsContainer(content: model.full_name??'',
            label: "martyr_name".tr(),
          ),
          ActivityDetailsContainer(content: model.nationality??'',
            label: "nationality".tr(),
          ),
          ActivityDetailsContainer(

            content: model.date_of_birth??''.split('T').first + ' ${model.date_of_birth??''.split('T').last.split('.').first}',
            label: "birth_date".tr(),
          ),
          ActivityDetailsContainer(content: model.date_of_death??''.split('T').first + ' ${model.date_of_death??''.split('T').last.split('.').first}',
            label: "death_of_date".tr(),
          ),
          ActivityDetailsContainer(content: model.place_of_death??'',
            label: "place_of_death".tr(),
          ),
          ActivityDetailsContainer(content: model.cause_of_death??'',
            label: "cause_of_death".tr(),
          ),

        ];
      }
      break;
      case 'News': {
        NewsModel model =widget.activity.ActivityObject as NewsModel;
        cardList =[
          ActivityDetailsContainer(content: model.name??'',
            label: "Title",
          ),
          ActivityDetailsContainer(content: model.source??'',
            label: "source",
          ),
          ActivityDetailsContainer(content: model.category??'',
            label: "Category",
          ),

        ];
      }
      break;

      case 'Video': {
        VideoModel model =widget.activity.ActivityObject as VideoModel;
        cardList =[
    ActivityDetailsContainer(content: model.location??'',
    label: "Location",
    ),
    ];

    }
      break;


      default: {
      }
      break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        leadingWidth: screenWidth,
        scrolledUnderElevation: 5,
        leading: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [ IconButton(
            onPressed: ()=>AppRouter.appRouter.goToWidgetAndReplace(Home()),
            icon: Icon(Icons.arrow_back),
          ),
             Text(
              "Activity Details",
              style: TextStyle(
                fontSize: heightValue25,
              ),


             ),
           ],
         ),
       ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all( 15),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: heightValue10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      widget.activity.activityType,

                      style: TextStyle(
                        fontSize: heightValue30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: heightValue5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "On ",
                      style: TextStyle(fontSize: heightValue19),
                    ),
                    Text(
                      widget.activity.created_at,
                      style: TextStyle(
                        fontSize: heightValue19,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                  ],
                ),
                Container(
                  height:100,
                  width: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(35),
                    //color: scaffoldBackgroundColor,
                  ),
                  child: Center(
                    child: Image.network(
                      widget.activity.activityTypeImage,
                      height: heightValue100,
                      fit: BoxFit.cover,

                    ),
                  ),
                ),
                SizedBox(
                  height: heightValue15,
                ),
                ActivityDetailsContainer(
                  isAmount: false,
                  label: "Activity Type",
                  content:
                      "${widget.activity.activityType}",

                ),

                ActivityDetailsContainer(
                  label: "Author Name",
                  content: "${widget.activity.authorName}",
                ),
                ActivityDetailsContainer(
                  label: "Activity Summary",
                  content: widget.activity.activitySummary,
                ),
                ...cardList,
                ActivityDetailsContainer(
                  label: "Created Date",
                  content: widget.activity.created_at.split('T').first + ' ${widget.activity.created_at.split('T').last.split('.').first}',
                 //   ${provider.selectedNews.created_at?.split('T').first} ${widget.activity.created_at.split('T').last.split('.').first}'
                ),

                SizedBox(
                  height: heightValue15,
                ),
                Row(
                  children: [
                    Expanded(child: SizedBox()),
                   GestureDetector(
                    onTap: () {
                      switch(widget.activity.activityType) {
                        case 'Prisoner': {
                          activityServices.DeclineActivities(userId:widget.activity.authorName,
                              activityID:(widget.activity.ActivityObject as PrisonerModel).id.toString(), tableName: 'review_prisoners', context: context);
                          activityServices.getAllUserActivities(context: context);
                        }
                        break;
                        case 'Martyr': {

                          activityServices.DeclineActivities(userId:widget.activity.authorName,activityID:
                          (widget.activity.ActivityObject as MartyrModel).id.toString(),tableName:  'review_martyrs', context: context);
                          activityServices.getAllUserActivities(context: context);
                        }
                        break;
                        case 'News': {
                          activityServices.DeclineActivities(userId:widget.activity.authorName, activityID: (widget.activity.ActivityObject as NewsModel).id.toString(), tableName: 'review_news',  context:context);

                          // Provider.of<AppProvider>(context,listen: false ).getNews();
                          activityServices.getAllUserActivities(context: context);

                        }
                        break;

                        case 'Video': {
                          activityServices.DeclineActivities(userId:widget.activity.authorName, activityID:(widget.activity.ActivityObject as VideoModel).id.toString(),  tableName:'review_videos', context: context);
                          activityServices.getAllUserActivities(context: context);

                          //Provider.of<AppProvider>(context,listen: false ).getVideos();
                        }
                        break;
                        case 'Village': {
                          activityServices.DeclineActivities(userId:widget.activity.authorName, activityID:(widget.activity.ActivityObject as VillageModel).id.toString(), tableName: 'review_palestinian_villages',context:  context);

                          //Provider.of<AppProvider>(context,listen: false ).getVillages();
                        }
                        break;


                        default: {
                        }
                        break;
                      }
                    },
                    child: Container(
                      height: heightValue80,
                      width: screenWidth*0.3,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(heightValue20),
                        color: Colors.red,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/images/error_image.png",
                            height: heightValue30,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Reject Activity",
                            style: TextStyle(
                              fontSize: heightValue25,
                              color: whiteColor,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                    Expanded(child: SizedBox()),
                    GestureDetector(
                      onTap: () {
                        switch(widget.activity.activityType) {
                          case 'Prisoner': {
                             activityServices.AcceptActivities(userId:widget.activity.authorName,
                                 activityID:(widget.activity.ActivityObject as PrisonerModel).id.toString(), tableName: 'review_prisoners', context: context);
                           Provider.of<AppProvider>(context , listen: false).getPrisoners('http://localhost:3000');
                          }
                          break;
                          case 'Martyr': {

                             activityServices.AcceptActivities(userId:widget.activity.authorName,activityID:
                             (widget.activity.ActivityObject as MartyrModel).id.toString(),tableName:  'review_martyrs', context: context);
                             activityServices.getAllUserActivities(context: context);
                             Provider.of<AppProvider>(context , listen: false).getMartyrs('http://localhost:3000');

                          }
                          break;
                          case 'News': {
                             activityServices.AcceptActivities(userId:widget.activity.authorName, activityID: (widget.activity.ActivityObject as NewsModel).id.toString(), tableName: 'review_news',  context:context);
                             activityServices.getAllUserActivities(context: context);
                             Provider.of<AppProvider>(context , listen: false).getNews('http://localhost:3000');

                           // Provider.of<AppProvider>(context,listen: false ).getNews();

                          }
                          break;

                          case 'Video': {
                             activityServices.AcceptActivities(userId:widget.activity.authorName, activityID:(widget.activity.ActivityObject as VideoModel).id.toString(),  tableName:'review_videos', context: context);
                             activityServices.getAllUserActivities(context: context);
                             Provider.of<AppProvider>(context , listen: false).getVideos('http://localhost:3000');
                            //Provider.of<AppProvider>(context,listen: false ).getVideos();
                          }
                          break;
                          case 'Village': {
                             activityServices.AcceptActivities(userId:widget.activity.authorName, activityID:(widget.activity.ActivityObject as VillageModel).id.toString(), tableName: 'review_palestinian_villages',context:  context);
                             activityServices.getAllUserActivities(context: context);
                             Provider.of<AppProvider>(context , listen: false).getVillages('http://localhost:3000');
                            //Provider.of<AppProvider>(context,listen: false ).getVillages();
                          }
                          break;


                          default: {
                          }
                          break;
                        }
                        // Navigator.pushNamed(context, CommingSoonScreen.route);
                      },
                      child: Container(
                        height: heightValue80,
                        width: screenWidth*0.3,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(heightValue20),
                          color: Colors.green,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              "assets/images/dialog_success_image.png",
                              height: heightValue30,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Accept Activity",
                              style: TextStyle(
                                fontSize: heightValue25,
                                color: whiteColor,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Expanded(child: SizedBox()),
                ]),
                SizedBox(
                  height: heightValue15,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
