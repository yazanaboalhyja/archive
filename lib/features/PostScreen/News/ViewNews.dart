
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:palestine_archive/app_router/app_router.dart';

import '../../../components/ShimmerScreen.dart';
import '../../../components/breaking_news.dart';
import '../../../components/news_of_day.dart';



class webViewNewScreen extends StatelessWidget {
  const webViewNewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,

          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: <Widget>[

            new IconButton(

              onPressed: () {
                AppRouter.appRouter.hideDialoug();
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              ),
            ),
          ],
        ),


        extendBodyBehindAppBar: true,

        body:  Center(
          child: Container(
            width: MediaQuery.of(context).size.width*0.5,
            child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 350),
                child: ShimmerScreen(
                  enabled: true,
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children:  [
                      NewsOfTheDay(),
                      BreakingNews(),
                    ],
                  ),
                )

            ),
          ),
        )
    );
  }
}
