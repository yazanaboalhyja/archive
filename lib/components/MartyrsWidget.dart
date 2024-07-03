import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:palestine_archive/app_router/app_router.dart';
import 'package:palestine_archive/core/utils/color_constants.dart';
import 'package:palestine_archive/features/PostScreen/Martyrs/MartyrsProfile.dart';
import 'package:palestine_archive/features/PostScreen/Prisoner/PrisonerProfile.dart';
import 'package:palestine_archive/screens/MartyrsProfile.dart';
import 'package:palestine_archive/screens/PrisonerProfile.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../auth/provider.dart';

class MartyrsWidget extends StatefulWidget {
  late String name;
  late String image;
  int views = 0;
  int? id;
  String? type;

  MartyrsWidget(String name, String image, int views, int id, String type) {
    this.name = name;
    this.image = image;
    this.views = views;
    this.id = id;
    this.type = type;
  }
  @override
  _MartyrsWidgetState createState() => _MartyrsWidgetState();
}

class _MartyrsWidgetState extends State<MartyrsWidget> {
  bool networkError = false;

  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(builder: (context, provider, x) {
      return GestureDetector(
        onTap: () async {
          if (widget.type == "Martyr") {
            if (!ResponsiveBreakpoints.of(context).isMobile) {
              await provider.getSelectedMartyr(
                  widget.id ?? 1, 'http://localhost:3000');
              AppRouter.appRouter.goToWidget(WebMartyrsProfile());
            } else {
              await provider.getSelectedMartyr(widget.id ?? 1);
              AppRouter.appRouter.goToWidget(MartyrsProfile());
            }
          } else {
            if (!ResponsiveBreakpoints.of(context).isMobile) {
              await provider.getSelectedPrisoner(
                  widget.id ?? 1, 'http://localhost:3000');
              AppRouter.appRouter.goToWidget(webPrisonerProfile());
            } else {
              await provider.getSelectedPrisoner(widget.id ?? 1);
              AppRouter.appRouter.goToWidget(PrisonerProfile());
            }
          }
        },
        child: Card(
          child: Container(
              width: MediaQuery.of(context).size.width * 0.39,
              decoration: BoxDecoration(
                color: provider.darkTheme ? greyScale850 : Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.4),
                      offset: Offset(0, 25),
                      blurRadius: 10,
                      spreadRadius: -2)
                ],
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.2,
                      width: MediaQuery.of(context).size.width * 0.39,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10)),
                          image: DecorationImage(
                              onError: (exception, stackTrace) {
                                setState(() {
                                  networkError = true;
                                });
                              },
                              //  NetworkImage(),
                              image: NetworkImage(
                                !networkError
                                    ? widget.image
                                    : 'https://developers.google.com/static/maps/documentation/maps-static/images/error-image-generic.png?hl=ar',
                              ),
                              fit: BoxFit.contain)),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.1,
                      child: Center(
                          child: Text(
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 18,
                                  //fontWeight: FontWeight.bold,
                                  color: !Provider.of<AppProvider>(context,
                                              listen: false)
                                          .darkTheme
                                      ? Color(0xFF00416b)
                                      : Colors.white),
                              widget.name)),
                    ),
                    Row(
                      children: [
                        Container(
                          alignment: Alignment.topLeft,
                          margin: EdgeInsets.only(top: 5),
                          child: Icon(
                            Icons.remove_red_eye_rounded,
                            color: Color(0xffeeac07),
                          ),
                        ),
                        Container(
                            alignment: Alignment.topLeft,
                            margin: EdgeInsets.only(top: 5),
                            child: Text(
                              "عدد المشاهدات :${widget.views}",
                              style: TextStyle(
                                  fontSize: 14, color: Color(0xFF00416b)),
                            ))
                      ],
                    )
                  ])),
        ),
      );
    });
  }
}
