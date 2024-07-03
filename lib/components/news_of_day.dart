import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:palestine_archive/components/ArticleView.dart';
import 'package:provider/provider.dart';

import '../app_router/app_router.dart';
import '../auth/provider.dart';
import 'ImageContainer.dart';

class NewsOfTheDay extends StatelessWidget {

   NewsOfTheDay({
    Key? key,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Consumer<AppProvider>(builder: (context, provider, x) {
          return ImageContainer(
            height: MediaQuery.of(context).size.height * 0.45,
            width: double.infinity,
            padding: const EdgeInsets.all(40.0),
            imageUrl: !kIsWeb?provider.selectedNews.photo_url??'' :
            'http://localhost:3000/uploads/'+provider.selectedNews.photo_url!.split('/').last
            ,
            gradientBlur: true,
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                    Expanded(child: SizedBox()),
                    

                 Row(
                    children: [

                      const SizedBox(width: 10),

                      Expanded(child: SizedBox()),
                      Container(
                        alignment: Alignment.topLeft,
                        decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.5)
                        ),
                        //margin: EdgeInsets.only( top: 5),
                        //  child: Expanded(
                        child:Icon(Icons.remove_red_eye_rounded, color: Color(0xffeeac07),),

                        // ),
                      ),
                      Container(
                          alignment: Alignment.topLeft,

                          decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.5)
                          ),
                          child:Text(
                            "عدد المشاهدات :${NumberFormat.compact(
                              // decimalDigits: 0,
                              locale: 'en_IN',
                              // symbol: '',
                            ).format(provider.selectedNews.views)}",
                            style: TextStyle(
                                fontSize: 12,

                                color: Color(0xFF00416b)),
                          )
                      )

                    ],
                  ),



                  ],
                ),




          );});
        }


}