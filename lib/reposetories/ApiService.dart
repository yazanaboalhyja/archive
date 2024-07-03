import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:palestine_archive/Models/ActivityModel.dart';
import 'package:palestine_archive/Models/NewsModel.dart';
import 'package:palestine_archive/Models/VideoModel.dart';
import 'package:palestine_archive/Models/VillageModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Models/MartyrModel.dart';
import '../Models/PrisonerModel.dart';
import '../Models/UserModel.dart';
import '../app_router/app_router.dart';
import '../core/utils/custom_dialogs.dart';
import '../screens/EmailVerification.dart';
import '../screens/MainScreen.dart';
import '../screens/Welcome.dart';


class ApiService {
  ApiService._();

  static ApiService apiHelper = ApiService._();

  final String url = 'http://10.0.2.2:3000';

  var headers = <String, String>{
    'Content-Type': 'application/json; charset=UTF-8',
  };
  List<UserModel> AllAppUser = [];

  Future<UserModel?> SignIn(String username,String password) async {


    final response = await http.post(
      Uri.parse(url+'/signin'),
      headers: headers,
      body: jsonEncode(<String, String>{
        'username': username,
        'password': password,
      }),
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final token = data['token'];
      final emailVerified = data['emailVerified'];

       headers = <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization' : token
      };
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString(
          'auth-token', token);
      print('Token: $token');
      print('emailVerified: $emailVerified');
      // Navigate to next screen or perform desired action
     if(emailVerified){
      AppRouter.appRouter.goToWidgetAndReplace(MainScreen());
      return(UserModel.fromJson(data));
     }
     else{
     AppRouter.appRouter.showCustomDialoug("Your email not verified ","Please verified your email to start your journey in Palestine Archive");
    }
    } else {
      final data = jsonDecode(response.body);
      final message = data['message'];
      // Handle error (e.g., show error message)
      AppRouter.appRouter.showCustomDialoug("Error Failed!!", "$message");

    }
    return null;
  }

  Future<void> SignUp(String email,String password ,  String phone , String name) async {

    final response = await http.post(
      Uri.parse(url+'/signup'),
      headers: headers,
      body: jsonEncode(<String, String>{
        'username': email,
        'password': password,
        'name': name,
        'phone_number': phone,
      }),
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
        AppRouter.appRouter.goToWidgetAndReplace(EmailVerificationPage(email : email));
    } else {
      final data = jsonDecode(response.body);
      final message = data['message'];
      // Handle error (e.g., show error message)
      AppRouter.appRouter.showCustomDialoug("Error Failed!!", "$message");
    }
  }
  Future<void> AddPrisoner(String dateOfBirth, String placeOfBirth, String lifeStory,
      String dateOfArrest , String name , String photoUrl,[String? WebURL , BuildContext? context]) async {

var request = http.MultipartRequest('POST', WebURL==null?Uri.parse(url+'/addprisoners'):
Uri.parse(WebURL+'/addprisoners')
  ,)..files.add(
  await http.MultipartFile.fromPath(
    'photo',
    photoUrl,
    filename:
    'image_$name.webp',
  ),
);
request.headers.addAll(headers);
    request.fields['name'] = name;
    request.fields['lifeStory'] = lifeStory;
    request.fields['dateOfBirth'] = dateOfBirth;
    request.fields['placeOfBirth'] = placeOfBirth;
    request.fields['dateOfArrest'] = dateOfArrest;
    var res = await request.send();
    //return res.statusCode;*/
    if (res.statusCode == 200) {
      //final data = jsonDecode(res.body);
      context==null ? AppRouter.appRouter.showCustomDialoug
        ("بانتظار الموافقة..",
          "تم إرسال منشورك إلى المدير لمراجعنه سيتم إنذارك في حال الموافقة عليه..."):
      showAlertMessage(context: context, title: "بانتظار الموافقة..", message: "تم إرسال منشورك إلى المدير لمراجعنه سيتم إنذارك في حال الموافقة عليه...", onTap: ()=>AppRouter.appRouter.hideDialoug());

      ;
    } else {
      //final data = jsonDecode(res.);
     // final message = data['message'];
      // Handle error (e.g., show error message)
     context==null ?AppRouter.appRouter.showCustomDialoug("Error Failed!!", ""):
    showErrorMessage(
    context: context!,
    title: "خطأ في البياتات",
    message:'',
    onTap: () {
    AppRouter.appRouter.hideDialoug()  ;
    });
    ;
    }
  }

  Future<void> AddMartyr(String dateOfBirth, String deathStory,
      String dateOfDeath , String name ,String nationality,String placeOfDeath,
       String cause_of_death,String photoUrl , [String? webURl]) async {
    print( File(photoUrl).readAsBytesSync().toString()+'5555555555');

    var request = http.MultipartRequest('POST',webURl==null? Uri.parse(url+'/add_martyrs'):

    Uri.parse(webURl+'/add_martyrs')
      ,)..files.add(
      webURl==null?await http.MultipartFile.fromPath(
        'photo',
        photoUrl,
        filename:
        'image_$name.webp',
      ):
      await http.MultipartFile.fromBytes(
        'photo',
        (await rootBundle.load(photoUrl)).buffer.asUint8List(),
        filename:
        'image_$name.webp',
      ),
    );

    request.headers.addAll(headers);
    request.fields['full_name'] = name;
    request.fields['cause_of_death'] = cause_of_death;
    request.fields['description'] = deathStory;
    request.fields['place_of_death'] = placeOfDeath;
    request.fields['date_of_birth'] = dateOfBirth;
    request.fields['date_of_death'] = dateOfDeath;

    request.fields['nationality'] = nationality;

    var res = await request.send();
    //return res.statusCode;*/
    if (res.statusCode == 200) {
      //final data = jsonDecode(res.body);
      AppRouter.appRouter.showCustomDialoug
        ("بانتظار الموافقة..",
          "تم إرسال منشورك إلى المدير لمراجعنه سيتم إنذارك في حال الموافقة عليه...");
    } else {
      //final data = jsonDecode(res.);
      // final message = data['message'];
      // Handle error (e.g., show error message)
      AppRouter.appRouter.showCustomDialoug("Error Failed!!", "");
    }
  }

  Future<void> AddVideo(String location, String description,
      String videoUrl) async {
    var request = http.MultipartRequest('POST', Uri.parse(url+'/addvid'),)..files.add(
      await http.MultipartFile.fromPath(
        'video',
        videoUrl,
        filename:
        'video_$videoUrl',
      ),
    );
    request.headers.addAll(headers);
    request.fields['location'] = location;
    request.fields['description'] = description;


    var res = await request.send();
    //return res.statusCode;*/
    if (res.statusCode == 200) {
      //final data = jsonDecode(res.body);
      AppRouter.appRouter.showCustomDialoug
        ("بانتظار الموافقة..",
          "تم إرسال منشورك إلى المدير لمراجعنه سيتم إنذارك في حال الموافقة عليه...");
    } else {
      //final data = jsonDecode(res.);
      // final message = data['message'];
      // Handle error (e.g., show error message)
      AppRouter.appRouter.showCustomDialoug("Error Failed!!", "");
    }
  }

  Future<MartyrModel> getMartyrById(int id ,[String? webURL]) async {
    final response = await http.get(
     webURL==null? Uri.parse('$url/martyrs/$id'):Uri.parse('$webURL/martyrs/$id'), // Correctly insert the id into the URL
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      // Assuming you have a MartyrModel.fromJson constructor
print(data);
      return MartyrModel.fromJson(data["item"]);
    } else {
      final data = jsonDecode(response.body);
      final message = data['message'];
      // Handle error (e.g., show error message)
      AppRouter.appRouter.showCustomDialoug("Error Failed!!", "$message");
      throw Exception("Failed to load martyr: $message");
    }
  }

  Future<PrisonerModel> getPrisonerById(int id,[String? webURL]) async {
    final response = await http.get(
      Uri.parse( webURL==null?'$url/prisoners/$id':'$webURL/prisoners/$id'), // Correctly insert the id into the URL
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      // Assuming you have a MartyrModel.fromJson constructor
      print(data);
      return PrisonerModel.fromJson(data["item"]);
    } else {
      final data = jsonDecode(response.body);
      final message = data['message'];
      // Handle error (e.g., show error message)
      AppRouter.appRouter.showCustomDialoug("Error Failed!!", "$message");
      throw Exception("Failed to load prisoner: $message");
    }
  }
  Future<VideoModel> getVideoById(int id ,[String? webURL] ) async {
    final response = await http.get(
      Uri.parse(webURL==null?'$url/videos/$id':'$webURL/videos/$id'), // Correctly insert the id into the URL
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      // Assuming you have a MartyrModel.fromJson constructor
      print(data);
      return VideoModel.fromJson(data["item"]);
    } else {
      final data = jsonDecode(response.body);
      final message = data['message'];
      // Handle error (e.g., show error message)
      AppRouter.appRouter.showCustomDialoug("Error Failed!!", "$message");
      throw Exception("Failed to load video: $message");
    }
  }
  Future<NewsModel> getNewsById(int id,[String? webURL]) async {
    final response = await http.get(
      webURL==null?Uri.parse('$url/news/$id'):Uri.parse('$webURL/news/$id'), // Correctly insert the id into the URL
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      // Assuming you have a MartyrModel.fromJson constructor
      print(data);
      return NewsModel.fromJson(data["item"]);
    } else {
      final data = jsonDecode(response.body);
      final message = data['message'];
      // Handle error (e.g., show error message)
      AppRouter.appRouter.showCustomDialoug("Error Failed!!", "$message");
      throw Exception("Failed to load news: $message");
    }
  }
  Future<VillageModel> getVillageById(int id,[String? webURL]) async {
    final response = await http.get(
      Uri.parse(webURL==null?'$url/villages/$id':'$webURL/villages/$id'), // Correctly insert the id into the URL
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      // Assuming you have a MartyrModel.fromJson constructor
      print(data);
      return VillageModel.fromJson(data["item"]);
    } else {
      final data = jsonDecode(response.body);
      final message = data['message'];
      // Handle error (e.g., show error message)
      AppRouter.appRouter.showCustomDialoug("Error Failed!!", "$message");
      throw Exception("Failed to load Village: $message");
    }
  }
  Future<void> DeleteActivity( String type , String id) async {
    final response = await http.delete(
      Uri.parse('$url/$type/$id'),
      headers: headers,
     // Correctly insert the id into the URL
    );

    if (response.statusCode == 200) {
      //final  data = jsonDecode(response.body);
      AppRouter.appRouter.showCustomDialoug("Delete Result", "Your Activity Deleted successfully");

    } else {
      final data = jsonDecode(response.body);
      final message = data['message'];
      // Handle error (e.g., show error message)
      AppRouter.appRouter.showCustomDialoug("Error Failed!!", "$message");
      throw Exception("Failed to load martyr: $message");
    }
  }
  Future<void> EditVideo( String videoId , String description) async {
    final response = await http.put(
      Uri.parse('$url/edit_video/$videoId'),
      headers: headers,

      body: jsonEncode(<String, String>{
        'description': description,
      }),

      // Correctly insert the id into the URL
    );

    if (response.statusCode == 200) {
      //final  data = jsonDecode(response.body);
      AppRouter.appRouter.showCustomDialoug("Update Result", "Your Activity Updated successfully");

    } else {
      final data = jsonDecode(response.body);
      final message = data['message'];
      // Handle error (e.g., show error message)
      AppRouter.appRouter.showCustomDialoug("Error Failed!!", "$message");
      throw Exception("Failed to Edit: $message");
    }
  }
  Future<void> EditPrisoner( String prisonerId , String date_of_arrest,
  String life_story
      ) async {
    final response = await http.put(
      Uri.parse('$url/edit_prisoners/$prisonerId'),
      headers: headers,

      body: jsonEncode(<String, String>{
        'date_of_arrest': date_of_arrest,
        'life_story': life_story,

      }),

      // Correctly insert the id into the URL
    );

    if (response.statusCode == 200) {
      //final  data = jsonDecode(response.body);
      AppRouter.appRouter.showCustomDialoug("Update Result", "Your Activity Updated successfully");

    } else {
      final data = jsonDecode(response.body);
      final message = data['message'];
      // Handle error (e.g., show error message)
      AppRouter.appRouter.showCustomDialoug("Error Failed!!", "$message");
      throw Exception("Failed to Edit: $message");
    }
  }
  Future<void> EditNews( String newsId , String description,
      String source
      ) async {
    final response = await http.put(
      Uri.parse('$url/edit_news/$newsId'),
      headers: headers,

      body: jsonEncode(<String, String>{
        'description': description,
        'source': source,

      }),

      // Correctly insert the id into the URL
    );

    if (response.statusCode == 200) {
      //final  data = jsonDecode(response.body);
      AppRouter.appRouter.showCustomDialoug("Update Result", "Your Activity Updated successfully");

    } else {
      final data = jsonDecode(response.body);
      final message = data['message'];
      // Handle error (e.g., show error message)
      AppRouter.appRouter.showCustomDialoug("Error Failed!!", "$message");
      throw Exception("Failed to Edit: $message");
    }
  }
  Future<void> EditVillage( String villageId , String historical_context,
      String current_status
      ) async {
    final response = await http.put(
      Uri.parse('$url/edit_village/$villageId'),
      headers: headers,

      body: jsonEncode(<String, String>{
        'historical_context': historical_context,
        'current_status': current_status,

      }),

      // Correctly insert the id into the URL
    );

    if (response.statusCode == 200) {
      //final  data = jsonDecode(response.body);
      AppRouter.appRouter.showCustomDialoug("Update Result", "Your Activity Updated successfully");

    } else {
      final data = jsonDecode(response.body);
      final message = data['message'];
      // Handle error (e.g., show error message)
      AppRouter.appRouter.showCustomDialoug("Error Failed!!", "$message");
      throw Exception("Failed to Edit: $message");
    }
  }
  Future<void> forgetPassword( String username) async {
    final response = await http.post(
      Uri.parse('$url/forgot-password'),
      headers: headers,
      body: jsonEncode(<String, String>{
        'username': username,
      }),// Correctly insert the id into the URL
    );

    if (response.statusCode == 200) {
      //final  data = jsonDecode(response.body);
      AppRouter.appRouter.showCustomDialoug("Check Your Email", "please check you email to reset your password");

    } else {
      final data = jsonDecode(response.body);
      final message = data['message'];
      // Handle error (e.g., show error message)
      AppRouter.appRouter.showCustomDialoug("Error Failed!!", "$message");
      throw Exception("Failed to load martyr: $message");
    }
  }

  Future<List<MartyrModel>> getMartyrs([String? webURL]) async {

    final response = await http.get(
      Uri.parse(webURL==null?'$url/martyrs':'$webURL/martyrs'), // Correctly insert the id into the URL
    );
    print(response.statusCode.toString()+'reeeeem');

    if (response.statusCode == 200) {
      final  data = jsonDecode(response.body);
      // Assuming you have a MartyrModel.fromJson constructo
      // r
      List martyrResult = data["martyrs"];
      List<MartyrModel> martyrPageView = [];
       print(data["martyrs"]);
      for(int i = 0 ;i<martyrResult.length;i++){
        martyrPageView.add(MartyrModel.fromJson(martyrResult[i]));

      }
      //List<MartyrModel> martyrToday = data["martyr"].toList().map((e) =>  MartyrModel.fromJson(e)).toList();
      return martyrPageView;
    } else {
      final data = jsonDecode(response.body);
      final message = data['message'];
      // Handle error (e.g., show error message)
      AppRouter.appRouter.showCustomDialoug("Error Failed!!", "$message");
      throw Exception("Failed to load martyr: $message");
    }
  }

  Future<List<PrisonerModel>> getPrisoners([String? webURL]) async {
    final response = await http.get(
      Uri.parse(webURL==null?'$url/prisoners':'$webURL/prisoners'), // Correctly insert the id into the URL
    );

    if (response.statusCode == 200) {
      final  data = jsonDecode(response.body);
      // Assuming you have a MartyrModel.fromJson constructo
      // r
      List prisonerResult = data["prisoners"];
      List<PrisonerModel> prisonerPageView = [];
      // print(jsonDecode(response.body)["martyrs"]);
      for(int i = 0 ;i<prisonerResult.length;i++){
        prisonerPageView.add(PrisonerModel.fromJson(prisonerResult[i]));

      }
      //List<MartyrModel> martyrToday = data["martyr"].toList().map((e) =>  MartyrModel.fromJson(e)).toList();
      return prisonerPageView;
    } else {
      final data = jsonDecode(response.body);
      final message = data['message'];
      // Handle error (e.g., show error messageAppRouter.appRouter.showCustomDialoug("Error Failed!!", "$message");
      throw Exception("Failed to load prisoner: $message");
    }
  }

  Future<List<NewsModel>> getNews([String? webURL]) async {
    final response = await http.get(
      Uri.parse(webURL==null?'$url/news':'$webURL/news'), // Correctly insert the id into the URL
    );

    if (response.statusCode == 200) {
      final  data = jsonDecode(response.body);
      // Assuming you have a MartyrModel.fromJson constructo
      // r
      print(data);
      List newsResult = data["news"];
      List<NewsModel> newsPageView = [];
      // print(jsonDecode(response.body)["martyrs"]);
      for(int i = 0 ;i<newsResult.length;i++){
        newsPageView.add(NewsModel.fromJson(newsResult[i]));

      }
      //List<MartyrModel> martyrToday = data["martyr"].toList().map((e) =>  MartyrModel.fromJson(e)).toList();
      return newsPageView;
    } else {
      final data = jsonDecode(response.body);
      final message = data['message'];
      // Handle error (e.g., show error message)
      AppRouter.appRouter.showCustomDialoug("Error Failed!!", "$message");
      throw Exception("Failed to load news: $message");
    }
  }
  Future<List<VillageModel>> getVillages([String? webURL]) async {
    final response = await http.get(
      Uri.parse(webURL==null?'$url/villages':'$webURL/villages'), // Correctly insert the id into the URL
    );

    if (response.statusCode == 200) {
      final  data = jsonDecode(response.body);
      // Assuming you have a MartyrModel.fromJson constructo
      // r
      List villagesResult = data["villages"];
      List<VillageModel> villagesPageView = [];
      // print(jsonDecode(response.body)["martyrs"]);
      for(int i = 0 ;i<villagesResult.length;i++){
        villagesPageView.add(VillageModel.fromJson(villagesResult[i]));

      }
      //List<MartyrModel> martyrToday = data["martyr"].toList().map((e) =>  MartyrModel.fromJson(e)).toList();
      return villagesPageView;
    } else {
      final data = jsonDecode(response.body);
      final message = data['message'];
      // Handle error (e.g., show error message)
      AppRouter.appRouter.showCustomDialoug("Error Failed!!", "$message");
      throw Exception("Failed to load villages: $message");
    }
  }

  Future<List<VideoModel>> getVideos([String? webURL]) async {
    final response = await http.get(
     webURL==null? Uri.parse('$url/videos'):Uri.parse('$webURL/videos')
      , // Correctly insert the id into the URL
    );

    if (response.statusCode == 200) {
      final  data = jsonDecode(response.body);
      // Assuming you have a MartyrModel.fromJson constructo
      // r
      List videosResult = data["videos"];
      List<VideoModel> videosPageView = [];
       print('Videos'+videosResult.toString());
      for(int i = 0 ;i<videosResult.length;i++){
        videosPageView.add(VideoModel.fromJson(videosResult[i]));

      }
      //List<MartyrModel> martyrToday = data["martyr"].toList().map((e) =>  MartyrModel.fromJson(e)).toList();
      return videosPageView;
    } else {
      final data = jsonDecode(response.body);
      final message = data['message'];
      // Handle error (e.g., show error message)
      AppRouter.appRouter.showCustomDialoug("Error Failed!!", "$message");
      throw Exception("Failed to load videos: $message");
    }
  }




  Future<List<MartyrModel>> getMartyrforToday() async {
    final response = await http.post(
      Uri.parse('$url/martyrs/today'), // Correctly insert the id into the URL
    );

    if (response.statusCode == 200) {
      final  data = jsonDecode(response.body);
      // Assuming you have a MartyrModel.fromJson constructo
      // r
      List martyrResult = data["martyrs"];
      List<MartyrModel> martyrToday = [];
     // print(jsonDecode(response.body)["martyrs"]);
      for(int i = 0 ;i<martyrResult.length;i++){
        martyrToday.add(MartyrModel.fromJson(martyrResult[i]));

      }
  //List<MartyrModel> martyrToday = data["martyr"].toList().map((e) =>  MartyrModel.fromJson(e)).toList();
      return martyrToday;
    } else {
      final data = jsonDecode(response.body);
      final message = data['message'];
      // Handle error (e.g., show error message)
      AppRouter.appRouter.showCustomDialoug("Error Failed!!", "$message");
      throw Exception("Failed to load martyr: $message");
    }
  }
  Future<List<ActivityModel>> getMyActivities() async {
    final response = await http.post(
      Uri.parse('$url/profile'),
      headers: headers
      // Correctly insert the id into the URL
    );

    if (response.statusCode == 200) {
      final  data = jsonDecode(response.body);
      // Assuming you have a Mart
      // yrModel.fromJson constructo
      // r
      print(data);
      List<ActivityModel> myActivities = [];
      List activityResult =  [];
      late ActivityModel activityModel  ;
      data.forEach((k,v) {
        print('${k}: ${v}');
        switch(k) {
          case "martyrs": {
            // statements;
            activityResult.clear();
            activityResult =  data[k];
            if(activityResult.isNotEmpty){

              activityResult.forEach((e) {
                MartyrModel martyrModel = MartyrModel.fromMap(e);

                activityModel =ActivityModel(activityTypeImage:
                e['file_url']?? martyrModel.image_url,
                    activityType:martyrModel.type ,
                    authorName: martyrModel.submitted_by_name!,
                    created_at: martyrModel.created_at!,

                    activitySummary:
                    martyrModel.description,
                    ActivityObject:  martyrModel);

                myActivities.add(activityModel);

              });
            }
          }
          break;

          case "videos": {
            activityResult.clear();
            activityResult =  data[k];
            if(activityResult.isNotEmpty){
              activityResult.forEach((e) {
                VideoModel videoModel = VideoModel.fromMap(e);

                activityModel =ActivityModel(activityTypeImage:
                'https://i.pinimg.com/564x/93/f2/7a/93f27a7f4785ac818ef5e6bbcfc83353.jpg',

                    activityType:videoModel.type ,
                    authorName: videoModel.submitted_by_name!,
                    created_at: videoModel.upload_date,

                    activitySummary:
                    videoModel.description,
                    ActivityObject:  VideoModel.fromMap(e)

                );
                myActivities.add(activityModel);

              });

            }
          }
          break;
          case "news": {
            activityResult.clear();
            activityResult =  data[k];
            if(activityResult.isNotEmpty){
              activityResult.forEach((e) {
                NewsModel newsModel = NewsModel.fromMap(e);

                activityModel = new ActivityModel(activityTypeImage:
                e['file_url']??newsModel.photo_url!,

                    activityType:newsModel.type ,
                    authorName: newsModel.submitted_by_name!,
                    created_at: newsModel.created_at!,

                    activitySummary:
                    newsModel.description!,
                    ActivityObject:  newsModel);

                    myActivities.add(activityModel);

              });

            }
          }
          break;

          case "prisoners": {
            activityResult.clear();
            activityResult =  data[k];
            if(activityResult.isNotEmpty){
              activityResult.forEach((e) {
                PrisonerModel prisonerModel = PrisonerModel.fromMap(e);

                myActivities.add((ActivityModel(activityTypeImage:
                e['file_url']??prisonerModel.photo_url!,

                    activityType:prisonerModel.type ,
                    authorName: prisonerModel.submitted_by_name!,
                    created_at: prisonerModel.created_at!,
                    activitySummary:
                    prisonerModel.life_story!,
                    ActivityObject:  prisonerModel

                )));

              });

            }
          }
          break;

          case "villages": {
            activityResult.clear();
            activityResult =  data[k];
            if(activityResult.isNotEmpty){

              activityResult.forEach((e) {
                VillageModel villageModel = VillageModel.fromMap(e);
               print(e['file_url']);
                myActivities.add((ActivityModel(activityTypeImage:
                e['file_url']??villageModel.image_url!,

                    activityType:villageModel.type ,
                    authorName: villageModel.submitted_by_name!, created_at: villageModel.created_at!,

                    activitySummary:
                    villageModel.historical_context! ,
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
      }
      );
     return myActivities;
    } else {
      final data = jsonDecode(response.body);
      final message = data['message'];
      // Handle error (e.g., show error message)
      AppRouter.appRouter.showCustomDialoug("Error Failed!!", "$message");
      throw Exception("Failed to load activities: $message");
    }
  }
  Future<Map<String,dynamic>> getAnswer(String question) async {
    final response = await http.post(
      Uri.parse('$url/ask'),
      headers: headers,
      body: jsonEncode(<String, String>{
        'question': question,
      }),// Correctly insert the id into the URL
    );

    if (response.statusCode == 200) {
      final  data = jsonDecode(response.body);

      String answer = data["answer"];
      Map<String,dynamic> answerMap = {
        "chat":1,
        "message" :answer,
        "time" : "${DateTime.now().hour.toString()}:${DateTime.now().minute.toString()}"
      };

      return answerMap;
    } else {
      final data = jsonDecode(response.body);
      final message = data['message'];
      // Handle error (e.g., show error message)
     // AppRouter.appRouter.showCustomDialoug("Error Failed!!", "$message");
      Map<String,dynamic> answerMap = {
        "chat":1,
        "message" :"$message",
        "time" : "${DateTime.now().hour.toString()}:${DateTime.now().minute.toString()}"
      };
      return answerMap;
      //throw Exception("Failed to load martyr: $message");
    }
  }
  Future<void> AddNewVillage(String name,
      String city,  String historical_context ,String current_status, String photoUrl) async {
    var request = http.MultipartRequest('POST', Uri.parse(url+'/add_village'),)..files.add(
      await http.MultipartFile.fromPath(
        'photo',
        photoUrl,
        filename:
        'image_$name.webp',
      ),
    );
    request.headers.addAll(headers);
    request.fields['name'] = name;
    request.fields['city'] = city;
    request.fields['historical_context'] = historical_context;
    request.fields['current_status'] = current_status;

    var res = await request.send();
    //return res.statusCode;*/
    if (res.statusCode == 200) {
      //final data = jsonDecode(res.body);
      AppRouter.appRouter.showCustomDialoug
        ("بانتظار الموافقة..",
          "تم إرسال منشورك إلى المدير لمراجعنه سيتم إنذارك في حال الموافقة عليه...");
    } else {
      //final data = jsonDecode(res.);
      // final message = data['message'];
      // Handle error (e.g., show error message)
      AppRouter.appRouter.showCustomDialoug("Error Failed!!", "");
    }
  }
  Future<void> AddNewsReport(String name,
        String source ,String description,String type, String photoUrl ,[String? webURL]) async {
    var request = http.MultipartRequest('POST', webURL==null?Uri.parse(url+'/add_news')
        :Uri.parse(webURL+'/add_news'),)..files.add(
      await http.MultipartFile.fromPath(
        'photo',
        photoUrl,
        filename:
        'image_$name.webp',
      ),
    );
    request.headers.addAll(headers);
    request.fields['name'] = name;
    request.fields['source'] = source;
    request.fields['description'] = description;
    request.fields['type'] = type;

    var res = await request.send();
    //return res.statusCode;*/
    if (res.statusCode == 200) {
      //final data = jsonDecode(res.body);
      AppRouter.appRouter.showCustomDialoug
        ("بانتظار الموافقة..",
          "تم إرسال منشورك إلى المدير لمراجعنه سيتم إنذارك في حال الموافقة عليه...");
    } else {
      //final data = jsonDecode(res.);
      // final message = data['message'];
      // Handle error (e.g., show error message)
      AppRouter.appRouter.showCustomDialoug("Error Failed!!", "");
    }
  }
}
