import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:palestine_archive/app_router/app_router.dart';

import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../config/routes/custom_push_navigators.dart';
import '../../../core/error/error_handler.dart';
import '../../../core/utils/custom_dialogs.dart';
import '../../../core/utils/global_constants.dart';
import '../../../widgets/home.dart';
import '../../PostScreen/Martyrs/Martyrs_screen.dart';
import '../providers/user_provider.dart';


class AuthService {
  final String url = 'http://127.0.0.1:3000';

  var headers = <String, String>{
    'Content-Type': 'application/json; charset=UTF-8',
  };

  void loginInAdmin({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      showDialogLoader(context);
      http.Response res = await http
          .post(
            Uri.parse('$uri/signin_admin'),
            headers: <String, String>{
              "Content-Type": "application/json; charset=UTF-8",
            },
            body: jsonEncode({
              'username': email,
              'password': password,
            }),
          )
          .timeout(const Duration(seconds: 25));

      Navigator.of(context, rootNavigator: true).pop('dialog');
     if (res.statusCode == 200) {

        final data = jsonDecode(res.body);
        final token = data['token'];
        final emailVerified = data['emailVerified'];

        headers = <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization' : token
        };
        // Store token securely (e.g., in shared preferences or secure storage)
        print('Token: $token');
        print('emailVerified: $emailVerified');
        statusCodeHandler(

            context: context,
            response: res,
            onSuccess: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              Provider.of<UserProvider>(context, listen: false).setUser(res.body);
              await prefs.setString(
                  'x-auth-token', token);
              AppRouter.appRouter.goToWidgetAndReplace(Home())  ;


            });
      }
    else {
        final data = jsonDecode(res.body);
        final message = data['message'];
        print('$message   ${res.statusCode}');
        showErrorMessage(
            context: context,
            title: "Login Failde",
            message:'message: $data',
            onTap: () {
              AppRouter.appRouter.hideDialoug()  ;
            });


     }
    }  catch (e) {
      print('Login Error: $e');
    }
  }
  Future SignIn(BuildContext context,String username,String password) async {

    try {
    showDialogLoader(context);
      http.Response res = await http
          .post(
        Uri.parse('$url/signin'),
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8",
        },
        body: jsonEncode({
          'username': username,
          'password': password,
        }),
      )
          .timeout(const Duration(seconds: 25));

     Navigator.of(context, rootNavigator: true).pop('dialog');
      if (res.statusCode == 200) {

        final data = jsonDecode(res.body);
        final token = data['token'];
        final emailVerified = data['emailVerified'];

         headers = <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization' : token
      };
        // Store token securely (e.g., in shared preferences or secure storage)
        print('Token: $token');
        print('emailVerified: $emailVerified');
      statusCodeHandler(
          context: context,
          response: res,
          onSuccess: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
           Provider.of<UserProvider>(context, listen: false).setUser(res.body);
            await prefs.setString(
                'x-auth-token', token);
AppRouter.appRouter.goToWidgetAndReplace(Home())  ;


          });
    } else {
    final data = jsonDecode(res.body);
    final message = data['message'];
    print('$message   ${res.statusCode}');
    // Handle error (e.g., show error message)
    //AppRouter.appRouter.showCustomDialoug("Error Failed!!", "$message");

    }
    }

    catch (e) {
      print('Login Error: $e');
    }



  }
  Future obtainTokenAndUserData(
    BuildContext context,
  ) async {
    try {
      //showDialogLoader(context);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? authToken = prefs.getString('x-auth-token');

      if (authToken == null) {
        prefs.setString('x-auth-token', '');
      }

      var returnedTokenResponse = await http.post(Uri.parse('$uri/checkToken'),
          headers: <String, String>{
            "Content-Type": "application/json; charset=UTF-8",
            'x-auth-token': authToken!
          });
      //the response will supply us with true or false according to the tokenIsValid api
      var response = jsonDecode(returnedTokenResponse.body);

      if (response == true) {
        //get user data

        http.Response returnedUserResponse =
            await http.get(Uri.parse('$uri/'), headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8",
          'x-auth-token': authToken,
        });

        var userProvider = Provider.of<UserProvider>(
          context,
          listen: false,
        );
        userProvider.setUser(returnedUserResponse.body);
        //Navigator.of(context, rootNavigator: true).pop('dialog');
      }
      return response;
    } catch (e) {
      print(e);
    }
  }
}
