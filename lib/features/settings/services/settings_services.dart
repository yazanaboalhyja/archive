import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:provider/provider.dart';

import '../../../config/routes/custom_push_navigators.dart';
import '../../../core/error/error_handler.dart';
import '../../../core/utils/custom_dialogs.dart';
import '../../../core/utils/global_constants.dart';
import '../../auth/providers/user_provider.dart';

class SettingsServices {
  void createAdmin({
    required BuildContext context,
    required String email,

  }) async {
    final userToken =
        Provider.of<UserProvider>(context, listen: false).user.token;
    try {
      showDialogLoader(context);
      http.Response res = await http
          .post(
            Uri.parse('$uri/addAdmin'),
            headers: <String, String>{
              "Content-Type": "application/json; charset=UTF-8",
              "Authorization": userToken,
            },
            body: jsonEncode({
              'email': email,

            }),
          )
          .timeout(const Duration(seconds: 25));

      Navigator.of(context, rootNavigator: true).pop('dialog');

      statusCodeHandler(
          context: context,
          response: res,
          onSuccess: () {
            print(res.statusCode);
            showAlertMessage(
                context: context,
                title: "Success",
                message: jsonDecode(res.body)["message"],
                onTap: () {
                  popNav(context);
                });
          });
    } on Error catch (e) {
      print('Create Admin Error: $e');
    }
  }


  void deleteAdminOrUser({
    required BuildContext context,
    required String username,
  }) async {
    final userToken =
        Provider.of<UserProvider>(context, listen: false).user.token;
    try {
      showDialogLoader(context);
      http.Response res = await http
          .post(
            Uri.parse('$uri/delete-admin'),
            headers: <String, String>{
              "Content-Type": "application/json; charset=UTF-8",
              "Authorization": userToken,

            },
            body: jsonEncode({
              'email': username,
            }),
          )
          .timeout(const Duration(seconds: 25));

      Navigator.of(context, rootNavigator: true).pop('dialog');

      statusCodeHandler(
          context: context,
          response: res,
          onSuccess: () {
            showAlertMessage(
                context: context,
                title: "Success",
                message: jsonDecode(res.body)["message"],
                onTap: () {
                  popNav(context);
                });
          });
    } on Error catch (e) {
      print('Delete Admin Error: $e');
    }
  }

  void changeAdminAuthorizationPin({
    required BuildContext context,
    required String oldAdminAuthPin,
    required String newAdminAuthPin,
    required String admin,
  }) async {
    final userToken =
        Provider.of<UserProvider>(context, listen: false).user.token;
    try {
      showDialogLoader(context);
      http.Response res = await http
          .delete(
            Uri.parse('$uri/admin/deleteUser'),
            headers: <String, String>{
              "Content-Type": "application/json; charset=UTF-8",
              "x-auth-token": userToken,
            },
            body: jsonEncode({
              'username': oldAdminAuthPin,
              'authorizationPin': newAdminAuthPin,
              "admin": admin,
            }),
          )
          .timeout(const Duration(seconds: 25));

      Navigator.of(context, rootNavigator: true).pop('dialog');

      statusCodeHandler(
          context: context,
          response: res,
          onSuccess: () {
            showAlertMessage(
                context: context,
                title: "Success",
                message: jsonDecode(res.body)["message"],
                onTap: () {
                  popNav(context);
                });
          });
    } on Error catch (e) {
      print('Delete Admin or User Pin Error: $e');
    }
  }
}
