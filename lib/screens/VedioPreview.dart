import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:palestine_archive/components/VideoWidget.dart';

import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

import '../app_router/app_router.dart';
import '../auth/provider.dart';
import 'WachVedioScreen.dart';


class VedioPreviewScreen extends StatefulWidget {
  @override
  State<VedioPreviewScreen> createState() => _VedioPreviewScreenState();
}

class _VedioPreviewScreenState extends State<VedioPreviewScreen> {
  final TextEditingController searchController = TextEditingController();

  List<Widget> VideosWidgetList =[];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    searchController.addListener(_onSearchChanged);

  }
  void _onSearchChanged() {
    Provider.of<AppProvider>(context, listen: false).searchVideos(
        searchController.text);
  }

    @override
  Widget build(BuildContext context) {

    return Scaffold(
        body: Consumer<AppProvider>(builder: (context, provider, x) {
          VideosWidgetList =[];
          provider.VideoFilterList.forEach((element) {
            VideosWidgetList.add(
                VideoWidget(videoModel: element,));
          });
          return SafeArea(

              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.black26,
                  image: DecorationImage(
                    image: NetworkImage(
                        'https://i.pinimg.com/564x/93/f2/7a/93f27a7f4785ac818ef5e6bbcfc83353.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
                height: 880,
                child:
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start, children: [
                  SizedBox(height: 20),
                  Row(
                      children: [
                        Expanded(child: SizedBox()),
                        SizedBox(
                          height: 45,
                          width: MediaQuery.of(context).size.width*0.8,
                          child: TextField(
                            style: GoogleFonts.abel(
                              color: const Color(0xff020202),
                              fontSize: 20,
                              fontWeight: FontWeight.w100,
                              letterSpacing: 0.5,
                            ),
                            controller: searchController,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: const Color(0xfff1f1f1),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide.none,
                              ),
                              hintText: "Search for Videos...",
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
                  SizedBox(height: 10,),
                  const Row(
                      children: [ Text('${'Videos and Documented Events'} :\n',
                          style: TextStyle(
                            color: Color(0xFF00416b),
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          )),
                        Expanded(child: SizedBox()),

                      ]),
                  Expanded(

                                child: ListView.builder(
                                  //  shrinkWrap: true,
                    
                                    itemCount:VideosWidgetList.length
                                    ,
                                    itemBuilder: (BuildContext context, int index)  {

                    return VideosWidgetList[index];

                    }
                                ),
                              ),

                            ]
                    
                        )),

          );
        }));
  }
}