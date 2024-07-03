import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../auth/provider.dart';

class WebMartyrsProfile extends StatefulWidget {
  @override
  State<WebMartyrsProfile> createState() => _MartyrsProfileState();
}

class _MartyrsProfileState extends State<WebMartyrsProfile> {
  @override
  bool isPressed = false;
  late List days;
  final customColor = Colors.black;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Consumer<AppProvider>(builder: (context, provider, x) {

      return Scaffold(
      appBar: AppBar(
        elevation: 0,
        // backgroundColor: customColor,

        centerTitle: true,

      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
          //  height: MediaQuery.of(context).size.height,
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Container(
                    height: 270,
                    decoration: BoxDecoration(
                        color: customColor,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30),
                        ),
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                                "https://i.pinimg.com/564x/fb/62/9d/fb629d07edbce1a2628019cf895787da.jpg"))),
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
                                image: NetworkImage(
                                   'http://127.0.0.1:3000/uploads/' +provider.selectedMartyr.image_url),
                              ),
                              shape: BoxShape.circle,
                              color: Colors.white,
                              border: Border.all(
                                color: Colors.white, // Border color
                                width: .5, // Border width
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Column(
                  children: [
                    Row(children: [
                      Container(
                        alignment: Alignment.topLeft,
                        margin: EdgeInsets.only(left: 20, top: 30),
                        child: Text(
                          provider.selectedMartyr.full_name??'',
                          style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                      Expanded(child: SizedBox()),
                    ]),
                    SizedBox(height:15),
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
                                  "birth_date".tr(),
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(height: 3),
                                Expanded(
                                  child: Text(
                                    provider.selectedMartyr.date_of_birth??'0000:00:00',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ),
                              ],
                            )),
                        Container(
                            width: 150,
                            height: 70,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Color(0xffeeac07),
                            ),
                            margin: EdgeInsets.only(top: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "death_of_date".tr(),
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(height: 3),
                                Expanded(
                                  child: Text(
                                    provider.selectedMartyr.date_of_death??'0000:00:00',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ),
                              ],
                            )),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          alignment: Alignment.topRight,
                          margin: EdgeInsets.only(top: 20),
                          child: Icon(
                            Icons.location_city,
                            color: Color(0xffeeac07),
                          ),
                        ),
                        Container(
                          alignment: Alignment.topRight,
                          margin: EdgeInsets.only(left: 15, top: 20),
                          child: Text(
                            "${"birth_place".tr()} : ",
                            style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                        Container(
                          // alignment: Alignment.bottomLeft,
                          margin: EdgeInsets.only(right: 20, top: 20),
                          child: Text(provider.selectedMartyr.nationality,
                              style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white)),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          alignment: Alignment.topRight,
                          margin: EdgeInsets.only(top: 20),
                          child: Icon(
                            Icons.location_on,
                            color: Color(0xffeeac07),
                          ),
                        ),
                        Container(
                          alignment: Alignment.topRight,
                          margin: EdgeInsets.only(left: 15, top: 20),
                          child: Text(
                            "${"place_of_death".tr()} : ",
                            style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                        Container(
                          // alignment: Alignment.bottomLeft,
                          margin: EdgeInsets.only(right: 20, top: 20),
                          child: Text(provider.selectedMartyr.place_of_death??'',
                              style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white)),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          alignment: Alignment.topRight,
                          margin: EdgeInsets.only(top: 20),
                          child: Icon(
                            Icons.dangerous,
                            color: Color(0xffeeac07),
                          ),
                        ),
                        Container(
                          alignment: Alignment.topRight,
                          margin: EdgeInsets.only(left: 20, top: 20),
                          child: Text(
                            "${"cause_of_death".tr()} :",
                            style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                        Container(
                          // alignment: Alignment.bottomLeft,
                          margin: EdgeInsets.only(right: 20, top: 20),
                          child: Text(provider.selectedMartyr.cause_of_death??'',
                              style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white)),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          alignment: Alignment.topRight,
                          margin: EdgeInsets.only( top: 20),
                          child: Icon(Icons.description, color: Color(0xffeeac07),),
                        ),
                        Container(
                          alignment: Alignment.topRight,
                          margin: EdgeInsets.only(left: 5, top: 20),
                          child: Text(
                            "${"description".tr()}:",
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

                                "${provider.selectedMartyr.description!??''}",
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
                          margin: EdgeInsets.only(top: 20),
                          child: Icon(
                            Icons.edit,
                            color: Color(0xffeeac07),
                          ),
                        ),
                        Container(
                          alignment: Alignment.topRight,
                          margin: EdgeInsets.only(left: 15, top: 20),
                          child: Text(
                            "${'author_name'.tr()} : ",
                            style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                        Container(
                          // alignment: Alignment.bottomLeft,
                          margin: EdgeInsets.only(right: 20, top: 20),
                          child: Text(provider.selectedMartyr.submitted_by_name??'',
                              style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white)),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          //  alignment: Alignment.topRight,
                          margin: EdgeInsets.only(top: 20),
                          child: Icon(
                            Icons.remove_red_eye_rounded,
                            color: Color(0xffeeac07),
                          ),
                        ),
                        Container(
                          alignment: Alignment.topLeft,
                          margin: EdgeInsets.only(left: 20, top: 30),
                          child: Expanded(
                            child: Text(
                              "${'views'.tr()} :${provider.selectedMartyr.views}",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
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
        ),
      ),
    );});
  }
}
