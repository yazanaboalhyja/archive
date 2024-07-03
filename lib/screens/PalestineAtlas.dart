
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:palestine_archive/components/ViewVillageScreen.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'dart:math' as math;

import '../Models/VillageModel.dart';
import '../app_router/app_router.dart';
import '../auth/provider.dart';
import '../features/PostScreen/Village/ViewVillage.dart';

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({super.key});

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  int tabLength = 4;
  /*List<NewsTile> NewsWidgetList =[];
  List<NewsTile> filteredNews = [];*/
  @override
  void initState() {

    tabController = TabController(
      length: tabLength,
      vsync: this,
    );

    searchController.addListener(_onSearchChanged);

    // getAllVillages();
    super.initState();
  }

  final TextEditingController searchController = TextEditingController();

  List<Widget> VideosWidgetList =[];
  @override
  void _onSearchChanged() {
    Provider.of<AppProvider>(context, listen: false).searchVillage(
        searchController.text);
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Consumer<AppProvider>(builder: (context, provider, x) {

      return Scaffold(
      body: Container(

        padding: EdgeInsets.fromLTRB(
            20, mediaQuery.padding.top, 20, mediaQuery.padding.bottom),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
                'https://i.pinimg.com/564x/93/f2/7a/93f27a7f4785ac818ef5e6bbcfc83353.jpg'),
            fit: BoxFit.cover,
          ),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF524A41),
              Color(0xFFAA928E),
            ],

          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
        Row(
        children: [
        Expanded(child: SizedBox()),
        SizedBox(
          height: 45,
          width: MediaQuery.of(context).size.width*0.7,
          child: TextField(
            style: GoogleFonts.poppins(
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
              hintText: "Search for Village...",
              hintStyle: GoogleFonts.abel(
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
          Expanded(child: SizedBox(
              child:
              PopupMenuButton(

                icon: const Icon(Icons.filter_list_rounded,color: Colors.white,),

                itemBuilder: (context) => [
                  PopupMenuItem(

                    child: StatefulBuilder(
                      builder: (_context, _setState) =>
                          CheckboxListTile(
                            contentPadding: EdgeInsets.zero,

                            activeColor: Colors.amber,
                            value: true,
                            onChanged:  (value) {
                              //isSelected=value!;
                             // _setState(() => SelectedFilter = 0);
                              provider.getVillages();
                              AppRouter.appRouter.hideDialoug();
                            },
                            title: Text("Page View"),
                          ),

                    ),
                  ),


                ],
              )

          )),
        ]),
            const SizedBox(height: 20),
             Text(
            "palestine_atlas".tr(),
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.w500),
            ),
             Text(
               "atlas_description".tr(),
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  height: 1.5,
                  fontWeight: FontWeight.normal),
            ),
            const SizedBox(height: 20),
            Expanded(
                child:

                    buildVillageList(provider.VillageFilterList ),


                ),


          ],
        ),
      ),
    );});
  }

  ListView buildVillageList(List<VillageModel> villageList) {
    return ListView.builder(
        padding: const EdgeInsets.only(top: 15),
        itemCount: villageList.length,
        itemBuilder: (context, index) {
          return VillageCard(
            villageModel: villageList[index],
          );
        });
  }
}

class VillageCard extends StatelessWidget {
  const VillageCard({super.key, required this.villageModel});
  final VillageModel villageModel;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return InkWell(
     /* onTap: () {

        /*  Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DetailsScreen(animal: animal)));*/
      },*/
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            height: mediaQuery.size.width * 0.55,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            decoration: BoxDecoration(
              color: Colors.white24,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(5, 5)),
              ],
            ),
            child: Row(
              children: [
                MapArea(color: villageModel.bgColor!, name: villageModel.village_name ,  views: villageModel.views,),
                 ButtonArea(villageModel: villageModel),
              ],
            ),
          ),

        ],
      ),
    );
  }
}

class MapArea extends StatelessWidget {
  const MapArea({
    Key? key,
    required this.color,
    required this.name,
    required this.views,
  }) : super(key: key);

  final Color color;
  final String name;
  final int views;

  Alignment get _alignment {
    final random = math.Random();
    return Alignment(random.nextDouble(), random.nextDouble());
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: color,
          image: DecorationImage(
            alignment: _alignment,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.6),
              BlendMode.dstATop,
            ),
            fit: BoxFit.cover,
            image: const NetworkImage("https://tile.loc.gov/image-services/iiif/service:gmd:gmd370m:g3700m:g3700m:gla00129:ca000010/full/pct:25/0/default.jpg"),
          ),
        ),
        child: Stack(children: [
          Positioned(
            //this is for random position on map
              top: math.Random().nextInt(80).toDouble(),
              right: math.Random().nextInt(110).toDouble(),
              child: const LocationMarker()),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(
                  Icons.location_on,
                  color: Colors.white54,
                ),
                Text(
                  name,
                  style: const TextStyle(
                      fontWeight: FontWeight.w600, fontSize: 20),
                ),
                Row(
                  children: [
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
                          ).format(views)}",
                          style: TextStyle(
                              fontSize: 12,

                              color: Color(0xFF00416b)),
                        )
                    )
                  ],
                )
              ],
            ),
          )
        ]),
      ),
    );
  }
}

class LocationMarker extends StatelessWidget {
  const LocationMarker({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
          color: Colors.amber.withOpacity(0.25),
          borderRadius: BorderRadius.circular(50),
          border: Border.all(
            color: Colors.amber.withOpacity(0.5),
            width: 2,
          )),
      child: Container(
        margin: const EdgeInsets.all(20),
        width: 5,
        height: 5,
        decoration: BoxDecoration(
            color: Colors.amber, borderRadius: BorderRadius.circular(30)),
      ),
    );
  }
}

class ButtonArea extends StatelessWidget {
 final VillageModel villageModel;

   ButtonArea({

     required this.villageModel  ,

    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(builder: (context, provider, x) {

      return Expanded(
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image:NetworkImage(villageModel.image_url),
                fit: BoxFit.cover )
        ),
        // color: Colors.yellow
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            GestureDetector(
              onTap: () async {
               ! ResponsiveBreakpoints.of(context).isMobile?
                await provider.getSelectedVillage(
                    villageModel.id ,  'http://localhost:3000'):
               await provider.getSelectedVillage(
                   villageModel.id );
               ! ResponsiveBreakpoints.of(context).isMobile?
               AppRouter.appRouter.goToWidget(webViewVillageScreen(villageModel: provider.selectedVillage,)):

                AppRouter.appRouter.goToWidget(ViewVillageScreen(villageModel: provider.selectedVillage,));

              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                decoration:  BoxDecoration(
                    color: Colors.grey.withOpacity(0.8),
                    borderRadius:
                    BorderRadius.only(topLeft: Radius.circular(20))),
                child: const Icon(Icons.chevron_right),
              ),
            ),
          ],
        ),
      ),
    );});
  }
}