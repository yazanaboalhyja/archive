import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:palestine_archive/Models/NewsModel.dart';
import 'package:palestine_archive/app_router/app_router.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../auth/provider.dart';
import '../features/PostScreen/News/ViewNews.dart';
import 'ArticleView.dart';
import 'ViewNewScreen.dart';
import 'ViewVillageScreen.dart';

class NewsTile extends StatelessWidget {
  final NewsModel newsModel;

  NewsTile({
    required this.newsModel

  });

  @override
  Widget build(BuildContext context) {

    return Consumer<AppProvider>(builder: (context, provider, x) {

    return GestureDetector(
      onTap: ()async{
if(ResponsiveBreakpoints.of(context).isMobile) {
  await provider.getSelectedNews(
      newsModel.id);
  AppRouter.appRouter.goToWidget(ViewNewScreen());
}else{
  await provider.getSelectedNews(
      newsModel.id,'http://localhost:3000');
  AppRouter.appRouter.goToWidget(webViewNewScreen());
}
      },
      child: Container(
          margin: EdgeInsets.only(bottom: 24),
          width: MediaQuery.of(context).size.width,
          child: Container(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              alignment: Alignment.bottomCenter,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(bottomRight: Radius.circular(6),bottomLeft:  Radius.circular(6))
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                      height: 200,
                      width: MediaQuery.of(context).size.width,
                       decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      image: DecorationImage(

                          fit: BoxFit.cover,
                          image:NetworkImage(
                        newsModel.photo_url??'https://developers.google.com/static/maps/documentation/maps-static/images/error-image-generic.png?hl=ar',

                      ))
                      ),
                child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                      width: MediaQuery.of(context).size.width,
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.5),
                      ),
                      child:  Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(newsModel.name??'',
                                style: TextStyle(color: Colors.white)
                            ),

                            Row(
                                children: [
                                  Icon(
                                    Icons.edit,
                                    color: Colors.amber,
                                  ),
                                  Text("by : "+newsModel.submitted_by_name.toString(),
                                      style: TextStyle(color: Colors.white)
                                  ),
                                  Expanded(child: SizedBox()),
                                  Icon(
                                    Icons.date_range_sharp,
                                    color: Colors.amber,
                                  ),
                                  Text("Date : "+newsModel.created_at!.split('T').first??'',
                                      style: TextStyle(color: Colors.white)
                                  ),
                                ] ),
                            Row(
                              //  mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Icon(
                                    Icons.remove_red_eye,
                                    color: Colors.amber,
                                  ),
                                  Text("Views : "+newsModel.views.toString(),
                                      style: TextStyle(color: Colors.white)
                                  ),
                                  Expanded(child: SizedBox()),
                                  Container(
                                    height: 30,
                                    decoration: BoxDecoration(
                                        color: Color(0xffeeac07).withOpacity(0.8),
                                        borderRadius: BorderRadius.circular(20)
                                    ),

                                    child: TextButton(

                                      child:Text("read_more".tr(),

                                          style: TextStyle(color: Color(0xFF00416b), fontSize: 12)),
                                      onPressed: () async{
                                        await provider.getSelectedNews(
                                            newsModel.id );
                                        AppRouter.appRouter.goToWidget(ViewNewScreen());

                                      },
                                    ),
                                  )
                                ] ),
                          ])
                  )

                ],
              ),
                  ),
                  SizedBox(height: 12,),


                ],
              ),
            ),
          )),
    );});
  }}