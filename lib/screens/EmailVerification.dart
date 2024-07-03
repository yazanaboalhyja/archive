import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:palestine_archive/app_router/app_router.dart';
import 'package:palestine_archive/screens/Welcome.dart';

import '../components/My_Button.dart';


class EmailVerificationPage extends StatelessWidget {
  String email;
  EmailVerificationPage({
    required this.email
});
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Color(0xffb8b8b8),
      body: SafeArea(

        child: SingleChildScrollView(
          child: Container(
            height:   MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [

                SizedBox(height: MediaQuery.of(context).size.height * 0.005),
                const CircleAvatar(
                  backgroundColor:Colors.white ,
                  radius: 60.0,
                  backgroundImage: NetworkImage('https://cdn-icons-png.flaticon.com/512/5253/5253968.png'),
                ),
                const Text(
                  'Verify Your Email',
                  style: TextStyle(
                      fontFamily: 'Pacifico',
                      fontSize: 40.0,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF00416b),),
                ),
                Card(
                  margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                  child: ListTile(
                    leading: Icon(
                      Icons.email,
                      color:  Color(0xFF00416b),
                    ),
                    title: Text(
                      email,
                      style: TextStyle(
                          fontFamily: 'Source Sans Pro',
                          fontSize: 20.0,
                          color:  Color(0xFF00416b)),
                    ),
                  ),
                ),
                const SingleChildScrollView(
                  child: SizedBox(
                    height: 150,
                    child: Text(
                      '''Congratulations! Your Account Awaits: Verify Your Email to Start To Begin Your Journey In Discovering The Palestinian Archive''',
                      style: TextStyle(
                          fontSize: 22.0,
                          fontFamily: 'Source Sans Pro',
                          color: Color(0xFF00416b),
                         // fontWeight: FontWeight.bold,
                         // letterSpacing: 2.5
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 150.0,
                  height:  MediaQuery.of(context).size.height*0.1,
                  child: Divider(
                    color: Colors.teal.shade100,
                  ),
                ),
                Row(
                  children: [
                     SizedBox(width: MediaQuery.of(context).size.width*0.15,),
                    Expanded(
                      child: MyButtonAgree(
                        text: "Continue",
                        onTap: () {
                          AppRouter.appRouter.goToWidgetAndReplace(WelcomePage());
                      
                        },
                      ),
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width*0.15,),
                  ],
                ),
                TextButton(onPressed: (){}, child: Text(
          
                  "Resend Email",
                    style: TextStyle(
                      fontFamily: 'Pacifico',
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF00416b),)
                ))
          
          
              ],
            ),
          ),
        ),
      ),

    );
  }
}
