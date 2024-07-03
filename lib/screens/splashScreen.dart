


import 'package:flutter/material.dart';
import 'package:palestine_archive/app_router/app_router.dart';
import 'package:palestine_archive/auth/provider.dart';
import 'package:palestine_archive/screens/Welcome.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../config/routes/router.dart';
import '../config/theme/theme_manager.dart';
import '../features/auth/providers/user_provider.dart';
import '../features/auth/screens/login_screen.dart';
import '../features/auth/services/auth_service.dart';
import '../widgets/circular_loader.dart';
import '../widgets/home.dart';



class SplachScreen extends StatelessWidget {

  navigationFun(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 3));
    AppRouter.appRouter.goToWidgetAndReplace( !ResponsiveBreakpoints.of(context).isMobile?LoginScreen():WelcomePage());
   // Provider.of<AppProvider>(context, listen: false).checkUser();
  //  Provider.of<AppProvider>(context, listen: false).intialSharedPref();
  }

  @override
  Widget build(BuildContext context) {

    navigationFun(context);
    // TODO: implement build
    return
      Scaffold(

          body:
          Container(

            decoration: const BoxDecoration(
              color: Colors.amber,
            )
            ,
            child: Center(
              child: SizedBox(
                  width: MediaQuery.of(context).size.width*0.25,
                  height: MediaQuery.of(context).size.height*0.25,
                  child: Image(image: AssetImage('assets/icons/ic_launcher.png'),)),
            ),
          ));
  }
}

