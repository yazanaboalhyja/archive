import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:palestine_archive/screens/ActivitiesScreen.dart';
import 'package:palestine_archive/screens/Welcome.dart';
import 'package:provider/provider.dart';

import '../app_router/app_router.dart';
import '../auth/provider.dart';
import '../components/ProfileMenuWidget .dart';
import '../components/UpdateProfileScreen.dart';
import 'VedioPreview.dart';
import 'information.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
 int selectedLanguageIndex = 1;

  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return
      Consumer<AppProvider>(builder: (context, provider, x) {
      return Scaffold(

      body: SingleChildScrollView(
        child:

        Container(
          child: Stack(
            children:[
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  decoration: const BoxDecoration
                    (
                      color: Colors.grey,
                      image: DecorationImage(
                        fit: BoxFit.cover,
                          image:
                  NetworkImage("https://i.pinimg.com/564x/fb/62/9d/fb629d07edbce1a2628019cf895787da.jpg")

                  )),
                  height: 200.0,

                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      /// -- BUTTON
                      ///
                     provider.DbloggedUser!=''?
                      Row(
                        children: [
                          SizedBox(
                          width: 200,
                          child: ElevatedButton(
                            onPressed: () {
                              AppRouter.appRouter.goToWidget( UpdateProfileScreen());


                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xffeeac07), side: BorderSide.none, shape: const StadiumBorder()),
                            child: const Text("Edit Profile", style: TextStyle(color: Colors.white)),
                          ),
                        ),
                          Expanded(child: SizedBox())
                     ] ):
                      SizedBox(),
                  ]),
                ),
                const SizedBox(height: 60),
                provider.DbloggedUser.username!=''?
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                Text(provider.DbloggedUser!.name!, style: Theme.of(context).textTheme.headline4?.apply(color: Color(0xFF00416b))),
                Text(provider.DbloggedUser!.username!, style: Theme.of(context).textTheme.bodyText2?.apply(color: Color(0xFF00416b))),
                           ]):
                Text('Visitor', style: Theme.of(context).textTheme.headline4?.apply(color: Color(0xFF00416b))),

                provider.DbloggedUser.username!=''?
                const Divider():SizedBox(),
                const SizedBox(height: 10),
/*
                /// -- MENU
                ProfileMenuWidget(title: "Settings", icon: LineAwesomeIcons.cog, onPress: () {


                }),*/
                ProfileMenuWidget(title: "dark_mode".tr(), icon: LineAwesomeIcons.moon,endIcon: false, onPress: () {

                }),
                ProfileMenuWidget(title: "language".tr(), icon: LineAwesomeIcons.language, onPress: () {
                  showModalBottomSheet<void>(


                    context: context,

                    builder: (BuildContext context )
                  {
                    return StatefulBuilder(
                        builder: (BuildContext context, setState) {
                          return SizedBox(
                            height: 200,
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  InkWell(
                                    onTap: () {
                                      selectedLanguageIndex = 1;

                                        context.setLocale(Locale('ar'));

                                      setState(() {

                                      });
                                    },
                                    child: Padding(
                                      padding:
                                      EdgeInsets.only(left: 8.0,
                                          right: 8.0,
                                          top: 3.0,
                                          bottom: 3.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment
                                            .spaceBetween,
                                        children: <Widget>[
                                          const Text("عربي"),
                                          context.locale == Locale('ar')
                                              ? const Icon(
                                            Icons.radio_button_checked,
                                            color: Colors.amber,
                                          )
                                              : const Icon(
                                              Icons.radio_button_unchecked),
                                        ],
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      selectedLanguageIndex = 2;

                                        context.setLocale(Locale('en'));

                                      setState(() {

                                      });
                                    },
                                    child: Padding(
                                      padding:
                                      const EdgeInsets.only(left: 8.0,
                                          right: 8.0,
                                          top: 3.0,
                                          bottom: 3.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment
                                            .spaceBetween,
                                        children: <Widget>[
                                          Text("English"),
                                          context.locale == Locale('en')
                                              ? Icon(
                                            Icons.radio_button_checked,
                                            color: Colors.amber,
                                          )
                                              : Icon(
                                              Icons.radio_button_unchecked),
                                        ],
                                      ),
                                    ),
                                  ),


                                ],
                              ),
                            ),
                          );
                        });
                  }); }),
                const Divider(),
                const SizedBox(height: 10),
                provider.DbloggedUser.username!=''?
                ProfileMenuWidget(title: "my_posts".tr(), icon: Icons.newspaper, onPress: () {

                  AppRouter.appRouter.goToWidget(ActivitiesScreen());
                  
                }):
                SizedBox(),
                const Divider(),
                const SizedBox(height: 10),
                ProfileMenuWidget(title: "about".tr(), icon: LineAwesomeIcons.info, onPress: () {

                  AppRouter.appRouter.goToWidget(InformationPage());
                }),
                ProfileMenuWidget(
                    title:provider.DbloggedUser.username!=''?"log_out".tr():
                    'Exit Visitor View',
                    icon: LineAwesomeIcons.alternate_sign_out,
                    textColor: Colors.red,
                    endIcon: false,
                    onPress: () {
                      provider.DbloggedUser.username!=''?
                      provider.signOut():
                      AppRouter.appRouter.goToWidgetAndReplace(WelcomePage());

                     }),
              ],
            ),
              /// -- IMAGE
              Positioned(
                top: 130.0,
                right:context.locale == Locale('en')? 10: MediaQuery.of(context).size.width-120,
                child: Stack(
                  children: [
                    SizedBox(
                      width: 120,
                      height: 120,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(100), child:
                       Image(
                         fit: BoxFit.cover,
                           image: NetworkImage(
                               "https://st4.depositphotos.com/14903220/22197/v/1600/depositphotos_221970610-stock-illustration-abstract-sign-avatar-icon-profile.jpg"))

                      ),

                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        width: 35,
                        height: 35,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color:  Color(0xffeeac07)),
                        child: const Icon(
                          LineAwesomeIcons.alternate_pencil,
                          color: Colors.black,
                          size: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

         ] ),
        ),
      ),
    );});
  }
}