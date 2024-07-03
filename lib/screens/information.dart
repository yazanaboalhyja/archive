import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:palestine_archive/app_router/app_router.dart';
import 'package:palestine_archive/core/utils/assets.dart';


class InformationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Color(0xffb8b8b8),
      body: SafeArea(

          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
          
              children: [
                Row(
                  children: [
                    IconButton(
                    icon: const Icon(Icons.arrow_back_ios),
                    color: Colors.white,
                    onPressed: () {
          
                      AppRouter.appRouter.hideDialoug();
                    },
                  ),
                    Expanded(child: SizedBox())
               ] ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.005),
                const CircleAvatar(
                  radius: 70.0,

                  backgroundColor: Color(0xffb8b8b8),
                  backgroundImage: AssetImage('assets/icons/ic_launcher.png'
                  ,

                  ),
                ),
                 Image.asset(
                  mainLogo
                  /*'Palestine Archive'+mainL,
                  style: TextStyle(
                      fontFamily: 'Pacifico',
                      fontSize: 40.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),*/
                ),
                SingleChildScrollView(
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height*0.25,
                    child: Text(
                      '''The Palestine Archive stands as a beacon of remembrance and knowledge, encapsulating the multifaceted narrative of Palestine's rich history. Merging advanced technology with a deep commitment to heritage preservation, this digital platform offers an expansive array of resources and interactive features, ensuring a comprehensive exploration of Palestine's past and present''',
                      style: TextStyle(
                          fontSize: 15.0,
                          fontFamily: 'Source Sans Pro',
                          color:  Color(0xFF00416b),
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2.5),
                    ),
                  ),
                ),
                SizedBox(
                  width: 150.0,
                  height: MediaQuery.of(context).size.height*0.05,
                  child: Divider(
                    color: Colors.teal.shade100,
                  ),
                ),
                Card(
                  margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                  child: ListTile(
                    leading: Icon(
                      Icons.phone,
                      color: Colors.teal,
                    ),
                    title: Text(
                      '+91 1234 567890',
                      style: TextStyle(
                          fontSize: 20.0,
                          fontFamily: 'Source Sans Pro',
                          color: Colors.teal.shade900),
                    ),
                  ),
                ),
                Card(
                  margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                  child: ListTile(
                    leading: Icon(
                      Icons.email,
                      color: Colors.teal,
                    ),
                    title: Text(
                      'yazanaboalhijaco@gmail.com',
                      style: TextStyle(
                          fontFamily: 'Source Sans Pro',
                          fontSize: 20.0,
                          color: Colors.teal.shade900),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

    );
  }
}
