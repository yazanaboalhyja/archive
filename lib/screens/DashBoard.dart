import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:palestine_archive/app_router/app_router.dart';
import 'package:palestine_archive/components/MartyrsWidget.dart';
import 'package:palestine_archive/screens/MartyrsMemorialScreen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:palestine_archive/screens/MartyrsProfile.dart';
import 'package:palestine_archive/screens/PrisonerProfile.dart';

import 'package:provider/provider.dart';

import '../auth/provider.dart';
import '../components/NewsWidget.dart';
import '../data.dart';
import 'NewsScreen.dart';
import 'PrisonersScreen.dart';


class DashBoard extends StatefulWidget {
  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  List<NewsWidget> NewsWidgetList =[];
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        body: Consumer<AppProvider>(builder: (context, provider, x) {
          NewsWidgetList =[];
          provider.NewsFilterList.forEach((element) {
            NewsWidgetList.add(
                NewsWidget(element,
                    ));
          });

          return SafeArea(
            child: SingleChildScrollView(
              child: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                        'https://i.pinimg.com/564x/93/f2/7a/93f27a7f4785ac818ef5e6bbcfc83353.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
                height: MediaQuery.of(context).size.height+100,
                child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  //  const child:

                  SizedBox(
                      height: MediaQuery
                          .of(context)
                          .size
                          .height * 0.2,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                                children: [ Text('${'martyrs_memorial'.tr()} :',
                                    style: TextStyle(
                                      color: Color(0xFF00416b),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    )),
                                  Expanded(child: SizedBox()),
                                  TextButton(
                                      onPressed: () {
                                        AppRouter.appRouter.goToWidget(MartyrsMemorialPage());

                                      },
                                      child: Text(
                                          'view_all'.tr(), style: const TextStyle(
                                          color:Colors.white
                                         // Color(0xFF00416b)
                                      )))
                                ]),
                            Expanded(
                              child: ListView.builder(
                                 // shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemCount: provider.MartyrFilterList.length
                                  ,
                                  itemBuilder: (BuildContext context,
                                      int index) =>
                                      GestureDetector(
                                        onTap: ()async{
                                          await provider.getSelectedMartyr(
                                              provider.MartyrFilterList[index].id ?? 1);
                                           AppRouter.appRouter.goToWidget(MartyrsProfile());


                                        },
                                        child: CircleAvatar(
                                          radius: 57,
                                          backgroundImage:
                                          NetworkImage( "${provider.MartyrFilterList[index].image_url}"),),
                                      )


                              ),
                            ),

                          ]

                      )),
                  Row(
                      children: [ Text('${'last_news'.tr()} :',
                          style: TextStyle(
                            color: Color(0xFF00416b),
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          )),
                        Expanded(child: SizedBox()),
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context, MaterialPageRoute(builder:
                                  (context) =>
                                      NewsScreen()));
                            },
                            child: Text(
                                'view_all'.tr(), style: const TextStyle(
                                color: Colors.white)))
                      ]),
                  Container(
                    height: MediaQuery
                        .of(context)
                        .size
                        .height * 0.45,
                    child: ListView(children: [
                      CarouselSlider(
                        items:[...NewsWidgetList] ,
                        options: CarouselOptions(
                          height: 380.0,
                          enlargeCenterPage: true,
                          autoPlay: true,
                          aspectRatio: 16 / 9,
                          autoPlayCurve: Curves.fastOutSlowIn,
                          enableInfiniteScroll: true,
                          autoPlayAnimationDuration: Duration(
                              milliseconds: 800),
                          viewportFraction: 0.8,
                        ),
                      ),
                    ]),
                  ),
                  SizedBox(
                      height: MediaQuery
                          .of(context)
                          .size
                          .height * 0.35,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                                children: [
                                  Text('${"prisoners_chronicle".tr()} :',
                                      style: TextStyle(
                                        color: Color(0xFF00416b),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      )),
                                  Expanded(child: SizedBox()),
                                  TextButton(
                                      onPressed: () {
                                        AppRouter.appRouter.goToWidget(PrisonersPage());

                                      },
                                      child: Text(
                                          'view_all'.tr(), style: TextStyle(
                                          color: Colors.white)))
                                ]),
                            Expanded(
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemCount:provider.PrisonerFilterList.length
                                  ,
                                  itemBuilder: (BuildContext context,
                                      int index) =>
                                      Card(
                                        child: GestureDetector(
                                          onTap: ()async{
                                            await provider.getSelectedPrisoner(provider.PrisonerFilterList[index].id);
                                            AppRouter.appRouter.goToWidget(PrisonerProfile());
                                          },
                                          child: Container(
                                              width: MediaQuery
                                                  .of(context)
                                                  .size
                                                  .width *
                                                  0.35,

                                              decoration: BoxDecoration(
                                                  boxShadow: [
                                                    BoxShadow(
                                                        color: Colors.black
                                                            .withOpacity(0.4),
                                                        offset: Offset(0, 25),
                                                        blurRadius: 10,
                                                        spreadRadius: -2)
                                                  ],
                                                  color: Colors.white,

                                                  borderRadius:
                                                  BorderRadius.circular(10.0),
                                                  image: DecorationImage(
                                                      image: NetworkImage(
                                                          "${provider.PrisonerFilterList[index].photo_url}"),
                                                      fit: BoxFit.cover)
                                              ),
                                              child: Column(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                                  children: [
                                                    Center(
                                                        child: Container(
                                                          width: MediaQuery
                                                              .of(context)
                                                              .size
                                                              .width *
                                                              0.35,
                                                          color: Colors.grey
                                                              .withOpacity(0.7),
                                                          child: Text(
                                                              textAlign:
                                                              TextAlign.center,
                                                              style: TextStyle(
                                                                  color: Color(
                                                                      0xFF00416b),
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                              '${provider.PrisonerFilterList[index].name}'),
                                                        ))
                                                  ])),
                                        ),
                                      )

                              ),
                            )
                          ])
                  ),


                ]),
              ),
            ),

          );
        })
        );
  }
}