import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import 'package:easy_localization/easy_localization.dart';

import 'package:provider/provider.dart';

import '../app_router/app_router.dart';
import '../auth/provider.dart';
import '../components/NewsTile.dart';
import '../components/NewsWidget.dart';
import '../data.dart';
import 'AddNewMartyrOrPrisoner.dart';
import 'AddPressNewsOrVillage.dart';
import 'PrisonersScreen.dart';


class NewsScreen extends StatefulWidget {
  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  int SelectedFilter =0;

  List<NewsTile> NewsWidgetList =[];
  List<NewsTile> filteredNews = [];
  final TextEditingController searchController = TextEditingController();

  void _onSelectedCategory(String category) {

    setState(() {
      if (category.isEmpty||category.toLowerCase()=='General'.toLowerCase()) {
        filteredNews = NewsWidgetList;
      }

      else {
        filteredNews = NewsWidgetList
            .where((e) =>

        e.newsModel.category!.toLowerCase().contains(category.toLowerCase())).toList();
        }
    });
  }
  void _onSearchChanged() {
    Provider.of<AppProvider>(context , listen: false).searchNews(searchController.text);

  }
  @override
  void initState() {
    // TODO: implement initState
    //getAllNews();
    super.initState();
    searchController.addListener(_onSearchChanged);

  }
 /* getAllNews(){
    NewsWidgetList =[];
    Provider.of<AppProvider>(context,listen: false).NewsFilterList.forEach((element) {
      print(element.category);
      NewsWidgetList.add(
          NewsTile(
            newsModel: element,


          ));
    });

    setState(() {
      filteredNews = NewsWidgetList;
    });
  }*/
  @override
  Widget build(BuildContext context) {

    return Consumer<AppProvider>(builder: (context, provider, x) {
      return Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: const Color(0xffeeac07),
          tooltip: 'Add New Press News',
          onPressed: (){
            AppRouter.appRouter.goToWidget(AddPressNewsOrVillagePage(true));

          },
          child: const Icon(Icons.add, color: Colors.white, size: 28),
        ),
        body:


         SafeArea(
            //child: SingleChildScrollView(
              child: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                        'https://i.pinimg.com/564x/93/f2/7a/93f27a7f4785ac818ef5e6bbcfc83353.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
                height: 1500,
                child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  //  const child:

                  SizedBox(
                      height: MediaQuery.of(context).size.height*0.18,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 20),
                            Row(
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.arrow_back_ios),
                                    color: Colors.white,
                                    onPressed: () {
                                      provider.getNews();

                                      AppRouter.appRouter.hideDialoug();
                                    },
                                  ),
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
                                      controller: searchController 
                                    ,
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: const Color(0xfff1f1f1),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(8),
                                          borderSide: BorderSide.none,
                                        ),
                                        hintText: "Search for News...",
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
                                  Expanded(child: SizedBox(
                                    child:
                                         PopupMenuButton(

                                           icon: const Icon(Icons.filter_list_rounded,color: Colors.white,),
                                      /*  onSelected: (item) =>
                                         AppRouter.appRouter.goToWidget(AddMartyrsOrPrisonerPage(false)),*/
                                        itemBuilder: (context) => [
                                          PopupMenuItem(

                                            child: StatefulBuilder(
                                              builder: (_context, _setState) =>
                                                  CheckboxListTile(
                                                    contentPadding: EdgeInsets.zero,

                                                    activeColor: Colors.amber,
                                                    value: SelectedFilter==0,
                                                    onChanged:  (value) {
                                                      //isSelected=value!;
                                                      _setState(() => SelectedFilter = 0);
                                                      provider.getNews();
                                                      AppRouter.appRouter.hideDialoug();
                                                    },
                                                    title: Text("Page View"),
                                                  ),

                                            ),
                                          ),
                                          PopupMenuItem(

                                            child: StatefulBuilder(
                                              builder: (_context, _setState) =>
                                                  CheckboxListTile(
                                                    activeColor: Colors.amber,
                                                    value: SelectedFilter==1,
                                                    onChanged: (value) {
                                                      provider.filterNewsByDate(DateFormat('yyyy-MM-dd').format(DateTime.now().subtract(Duration(days: DateTime.now().weekday - 1))).toString());
                                                        _setState(() => SelectedFilter = 1);
                                                        AppRouter.appRouter.hideDialoug();
                                                        }
                                                    ,
                                                    title: Text("Older than a week"),
                                                  ),

                                            ),
                                          ),
                                          PopupMenuItem(

                                            child: StatefulBuilder(
                                              builder: (_context, _setState) =>
                                                  CheckboxListTile(
                                                    activeColor: Colors.amber,
                                                    value: SelectedFilter==2,
                                                    onChanged: (value) {
                                                      AppRouter.appRouter.hideDialoug();
                                                      _setState(() => SelectedFilter = 2);}
                                                    ,
                                                    title: Text("More than a month ago"),
                                                  ),

                                            ),
                                          ),
                                          PopupMenuItem(

                                            child: StatefulBuilder(
                                              builder: (_context, _setState) =>
                                                  CheckboxListTile(
                                                    activeColor: Colors.amber,
                                                    value: SelectedFilter==3,
                                                    onChanged: (value) {
                                                      _setState(() => SelectedFilter = 3);
                                                      AppRouter.appRouter.hideDialoug();

                                                    }
                                                    ,
                                                    title: Text("More than a 6 month ago"),
                                                  ),

                                            ),
                                          ),
                                          PopupMenuItem(

                                            child: StatefulBuilder(
                                              builder: (_context, _setState) =>
                                                  CheckboxListTile(
                                                    activeColor: Colors.amber,
                                                    value: SelectedFilter==4,
                                                    onChanged: (value) {

                                                      _setState(() =>
                                                      SelectedFilter = 4
                                                      );
                                                     AppRouter.appRouter.hideDialoug();
                                                      }
                                                    ,
                                                    title: Text("More than a year"),
                                                  ),

                                            ),
                                          ),
                                        ],
                                          )

                                  )),
                                ]),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              child: Row(
                                children: [

                                  Expanded(child: SizedBox()),
                                  Text(
                                    "last_news".tr(),
                                    style:  TextStyle(
                                        fontSize: 20,
                                        // fontWeight: FontWeight.bold,
                                        color: !Provider.of<AppProvider>(context , listen: false).darkTheme?Color(0xFF00416b): Colors.white
                                    ),
                                  ),
                                  const Icon(
                                    LineAwesomeIcons.newspaper,
                                    //  color: Colors.blue,
                                    size: 20
                                  ),
                                  Expanded(child: SizedBox()),
                                ],
                              ),
                            ),
                            Expanded(
                              child: ListView.builder(
                                // shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemCount: NewsCategory.length
                                  ,
                                  itemBuilder: (BuildContext context,
                                      int index) =>
                                  GestureDetector(
                                    onTap: (){
                                      _onSelectedCategory(NewsCategory[index]);
                                    },
                                    child: Container(height: 50,width: 100,
                                    margin: EdgeInsets.all(2),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20)
                                      ,color: Provider.of<AppProvider>(context , listen: false).darkTheme?Colors.grey: Colors.white
                                    ),
                                    child: Center(child: Text(
                                        style: TextStyle(
                                          color:Color(0xFF00416b)
                                        ),
                                        "${NewsCategory[index]}")),
                                    ),
                                  )

                              ),
                            ),


                          ]

                      )),

                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(top: 16),
                      child:
                      provider.NewsFilterList.isNotEmpty?
                      ListView.builder(
                          itemCount: provider.NewsFilterList.length,
                          shrinkWrap: true,
                          physics: ClampingScrollPhysics(),
                          itemBuilder: (context, index) {
                            return  NewsTile(newsModel: provider.NewsFilterList[index]);
                          }):
                      Center(child: Text('No New News Found...'),),
                    ),
                  )

                ]),
              ),
            //),

          ));
        });

  }
}