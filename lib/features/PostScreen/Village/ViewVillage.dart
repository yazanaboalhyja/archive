
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:palestine_archive/Models/VillageModel.dart';
import 'package:palestine_archive/app_router/app_router.dart';

import '../../../components/ImageContainer.dart';
import '../../../components/ShimmerScreen.dart';



class webViewVillageScreen extends StatelessWidget {
  final VillageModel villageModel;


  const webViewVillageScreen({
    required this.villageModel  ,

    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:
        AppBar(
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

        body:
        Center(
          child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 5,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              width: MediaQuery.of(context).size.width * 0.5,

            child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 350),
                child: ShimmerScreen(
                  enabled: true,
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children:  [
                      ImageContainer(
                        height: MediaQuery.of(context).size.height * 0.45,
                        width: double.infinity,
                        padding: const EdgeInsets.all(40.0),
                        imageUrl: villageModel.image_url
                            ?? '',
                        gradientBlur: true,
                        child: Column(
                          //mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            IconButton(
                              onPressed: () {
            
                                AppRouter.appRouter.hideDialoug();},
                              icon: const Icon(
                                Icons.arrow_back_ios,
                                color: Colors.white,
                              ),
                            ),
                            Expanded(child: SizedBox()),
            
                            Text(
                                'القرية الفلسطينية المهجرة',
                                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                  color: Colors.white,
                                ))
                            ,
                            Text(
                              villageModel.village_name
                              ,
                              style:
                              Theme.of(context).textTheme.headlineSmall!.copyWith(fontWeight: FontWeight.bold, height: 1.25, color: Colors.white),
                            ),
            
                            Row(
                              children: [
                                Text(
                                    villageModel.city,
                                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                      color: Colors.white,
                                    )),
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
                                      ).format(villageModel.views)}",
                                      style: TextStyle(
                                          fontSize: 12,
            
                                          color: Color(0xFF00416b)),
                                    )
                                )
                              ],
                            )
                          ],
                        ),
                      ),
            
                      Text(
                        // overflow: TextOverflow.ellipsis,
                        villageModel.historical_context
                        ,
                        // maxLines: 2,
                        style: TextStyle(
                            color: Color(0xFF00416b),
                            fontSize: 20,
                            fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                )
            
            ),
          ),
        )
    );
  }
}
