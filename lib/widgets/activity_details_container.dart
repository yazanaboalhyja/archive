
import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:palestine_archive/Models/MartyrModel.dart';
import 'package:palestine_archive/Models/NewsModel.dart';
import 'package:palestine_archive/Models/PrisonerModel.dart';
import 'package:palestine_archive/Models/VideoModel.dart';
import 'package:palestine_archive/Models/VillageModel.dart';
import 'package:palestine_archive/auth/provider.dart';
import 'package:palestine_archive/screens/PalestineAtlas.dart';
import 'package:responsive_framework/responsive_framework.dart';

import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

import '../app_router/app_router.dart';
import '../auth/provider.dart';
import '../Models/ActivityModel.dart';
import '../core/utils/color_constants.dart';
import '../core/utils/global_constants.dart';

class ActivityCard extends StatefulWidget {
 final ActivityModel activity;

  const ActivityCard({
    Key? key,
    required this.activity,

  }) : super(key: key);

  @override
  State<ActivityCard> createState() => _ActivityCardState();
}

class _ActivityCardState extends State<ActivityCard> {



void DeleteActivity(){
  switch(widget.activity.activityType) {
    case 'Prisoner': {
      Provider.of<AppProvider>(context,listen: false ).DeleteActivity
        ('delete_prisoners', (widget.activity.ActivityObject as PrisonerModel).id .toString());
      Provider.of<AppProvider>(context,listen: false ).getPrisoners();
    }
    break;

    case 'News': {
      Provider.of<AppProvider>(context,listen: false ).DeleteActivity
        ('delete_news', (widget.activity.ActivityObject as NewsModel).id .toString());
      Provider.of<AppProvider>(context,listen: false ).getNews();
    }
    break;

    case 'Video': {
      Provider.of<AppProvider>(context,listen: false ).DeleteActivity
        ('delete_video', (widget.activity.ActivityObject as VideoModel).id.toString() );
      Provider.of<AppProvider>(context,listen: false ).getVideos();
    }
    break;


    default: {
        }
    break;
  }
  AppRouter.appRouter.navigatorKey.currentState!.pop();
}
void EditActivity() async{
  switch(widget.activity.activityType) {
    case 'Prisoner': {
      //dateOfArrestController
      TextEditingController _textFieldController = TextEditingController();
      TextEditingController dateOfArrestController = TextEditingController();
      _textFieldController.text =(widget.activity.ActivityObject as PrisonerModel).life_story??'';
      dateOfArrestController.text =(widget.activity.ActivityObject as PrisonerModel).date_of_arrest??'0000-00-00';
      return showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Prisoner information'),
              content: SizedBox(
                height: MediaQuery.of(context).size.height*0.3,
                child: Column(
                  children:[

                    TextField(
                    controller: _textFieldController,
                    decoration: InputDecoration(hintText: "Life Story"),
                  ),
                    TextField(
                       controller:dateOfArrestController ,
                      decoration: InputDecoration(
                         icon: IconButton(
                              onPressed: () async {
                                DateTime? pickedDate = await showDatePicker(
                                  context: context,
                                  lastDate: DateTime.now(),
                                  firstDate: DateTime(1990),
                                  initialDate: DateTime.now(),
                                );
                                if (pickedDate == null) return;

                                dateOfArrestController.text = DateFormat('yyyy-MM-dd').format(pickedDate);

                              },
                              icon: Icon(Icons.calendar_month))
                      ),
                    )
                ]),
              ),
              actions: <Widget>[
                GestureDetector(
                  child: Text('CANCEL'),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                GestureDetector(
                  child: Text('OK'),
                  onTap: () {
                    Provider.of<AppProvider>(context,listen: false ).EditPrisoner(
                        (widget.activity.ActivityObject as PrisonerModel).id.toString(),
                        dateOfArrestController.text,
                        _textFieldController.text
                    );

                    print(_textFieldController.text);
                    Navigator.pop(context);
                  },
                ),
              ],
            );
          });

    }


    case 'News': {
      TextEditingController _textField1Controller = TextEditingController();
      TextEditingController _textField2Controller = TextEditingController();
      _textField1Controller.text =(widget.activity.ActivityObject as NewsModel).description??'';
      _textField2Controller.text =(widget.activity.ActivityObject as NewsModel).source??'';
      return showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('News Update'),
              content: SizedBox(
                height: MediaQuery.of(context).size.height*0.3,
                child: Column(
                    children:[

                      TextField(

                        controller: _textField1Controller,
                        decoration: InputDecoration(

                            hintText: "Description"),
                      ),
                      TextField(
                        controller:_textField2Controller ,
                        decoration: InputDecoration(hintText: "Source"),

                      )
                    ]),
              ),
              actions: <Widget>[
                GestureDetector(
                  child: Text('CANCEL'),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                GestureDetector(
                  child: Text('OK'),
                  onTap: () {
                    Provider.of<AppProvider>(context,listen: false ).EditNews(
                        (widget.activity.ActivityObject as NewsModel).id.toString(),
                        _textField1Controller.text,
                        _textField2Controller.text
                    );

                    Navigator.pop(context);
                  },
                ),
              ],
            );
          });

    }
    break;
    case 'Village': {
      TextEditingController _textField1Controller = TextEditingController();
      TextEditingController _textField2Controller = TextEditingController();
      _textField1Controller.text =(widget.activity.ActivityObject as VillageModel).historical_context??'';
      _textField2Controller.text =(widget.activity.ActivityObject as VillageModel).current_status??'';
      return showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Village Update'),
              content: SizedBox(
                height: MediaQuery.of(context).size.height*0.3,
                child: Column(
                    children:[

                      TextField(

                        controller: _textField1Controller,
                        decoration: InputDecoration(

                            hintText: "Historical Context"),
                      ),
                      TextField(
                        controller:_textField2Controller ,
                        decoration: InputDecoration(hintText: "Current Status"),

                      )
                    ]),
              ),
              actions: <Widget>[
                GestureDetector(
                  child: Text('CANCEL'),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                GestureDetector(
                  child: Text('OK'),
                  onTap: () {
                    Provider.of<AppProvider>(context,listen: false ).EditVillage(
                        (widget.activity.ActivityObject as VillageModel).id.toString(),
                        _textField1Controller.text,
                        _textField2Controller.text
                    );

                    Navigator.pop(context);
                  },
                ),
              ],
            );
          });

    }
    case 'Video': {
      TextEditingController _textFieldController = TextEditingController();
      _textFieldController.text =(widget.activity.ActivityObject as VideoModel).description;
     return showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Video description'),
              content: TextField(
                controller: _textFieldController,
                decoration: InputDecoration(hintText: "description"),
              ),
              actions: <Widget>[
                GestureDetector(
                  child: Text('CANCEL'),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                GestureDetector(
                  child: Text('OK'),
                  onTap: () {
                    Provider.of<AppProvider>(context,listen: false ).EditVideo(
                        (widget.activity.ActivityObject as VideoModel).id.toString(), _textFieldController.text);

                    print(_textFieldController.text);
                    Navigator.pop(context);
                  },
                ),
              ],
            );
          });
    }


    default: {
    }
    break;
  }
  AppRouter.appRouter.navigatorKey.currentState!.pop();
}
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          Container(
            height: heightValue80,
            width: screenWidth,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(heightValue20),
              color: ResponsiveBreakpoints.of(context).isDesktop  || Provider.of<AppProvider>(context).darkTheme?

              greyScale850:Colors.white
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ResponsiveBreakpoints.of(context).isMobile&&widget.activity.activityType!='Martyr'?
                  PopupMenuButton<int>(

                    itemBuilder: (context) => [
                      PopupMenuItem<int>(value: 0, child: GestureDetector(
                          onTap:(){
                            Navigator.of(context).pop() ;

                            EditActivity();
                            }
                              ,
                             // AppRouter.appRouter.showCustomDialoug("Edit Content", ""),
                          child: Text('Edit Post'))),
                      PopupMenuItem<int>(


                          value: 1, child: GestureDetector(
                          onTap: (){
                            Navigator.of(context).pop() ;
                            AppRouter.appRouter.showCustomDialoug(
                              "Delete Post", "Are You Sure to delete this post?"
                          ,
                            DeleteActivity
                          );},
                          child: Text('Delete Post'))),
                    ],
                  ):SizedBox(),
                  Container(
                    height: heightValue35,
                    width: heightValue35,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(35),
                      //color: scaffoldBackgroundColor,
                    ),
                    child: Center(
                      child: Image.network(
                        widget.activity.activityTypeImage,
                        height: heightValue20,
                      ),
                    ),
                  ),
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                            Text(
                              widget.activity.activityType,
                              style: TextStyle(
                                fontSize: heightValue20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),


                         /* Text(
                            widget.activity.activitySummary,
                            style: TextStyle(
                              fontSize: heightValue17,
                            ),
                            overflow: TextOverflow.,
                          )*/
                        ],
                      ),
                    ),
                  ),
                  ResponsiveBreakpoints.of(context).isDesktop?Row(
                    children: [
                      Text(
                        "Submitted By : ${widget.activity.authorName}",
                        style: TextStyle(
                         // color: amountColorBasedOnTransactionType,
                          fontSize: heightValue20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: heightValue20,
                      )
                    ],
                  ):Icon(
                    Icons.check,
                    size: heightValue20,
                    color: Colors.green,
                  )
                ],
              ),

            ),
          ),

          // Positioned(
          //   left: 0,
          //   top: 0,
          //   child: ClipRRect(
          //     borderRadius: BorderRadius.only(
          //       bottomRight: Radius.circular(
          //         heightValue25,
          //       ),
          //       topLeft: Radius.circular(
          //         heightValue20,
          //       ),
          //     ),
          //     child: Container(
          //       height: heightValue25,
          //       width: heightValue25,
          //       decoration: const BoxDecoration(
          //         color: Color(0xFF5337A5),
          //       ),
          //     ),
          //   ),
          // )
        ],
      ),
    );
  }
}
