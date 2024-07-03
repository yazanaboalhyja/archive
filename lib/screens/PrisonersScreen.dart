import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:palestine_archive/app_router/app_router.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

import '../auth/provider.dart';
import '../components/MartyrsWidget.dart';
import 'AddNewMartyrOrPrisoner.dart';

class PrisonersPage extends StatefulWidget {
  @override
  _PrisonersPageState createState() => _PrisonersPageState();
}

class _PrisonersPageState extends State<PrisonersPage> {

  List<Widget> PrisonersListWidget =[];
  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(builder: (context, provider, x) {
      PrisonersListWidget =[];
      provider.PrisonerFilterList.forEach((element) {
        PrisonersListWidget.add(
            MartyrsWidget(element.name!,element.photo_url!, element.views! , element.id,element.type));
      });

      /*PrisonersListWidget =[];
      PrisonersList.forEach((element) {

        PrisonersListWidget.add(MartyrsWidget(element["name"]!,element["image"]!,0 , 1));

      });*/

      return Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: const Color(0xffeeac07),
          tooltip: 'Add New Prisoners',
          onPressed: (){

            AppRouter.appRouter.goToWidget(AddMartyrsOrPrisonerPage( true));
          },
          child: const Icon(Icons.add, color: Colors.white, size: 28),
        ),
        body: SafeArea(
          child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                    'https://i.pinimg.com/564x/93/f2/7a/93f27a7f4785ac818ef5e6bbcfc83353.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 20),
                  Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.arrow_back_ios),
                          color: Colors.white,
                          onPressed: () {
                            AppRouter.appRouter.hideDialoug();
                          },
                        ),
                        SizedBox(
                          height: 45,
                          width: MediaQuery.of(context).size.width*0.8,
                          child: TextField(
                            style: GoogleFonts.poppins(
                              color: const Color(0xff020202),
                              fontSize: 20,
                              fontWeight: FontWeight.w100,
                              letterSpacing: 0.5,
                            ),
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: const Color(0xfff1f1f1),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide.none,
                              ),
                              hintText: "Search for Prisoners...",
                              hintStyle: GoogleFonts.poppins(
                                  color: const Color(0xffb2b2b2),
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                  letterSpacing: 0.5,
                                  decorationThickness: 6),
                              prefixIcon: const Icon(Icons.search),
                              prefixIconColor: Colors.black,
                            ),
                          ),
                        ),
                        Expanded(child: SizedBox()),
                      ]),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      children: [

                        Expanded(child: SizedBox()),
                        Text(
                          "prisoners_chronicle".tr(),
                          style:  TextStyle(
                              fontSize: 30,
                              // fontWeight: FontWeight.bold,
                              color: !Provider.of<AppProvider>(context , listen: false).darkTheme?Color(0xFF00416b): Colors.white
                          ),
                        ),
                        const Icon(
                          LineAwesomeIcons.memory,
                          //  color: Colors.blue,
                          size: 30,
                        ),
                        Expanded(child: SizedBox()),
                      ],
                    ),
                  ),
                  const SizedBox(height: 50),
                  Container(
                      margin: EdgeInsets.only(left: 30),
                      width: double.infinity,
                      alignment: Alignment.centerLeft,
                      child: Wrap(
                        spacing: 20,
                        runSpacing: 30,
                        children: [

                          ...PrisonersListWidget
                        ],
                      )),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
