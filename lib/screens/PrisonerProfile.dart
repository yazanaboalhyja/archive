
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:palestine_archive/app_router/app_router.dart';
import 'package:palestine_archive/core/utils/color_constants.dart';


import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../auth/provider.dart';


class PrisonerProfile extends StatefulWidget {



  @override
  State<PrisonerProfile> createState() => _MartyrsProfileState();
}

class _MartyrsProfileState extends State<PrisonerProfile> {

  final customColor = Colors.black;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Consumer<AppProvider>(builder: (context, provider, x) {

      return Scaffold(
        backgroundColor: provider.darkTheme?greyScale850:Colors.white,
        appBar: AppBar(
          elevation: 0,
          // backgroundColor: customColor,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,

            ),
            onPressed: () {


              AppRouter.appRouter.hideDialoug();
            },
          ),
          centerTitle: true,
          actions: [

            PopupMenuButton<int>(

              itemBuilder: (context) => [
                PopupMenuItem<int>(value: 0, child: Text('Report')),
              ],
            ),
          ],
        ),
        body:
        SingleChildScrollView(
          child:
          Column(children: [
            Container(
              height: 200,
              decoration: BoxDecoration(
                  color: customColor,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),


                  ),
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image:
                      NetworkImage("https://i.pinimg.com/564x/fb/62/9d/fb629d07edbce1a2628019cf895787da.jpg")

                  )
              ),
              child: Container(
                child: Row(
                  children: [
                    Container(
                      width: 150,
                      height: 150,
                      margin: EdgeInsets.only(bottom: 10, left: 10),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage("http://10.0.2.2:3000/uploads/${provider.selectedPrisoner.photo_url!}"),
                        ),
                        shape: BoxShape.circle,
                        color: Colors.white,
                        border: Border.all(
                          color: Color(0xFF00416b), // Border color
                          width: .5, // Border width
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 120),
                            child: Center(
                              child: Text(
                                "${provider.selectedPrisoner.name!}",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Column(
              children: [
                Row(
                    children: [
                      Container(
                        alignment: Alignment.topLeft,
                        margin: EdgeInsets.only(left: 20, top: 30),
                        child: Text(
                          "${provider.selectedPrisoner.name!}",
                          style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF00416b)),
                        ),
                      ),
                      Expanded(child: SizedBox()),

                    ]),
                SizedBox(height: 30),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [

                    Container(
                        width: 150,
                        height: 70,
                        decoration: BoxDecoration(
                          color: Color(0xffeeac07),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        margin: EdgeInsets.only(top: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "تاريخ الميلاد",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 3),
                            Expanded(
                              child: Text(
                                "${provider.selectedPrisoner.date_of_birth!.split("T").first}",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF00416b)
                                ),
                              ),
                            ),
                          ],
                        )),
                    Container(
                        width: 150,
                        height: 70,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color(0xffeeac07),),
                        margin: EdgeInsets.only(top: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "تاريخ الأسر",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 3),
                            Expanded(
                              child: Text(
                                "${provider.selectedPrisoner.date_of_arrest!.split("T").first}",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF00416b)),
                              ),
                            ),
                          ],
                        )),

                  ],
                ),
                SizedBox(height: 20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      alignment: Alignment.topRight,
                      margin: EdgeInsets.only( top: 20),
                      child: Icon(Icons.location_city, color: Color(0xffeeac07),),
                    ),
                    Container(
                      alignment: Alignment.topRight,
                      margin: EdgeInsets.only(left: 15, top: 20),
                      child: Text(
                        "مكان الميلاد : ",
                        style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF00416b)),
                      ),
                    ),

                    Container(
                      // alignment: Alignment.bottomLeft,
                      margin: EdgeInsets.only(right: 20, top: 20),
                      child: Text(
                          "${provider.selectedPrisoner.place_of_birth!}",
                          style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF00416b))
                      ),
                    ),

                  ],
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      alignment: Alignment.topRight,
                      margin: EdgeInsets.only( top: 20),
                      child: Icon(Icons.dangerous, color: Color(0xffeeac07),),
                    ),
                    Container(
                      alignment: Alignment.topRight,
                      margin: EdgeInsets.only(left: 20, top: 20),
                      child: Text(
                        "قصة حياته :",
                        style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF00416b)),
                      ),
                    ),

                    Expanded(
                      child: Container(
                        // alignment: Alignment.bottomLeft,
                        margin: EdgeInsets.only(right: 20, top: 20),
                        child: Text(
                            "${provider.selectedPrisoner.life_story!}",
                            style: TextStyle(
                                overflow: TextOverflow.fade,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF00416b))
                        ),
                      ),
                    ),

                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      alignment: Alignment.topRight,
                      margin: EdgeInsets.only( top: 20),
                      child: Icon(Icons.edit, color: Color(0xffeeac07),),
                    ),
                    Container(
                      alignment: Alignment.topRight,
                      margin: EdgeInsets.only(left: 15, top: 20),
                      child: Text(
                        "اسم الناشر : ",
                        style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF00416b)),
                      ),
                    ),

                    Container(
                      // alignment: Alignment.bottomLeft,
                      margin: EdgeInsets.only(right: 20, top: 20),
                      child: Text(
                          provider.PrisonerFilterList.where((element) =>
                          element.id==provider.selectedPrisoner.id

                          ).toList().isNotEmpty?
                          "${provider.PrisonerFilterList.where((element) =>
                          element.id==provider.selectedPrisoner.id

                          ).toList().first.submitted_by_name
                          }":
                          'Yazan Abo Alhija'

                          ,
                          style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF00416b))
                      ),
                    ),

                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      //  alignment: Alignment.topRight,
                      margin: EdgeInsets.only( top: 20),
                      child:Icon(Icons.calendar_month, color: Color(0xffeeac07),),
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      margin: EdgeInsets.only(left: 20, top: 30),
                      child: Expanded(
                        child: Text(
                          " تاريخ النشر: ",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF00416b)),
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      margin: EdgeInsets.only(left: 20, top: 30),
                      child: Expanded(
                        child: Text(
                          "${provider.selectedPrisoner.created_at?.split('T').first! }"
                              " ${provider.selectedPrisoner.created_at?.split('T').last!.split('.').first }",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF00416b)),
                        ),
                      ),
                    ),



                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      //  alignment: Alignment.topRight,
                      margin: EdgeInsets.only( top: 20),
                      child:Icon(Icons.remove_red_eye_rounded, color: Color(0xffeeac07),),
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      margin: EdgeInsets.only(left: 20, top: 30),
                      child: Expanded(
                        child: Text(
                          "عدد المشاهدات :${provider.selectedPrisoner.views!}",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF00416b)),
                        ),
                      ),
                    ),



                  ],
                ),

              ],
            ),
          ],
          ),
        ),
      );

    });
  }
}
