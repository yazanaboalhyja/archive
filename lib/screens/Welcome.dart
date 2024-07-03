// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:palestine_archive/app_router/app_router.dart';
import 'package:palestine_archive/screens/DashBoard.dart';
import 'package:palestine_archive/screens/MainScreen.dart';
import 'package:http/http.dart' as http;
import 'package:palestine_archive/widgets/home.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../auth/provider.dart';
import '../components/My_Button.dart';
import '../components/My_Text_Feild.dart';
import '../components/ViewVillageScreen.dart';
import 'SignupScreen.dart';

class WelcomePage extends StatelessWidget {
  WelcomePage({super.key});

  double _sigmaX = 5; // from 0-10
  double _sigmaY = 5; // from 0-10
  double _opacity = 0.05;
  double _width = 350;
  double _height = 300;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SingleChildScrollView(
        child: Consumer<AppProvider>(builder: (context, provider, x) {
          return Container(
            height: 800,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Image.network(
                  'https://i.pinimg.com/564x/ad/a9/03/ada903c1da8177703a9c339c54f83604.jpg',
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  fit: BoxFit.cover,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height * 0.3),
                    const Text("Hi !",
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 40,
                            fontWeight: FontWeight.bold)),
                    // SizedBox(height: MediaQuery.of(context).size.height * 0.3),
                    Expanded(
                      child: ClipRect(
                        child: BackdropFilter(
                          filter: ImageFilter.blur(
                              sigmaX: _sigmaX, sigmaY: _sigmaY),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                                color: Color.fromRGBO(0, 0, 0, 1)
                                    .withOpacity(_opacity),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30))),
                            width: MediaQuery.of(context).size.width * 0.9,
                            height: MediaQuery.of(context).size.height * 0.6,
                            child: Form(
                              // key: _formKey,
                              key: provider.signInKey,
                              child: Center(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    // username textfield
                                    MyTextField(
                                      controller: provider.loginEmailController,
                                      hintText: 'email',
                                      obscureText: false,
                                    ),
                                    SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.03),
                                    MyPasswordTextField(
                                      controller:
                                          provider.passwordLoginController,
                                      hintText: 'password',
                                      obscureText: true,
                                    ),
                                    const SizedBox(height: 10),

                                    // sign in button
                                    MyButton(
                                      onTap: (() async {
                                        if (provider.signInKey.currentState!
                                            .validate()) {
                                          // await SignIn(provider.loginEmailController.text,provider.passwordLoginController.text);
                                          await provider.SignIn();
                                        } else {
                                          print('not valid');
                                        }
                                      }),
                                    ),
                                    TextButton(
                                        onPressed: () {

                                          provider.forgetPassword();
                                        },
                                        child: Row(children: [
                                          Text(
                                            'Forget Password?',
                                            style: TextStyle(
                                                color: Color(0xffeeac07),
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20),
                                          )
                                        ])),
                                    const SizedBox(height: 3),

                                    // or continue with
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Divider(
                                            thickness: 0.5,
                                            color: Colors.grey[400],
                                          ),
                                        ),
                                        const Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10.0),
                                          child: Text(
                                            'Or',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16),
                                          ),
                                        ),
                                        Expanded(
                                          child: Divider(
                                            thickness: 0.5,
                                            color: Colors.grey[400],
                                          ),
                                        ),
                                      ],
                                    ),

                                    const SizedBox(height: 10),

                                    // not a member? register now
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            // ignore: prefer_const_literals_to_create_immutables
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  'Don\'t have an account?',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 20),
                                                  textAlign: TextAlign.start,
                                                ),
                                              ),
                                              // const SizedBox(width: 4),

                                              Expanded(
                                                child: TextButton(
                                                    onPressed: () {
                                                      AppRouter.appRouter
                                                          .goToWidget(Signup());
                                                    },
                                                    child: Text(
                                                      'Sign Up',
                                                      style: TextStyle(
                                                          color:
                                                              Color(0xffeeac07),
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 20),
                                                    )),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.01),
                                          TextButton(
                                            onPressed: () {
                                              AppRouter.appRouter.goToWidgetAndReplace(MainScreen());
                                            },
                                            child: const Text('Login As Visitor',
                                                style: TextStyle(
                                                    color: Color(0xffeeac07),
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20),
                                                textAlign: TextAlign.start),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          );
        }),
      ),
    );
  }

}
