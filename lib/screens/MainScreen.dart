import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:palestine_archive/screens/AddNewMartyrOrPrisoner.dart';
import 'package:palestine_archive/screens/AddPressNewsOrVillage.dart';
import 'package:palestine_archive/screens/AiChatScreen.dart';
import 'package:provider/provider.dart';

import '../app_router/app_router.dart';
import '../auth/provider.dart';
import '../core/utils/color_constants.dart';
import 'AddNewVedio.dart';
import 'DashBoard.dart';
import 'PalestineAtlas.dart';
import 'ProfileScreen.dart';
import 'VedioPreview.dart';




class MainScreen extends StatefulWidget {
  MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final _pageController = PageController();

int pageindex = 0;

  @override
  void dispose() {
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Scaffold(
        floatingActionButton:Provider.of<AppProvider>(context).DbloggedUser.username!=''? Padding(
          padding: const EdgeInsets.only(bottom: 15.0),
          child:  FloatingActionButton(

            backgroundColor: const Color(0xffeeac07),
            tooltip: 'chat_bot'.tr(),
            onPressed: (){
              pageindex!=2&& pageindex!=3?
              AppRouter.appRouter.goToWidget(ChatPage()):
              pageindex==3?
              AppRouter.appRouter.goToWidget(AddNewVediorPage()):
              AppRouter.appRouter.goToWidget(AddPressNewsOrVillagePage(false))
              ;

            },
            child: pageindex!=2 && pageindex!=3? Icon(Icons.chat, color: Colors.white, size: 28):
            Icon(Icons.add, color: Colors.white, size: 28),
          ),
        ):SizedBox(),
          appBar: AppBar(
            centerTitle: true,
            title: Text('palestine_archive'.tr() , style: TextStyle(color: !Provider.of<AppProvider>(context , listen: false).darkTheme?Color(0xFF00416b): Colors.white),),
      backgroundColor:  Provider.of<AppProvider>(context ).darkTheme? Colors.white24 :Colors.grey,
      //Color(0xffeeac07),
          ),
          body: PageView(
            controller: _pageController,
            children:  <Widget>[

              DashBoard(),

              ProfileScreen(),
              DiscoverScreen(),
              VedioPreviewScreen(),
            ],
          ),
          bottomNavigationBar: CurvedNavigationBar(
            backgroundColor:Colors.grey,
            buttonBackgroundColor: Color(0xffeeac07),
            color: Provider.of<AppProvider>(context).darkTheme?greyScale850:Colors.white54,
            height: 65,
            items:  const <Widget>[

              Icon(
                Icons.home,
                size: 35,

              ),

              Icon(
                Icons.person,
                size: 35,

              ),
              Icon(
                Icons.map_outlined,
                size: 35,

              ),

              Icon(
                Icons.movie,
                size: 35,

              ),
            ],
            onTap: (index) {
pageindex = index;
    _pageController.animateToPage(index,
    duration: const Duration(milliseconds: 300),
    curve: Curves.easeOut);
    setState(() {

    });
    }



          ),

      ),
    );
  }
}