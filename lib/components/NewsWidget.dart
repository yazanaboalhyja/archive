
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:provider/provider.dart';

import '../Models/NewsModel.dart';
import '../app_router/app_router.dart';
import '../auth/provider.dart';
import 'ViewNewScreen.dart';



class NewsWidget extends StatelessWidget {

 late NewsModel newsModel ;
  NewsWidget( NewsModel newsModel){
   this.newsModel = newsModel;


  }
  @override
  Widget build(BuildContext context) {
    return  Consumer<AppProvider>(builder: (context, provider, x) {
      return GestureDetector(
        onTap: (){
          provider.getSelectedNews(
              newsModel.id ?? 1);
          AppRouter.appRouter.goToWidget(ViewNewScreen());


        },
        child: Container(
         // height: MediaQuery.of(context).size.height*0.00005,
         margin: EdgeInsets.all(6.0),
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(10.0),
            image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(newsModel.photo_url??'')

            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                 height: MediaQuery.of(context).size.height*0.2,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.5),
                  ),
                  child:  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                            Icons.remove_red_eye,
                            color: Colors.amber,
                          ),
                            Text(newsModel.views.toString(),
                                style: TextStyle(color: Colors.white)

                            )
                        ]),
                        Expanded(
                          child: Text(
                              overflow: TextOverflow.fade,
                              newsModel.description??'',
                              style: TextStyle(color: Colors.white)
                          ),
                        ),

                      ])
              ),
              SizedBox(

                height: MediaQuery.of(context).size.height*0.001,
              )
            ],
          ),
        ),
      );});}

}