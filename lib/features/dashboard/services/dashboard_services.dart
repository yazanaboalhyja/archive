import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:provider/provider.dart';

import '../../../core/error/error_handler.dart';
import '../../../core/utils/global_constants.dart';
import '../../auth/providers/user_provider.dart';

class DashBoardServices {

  Future<List<int>> getTotalDashboard({
    required BuildContext context,
  }) async {

    int totalNumberOfMartyrs = 0;
    int totalNumberOfPrisoner = 0 , totalNumberOfUser =0 , totalNumberOfNews=0 ;
  int totalNumberOfVideos = 0 , totalNumberOfVillages =0 ,
    totalNumberOfVerifiedAccounts=0  , totalNumberOfUnVerifiedAccounts=0;
    final userToken =
        Provider.of<UserProvider>(context, listen: false).user.token;
    print(userToken);
    try {
      final res = await http.get(
        Uri.parse('$uri/dashboard'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization' : userToken
        }
        // Correctly insert the id into the URL
      ).timeout(const Duration(seconds: 25));
      //Navigator.of(context, rootNavigator: true).pop('dialog');
      print(res.statusCode);
      // ignore: use_build_context_synchronously
     /* if(res.statusCode==403){
       Provider.of<UserProvider>(context, listen: false).setUser(
           Provider.of<UserProvider>(context, listen: false).user.toJson().replaceAll('}', ',"type":"user"}'));
       print(Provider.of<UserProvider>(context, listen: false).user.toJson()+'/////////');

      }
      else{
        Provider.of<UserProvider>(context, listen: false).setUser(
            Provider.of<UserProvider>(context, listen: false).user.toJson().replaceAll('}', ',"type":"Admin"}'));
      }*/
      statusCodeHandler(
          context: context,
          response: res,
          onSuccess: () {
            totalNumberOfMartyrs = jsonDecode(res.body)["total_martyrs"];//
           totalNumberOfPrisoner= jsonDecode(res.body)["total_prisoners"];//
            totalNumberOfVideos = jsonDecode(res.body)["total_videos"];
            totalNumberOfVillages= jsonDecode(res.body)["total_villages"];
            totalNumberOfNews= jsonDecode(res.body)["total_news"];
            totalNumberOfUser= jsonDecode(res.body)["total_users"];
            totalNumberOfVerifiedAccounts = jsonDecode(res.body)["verified_accounts"];
            totalNumberOfUnVerifiedAccounts = jsonDecode(res.body)["unverified_accounts"];

          });
    }

    on Error catch (e) {
      print('Get All Admin Dashboard Error: $e');
    }
    List<int> TotalDashBoard =[
      totalNumberOfMartyrs,
      totalNumberOfPrisoner,
      totalNumberOfUser,
      totalNumberOfNews,
      totalNumberOfVideos,
      totalNumberOfVillages,
      totalNumberOfVerifiedAccounts,
      totalNumberOfUnVerifiedAccounts,
    ];
    return TotalDashBoard;
  }


}
