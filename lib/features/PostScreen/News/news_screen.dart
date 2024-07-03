import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:palestine_archive/Models/NewsModel.dart';

import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../auth/provider.dart';
import '../../../components/NewsTile.dart';
import '../../../core/utils/color_constants.dart';
import '../../../data.dart';

import '../../../widgets/circular_loader.dart';
import '../../../widgets/circular_loader.dart';
import '../../../widgets/circular_loader.dart';
import '../../../widgets/width_space.dart';
import '../../auth/providers/user_provider.dart';
import '../../dashboard/services/dashboard_services.dart';
import 'add_new_news.dart';

class NewsScreen extends StatefulWidget {
  static const route = '/news-screen';
  NewsScreen({super.key });

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {

  late Future future;
  List<NewsModel> mainData = [];
  List<NewsTile> WidgetList = [];
  List<NewsTile> filteredList = [];
  getAllNews() async {
    await Provider.of<AppProvider>(context, listen: false).getNews('http://localhost:3000');
    mainData =   Provider.of<AppProvider>(context, listen: false).NewsFilterList;
    WidgetList=[];

    mainData.forEach((element) {
      WidgetList.add(NewsTile(
           newsModel: element, ));

    });
    print(WidgetList.length.toString()+'***************');
    setState(() {
      filteredList = WidgetList;

    });
  }



  @override
  void initState() {
    super.initState();
    future = getAllNews();
    //getAllTransactions();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context, listen: false).user;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryAppColor,
        tooltip: 'Add Last News',
        onPressed: (){

          Navigator.push(context, MaterialPageRoute(builder: (context) => AddNewNewsScreen(),))   ;

        },
        child: const Icon(Icons.add, color: Colors.white, size: 28),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Text(
                      "Add Last News",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const WidthSpace(20),
                    Container(
                      height: 25,
                      width: 25,
                      decoration: BoxDecoration(
                        border: Border.all(color: greyScale600),
                        shape: BoxShape.circle,
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.question_mark_rounded,
                          size: 20,
                          color: greyScale600,
                        ),
                      ),
                    )
                  ],
                ),
                const Icon(Icons.notifications)
              ],
            ),
          ),
          SizedBox(
            width: double.infinity,
            height: MediaQuery.of(context).size.height*0.1,
            child: ListView.builder(
                // shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: NewsCategory.length
                  ,
                  itemBuilder: (BuildContext context,
                      int index) =>
                      Container(height: 50,width: 100,
                        margin: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20)
                            ,color:  Colors.white
                        ),
                        child: Center(child: Text(
                            style: TextStyle(
                                color:Color(0xFF00416b)
                            ),
                            "${NewsCategory[index]}")),
                      )
                /* CircleAvatar(
                                          radius: 70,
                                          backgroundImage: NetworkImage( "${LastNewsList[index]["image"]}"),)

            */

            ),
          ),
          if (ResponsiveBreakpoints.of(context).isMobile)
            Expanded(
              //height: 350,
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  childAspectRatio: 2,
                ),
                itemCount:filteredList.length,
                itemBuilder: (BuildContext context, int index) {
                  return FutureBuilder(
                    future: future,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        return filteredList[index];

                         /* NewsTile(
                              newsModel: NewsModel.fromMap(LastNewsList[index]
                            imgUrl: LastNewsList[index]["image"] ?? "",
                            title: LastNewsList[index]["title"]?? "",
                            desc: "",
                            date: LastNewsList[index]["date"]  ?? "",
                            author: LastNewsList[index]["author"]  ?? "",
                            content: LastNewsList[index]["content"]  ?? "",
                            posturl: LastNewsList[index]["posturl"]?? "",
                            category: LastNewsList[index]["category"]?? "",
                            views: 0,
                            id: 1,*/


                      } else {}
                      return const CircularLoader();
                    },
                  );
                },
              ),
            ),
          if (ResponsiveBreakpoints.of(context).isTablet)
            Expanded(
              //height: 350,
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1.5,
                ),
                itemCount: filteredList.length,
                itemBuilder: (BuildContext context, int index) {
                  return FutureBuilder(
                    future: future,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        return
                          filteredList[index];
                        /*  NewsTile(
                              newsModel: NewsModel.fromMap(LastNewsList[index]

                                 imgUrl: LastNewsList[index]["image"] ?? "",
                            title: LastNewsList[index]["title"]?? "",
                            desc: "",
                            date: LastNewsList[index]["date"]  ?? "",
                            author: LastNewsList[index]["author"]  ?? "",
                            content: LastNewsList[index]["content"]  ?? "",
                            posturl: LastNewsList[index]["posturl"]?? "",
                            category: LastNewsList[index]["category"]?? "",
                            views: 0,
                            id: 1,*/
                         // );
                                             } else {}
                      return  CircularLoader();
                    },
                  );
                },
              ),
            ),
          if (ResponsiveBreakpoints.of(context).isDesktop)
            Expanded(
              //height: 350,
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 1.5,

                ),
                itemCount: filteredList.length,

                itemBuilder: (BuildContext context, int index) {
                  return FutureBuilder(
                    future: future,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        return  filteredList[index];

                      /*   NewsTile(
                            newsModel: NewsModel.fromMap(LastNewsList[index]

                               imgUrl: LastNewsList[index]["image"] ?? "",
                          title: LastNewsList[index]["title"]?? "",
                          desc: "",
                          date: LastNewsList[index]["date"]  ?? "",
                          author: LastNewsList[index]["author"]  ?? "",
                          content: LastNewsList[index]["content"]  ?? "",
                          posturl: LastNewsList[index]["posturl"]?? "",
                          category: LastNewsList[index]["category"]?? "",
                          views: 0,
                          id:  1,*/


                      } else {}
                      return const CircularLoader();
                    },
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}
