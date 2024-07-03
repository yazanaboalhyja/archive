// ignore_for_file: use_build_context_synchronously, avoid_print, unused_catch_clause

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:palestine_archive/Models/ActivityModel.dart';
import 'package:palestine_archive/widgets/home.dart';


import 'package:provider/provider.dart';

import '../../../Models/MartyrModel.dart';
import '../../../Models/NewsModel.dart';
import '../../../Models/PrisonerModel.dart';
import '../../../Models/VideoModel.dart';
import '../../../Models/VillageModel.dart';
import '../../../app_router/app_router.dart';
import '../../../config/routes/custom_push_navigators.dart';
import '../../../core/error/error_handler.dart';
import '../../../core/utils/custom_dialogs.dart';
import '../../../core/utils/global_constants.dart';
import '../../auth/providers/user_provider.dart';

class ActivityServices {
  Future<List<ActivityModel>> getAllUserActivities({
    required BuildContext context,
  }) async {
    List<ActivityModel> myActivities = [];

    final userToken =
        Provider.of<UserProvider>(context, listen: false).user.token;

    try {
      final res = await http.get(
          Uri.parse('$uri/review_all'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization' : userToken
          }
        // Correctly insert the id into the URL
      ).timeout(const Duration(seconds: 25));
      //Navigator.of(context, rootNavigator: true).pop('dialog');
      print(res.statusCode);
      // ignore: use_build_context_synchronously
      statusCodeHandler(
          context: context,
          response: res,

          onSuccess: () {
            final  data = jsonDecode(res.body);

            List activityResult =  [];
            late ActivityModel activityModel  ;
            data.forEach((k,v) {
              print('${k}: ${v}');
              switch(k) {
                case "review_martyrs": {
                  // statements;
                  activityResult.clear();
                  activityResult =  data[k];
                  if(activityResult.isNotEmpty){

                    activityResult.forEach((e) {
                      MartyrModel martyrModel = MartyrModel.fromMap(e);
                      activityModel =ActivityModel(activityTypeImage:
                      e['photo_url'],
                          activityType:martyrModel.type ,
                          authorName: martyrModel.submitted_by.toString(), created_at:martyrModel.created_at!,

                          activitySummary:
                          e['description']??'',
                          ActivityObject:  martyrModel);

                      myActivities.add(activityModel);

                    });
                  }
                }
                break;

                case "review_videos": {
                  activityResult.clear();
                  activityResult =  data[k];
                  if(activityResult.isNotEmpty){
                    activityResult.forEach((e) {
                      VideoModel videoModel = VideoModel.fromMap(e);
                      activityModel =ActivityModel(activityTypeImage:
                      'https://i.pinimg.com/564x/93/f2/7a/93f27a7f4785ac818ef5e6bbcfc83353.jpg',

                          activityType:videoModel.type ,
                          authorName: videoModel.submitted_by.toString(), created_at: videoModel.upload_date,

                          activitySummary:
                          videoModel.description,
                          ActivityObject:  VideoModel.fromMap(e)

                      );
                      myActivities.add(activityModel);

                    });

                  }
                }
                break;
                case "review_news": {
                  activityResult.clear();
                  activityResult =  data[k];
                  if(activityResult.isNotEmpty){
                    activityResult.forEach((e) {
                      NewsModel newsModel = NewsModel.fromMap(e);

                      activityModel = new ActivityModel(activityTypeImage:
                      newsModel.photo_url!,

                          activityType:newsModel.type ,
                          authorName: newsModel.submitted_by.toString(), created_at: newsModel.created_at!,

                          activitySummary:
                          newsModel.description!,
                          ActivityObject:  NewsModel.fromMap(e));

                      myActivities.add(activityModel);

                    });

                  }
                }
                break;

                case "review_prisoners": {
                  activityResult.clear();
                  activityResult =  data[k];
                  if(activityResult.isNotEmpty){
                    activityResult.forEach((e) {
                      PrisonerModel prisonerModel = PrisonerModel.fromMap(e);
                      myActivities.add((ActivityModel(activityTypeImage:
                      prisonerModel.photo_url!,

                          activityType:prisonerModel.type ,
                          authorName: prisonerModel.submitted_by.toString(), created_at: prisonerModel.created_at!,

                          activitySummary:
                              prisonerModel.life_story??''
                          ,
                          ActivityObject:  prisonerModel

                      )));

                    });

                  }
                }
                break;

                case "review_villages": {
                  activityResult.clear();
                  activityResult =  data[k];
                  if(activityResult.isNotEmpty){

                    activityResult.forEach((e) {
                  VillageModel villageModel = VillageModel.fromMap(e);
                      myActivities.add((ActivityModel(activityTypeImage:
                      villageModel.image_url!,

                          activityType:villageModel.type ,
                          authorName: villageModel.submitted_by.toString(), created_at: villageModel.created_at!,

                          activitySummary:
                          villageModel.historical_context!,
                          ActivityObject:  villageModel

                      )));

                    });

                  }
                }
                break;


                default: {

                }
                break;
              }
            });


          });

    }

    on Error catch (e) {
      print('Get All Users Activities Error: $e');
    }


    return myActivities;
  }


  void AcceptActivities({
    required BuildContext context,
    required String userId,
    required String activityID,
    required String tableName,
  }) async {
    final userToken =
        Provider.of<UserProvider>(context, listen: false).user.token;
    print("$userId , $activityID  , $tableName  , ,$userToken");
    try {
      showDialogLoader(context);
      http.Response res = await http
          .post(
        Uri.parse('$uri/accept'),
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8",
          'Authorization' : userToken
        },
        body: jsonEncode({
          'userId': userId,
          'id': activityID,
          'table': tableName,
        }),
      )
          .timeout(const Duration(seconds: 25));

      Navigator.of(context, rootNavigator: true).pop('dialog');
      if (res.statusCode == 200) {

        final data = jsonDecode(res.body);


        // Store token securely (e.g., in shared preferences or secure storage)
        print('message: $data');
        statusCodeHandler(
            context: context,
            response: res,
            onSuccess: () async {

              AppRouter.appRouter.goToWidgetAndReplace(Home());
              showAlertMessage(
                  context: context,
                  title: "Accept Success",
                  message:'message: $data',
                  onTap: () {
                    AppRouter.appRouter.hideDialoug()  ;
                  });


            });
      } else {
        final data = jsonDecode(res.body);
        final message = data['message'];
        print('$message   ${res.statusCode}');
        // Handle error (e.g., show error message)
        //AppRouter.appRouter.showCustomDialoug("Error Failed!!", "$message");

      }
    }  catch (e) {
      print(' Error: $e');
    }
  }
  void DeclineActivities({
    required BuildContext context,
    required String userId,
    required String activityID,
    required String tableName,
  }) async {
    final userToken =
        Provider.of<UserProvider>(context, listen: false).user.token;
    print("$userId , $activityID  , $tableName  , ,$userToken");
    try {
      showDialogLoader(context);
      http.Response res = await http
          .post(
        Uri.parse('$uri/decline'),
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8",
          'Authorization' : userToken
        },
        body: jsonEncode({
          'userId': userId,
          'id': activityID,
          'table': tableName,
        }),
      )
          .timeout(const Duration(seconds: 25));

      Navigator.of(context, rootNavigator: true).pop('dialog');
      if (res.statusCode == 200) {

        final data = jsonDecode(res.body);


        // Store token securely (e.g., in shared preferences or secure storage)
        print('message: $data');
        statusCodeHandler(
            context: context,
            response: res,
            onSuccess: () async {

              AppRouter.appRouter.goToWidgetAndReplace(Home());
              showAlertMessage(
                  context: context,
                  title: "decline Success",
                  message:'message: $data',
                  onTap: () {
                    AppRouter.appRouter.hideDialoug()  ;
                  });

            });
      } else {
        final data = jsonDecode(res.body);
        final message = data['message'];
        print('$message   ${res.statusCode}');
        // Handle error (e.g., show error message)
        //AppRouter.appRouter.showCustomDialoug("Error Failed!!", "$message");

      }
    }  catch (e) {
      print(' Error: $e');
    }
  }
}
