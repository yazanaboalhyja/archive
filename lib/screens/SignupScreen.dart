import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:palestine_archive/app_router/app_router.dart';
import 'package:palestine_archive/screens/Welcome.dart';
import 'package:provider/provider.dart';

import '../auth/provider.dart';
import '../components/My_Button.dart';
import '../components/My_Text_Feild.dart';
import 'EmailVerification.dart';

class Signup extends StatelessWidget {
  Signup({super.key});

  // text editing controllers
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  double _sigmaX = 5; // from 0-10
  double _sigmaY = 5; // from 0-10
  double _opacity = 0.2;
  double _width = 350;
  double _height = 300;
  //final _formKey = GlobalKey<FormState>();



  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(builder: (context, provider, x) {
      return Scaffold(
        backgroundColor: Colors.grey[300],
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
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
                    SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                    IconButton(
                      icon: const Icon(Icons.arrow_back_ios),
                      color: Colors.white,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.18),
                     Text("signup".tr(),
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 40,
                            fontWeight: FontWeight.bold)),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                    ClipRect(
                      child: BackdropFilter(
                        filter:
                            ImageFilter.blur(sigmaX: _sigmaX, sigmaY: _sigmaY),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                              color: const Color.fromRGBO(0, 0, 0, 1)
                                  .withOpacity(_opacity),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(30))),
                          width: MediaQuery.of(context).size.width * 0.9,
                          height: MediaQuery.of(context).size.height * 0.58,
                          child: Form(
                            key: provider.signUpKey,
                            child: Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  const Text(
                                      "Look like you don't have an account. Let's create a new account",
                                      // ignore: prefer_const_constructors
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20),
                                      textAlign: TextAlign.start),
                                  SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.01),
                                  MyTextField(
                                    controller:
                                        provider.registerEmailController,
                                    hintText: 'email'.tr(),
                                    obscureText: false,
                                  ),
                                  SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.01),
                                  MyTextField(
                                    controller: provider.userNameController,
                                    hintText: 'full_name'.tr(),
                                    obscureText: false,
                                  ),
                                  SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.01),
                                  MyTextField(
                                    controller: provider.userPhoneController,
                                    keyType: TextInputType.number,
                                    hintText: 'phone'.tr(),
                                    obscureText: false,
                                  ),
                                  SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.01),
                                  MyPasswordTextField(
                                    controller:
                                        provider.passwordRegisterController,
                                    hintText: 'password'.tr(),
                                    obscureText: true,
                                  ),
                                  SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.01),
                                  Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.00005),
                                      MyButtonAgree(
                                        text: "continue".tr(),
                                        onTap: (() async {
                                          if (provider.signUpKey.currentState!
                                              .validate()) {
                                            // await SignIn(provider.loginEmailController.text,provider.passwordLoginController.text);
                                            await provider.SignUp();
                                          } else {
                                            print('not valid');
                                          }
                                        }),
                                      ),
                                    ],
                                  ),
                                ],
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
          ),
        ),
      );
    });
  }
}
