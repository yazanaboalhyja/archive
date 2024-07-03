import 'package:flutter/material.dart';
import 'package:palestine_archive/Models/MartyrModel.dart';
import 'package:palestine_archive/Models/PrisonerModel.dart';

import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../auth/provider.dart';
import '../../../components/MartyrsWidget.dart';
import '../../../core/utils/color_constants.dart';
import '../../../data.dart';
import '../../../widgets/circular_loader.dart';
import '../../../widgets/width_space.dart';
import '../../auth/providers/user_provider.dart';
import '../../dashboard/services/dashboard_services.dart';
import '../Prisoner/AddNewPrisoner.dart';
import 'AddNewMartyr.dart';

class MartyrsOrPrisonerScreen extends StatefulWidget {
  static const route = '/martyrs_or_prisoner';

  late bool isPrisoner;
   MartyrsOrPrisonerScreen({super.key , this.isPrisoner=false});

  @override
  State<MartyrsOrPrisonerScreen> createState() => _MartyrsOrPrisonerScreenState();
}

class _MartyrsOrPrisonerScreenState extends State<MartyrsOrPrisonerScreen> {

  late Future future;
  List<MartyrModel> mainData1 = [];
  List<MartyrsWidget> WidgetList =[];
  List<MartyrsWidget> filteredList = [];
  List<PrisonerModel> mainData2 = [];

  getAllMartyrs() async {
    await Provider.of<AppProvider>(context, listen: false).getMartyrs('http://localhost:3000');
    mainData1 =   Provider.of<AppProvider>(context, listen: false).MartyrFilterList;
    WidgetList=[];

    mainData1.forEach((element) {

      WidgetList.add(MartyrsWidget(
          element.full_name??'' , element.image_url ,
          element.views ,element.id,element.type ));

    });
    setState(() {
      filteredList = WidgetList;

    });
  }
  getAllPrisoners() async {
    await Provider.of<AppProvider>(context, listen: false).getPrisoners('http://localhost:3000');
    mainData2 =   Provider.of<AppProvider>(context, listen: false).PrisonerFilterList;
    WidgetList=[];

    mainData2.forEach((element) {
      WidgetList.add(MartyrsWidget(
          element.name??'' , element.photo_url! ,
          element.views! ,element.id,element.type ));

    });
    setState(() {
      filteredList = WidgetList;

    });
  }

  @override
  void initState() {
    super.initState();
    !widget.isPrisoner?
    future = getAllMartyrs():
    future = getAllPrisoners();
    //getAllTransactions();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context, listen: false).user;
    return Consumer<AppProvider>(builder: (context, provider, x) {
      WidgetList =[];
      provider.MartyrFilterList.forEach((element) {
        WidgetList.add(
            MartyrsWidget(element.full_name!,element.image_url!, element.views , element.id , element.type));
      });
      return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryAppColor,
        tooltip: 'Add New Memorial',
        onPressed: (){
          !widget.isPrisoner?
Navigator.push(context, MaterialPageRoute(builder: (context) => CreateMartyrScreen(),)):
          Navigator.push(context, MaterialPageRoute(builder: (context) => CreatePrisonerScreen(),))   ;

//AppRouter.appRouter.goToWidget(AddMartyrsOrPrisonerPage(false));
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
                      "Add New Memorial",
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
                        return

                       // !widget.isPrisoner?
                            filteredList[index];
                      //  MartyrsWidget(PrisonersList[index]['name']!,PrisonersList[index]['imageUrl']! , 0, 1 ,'Prisoner' );
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

                        //!widget.isPrisoner?
                          filteredList[index];
                      /*  MartyrsWidget(MartyrsList[index]['full_name']!,MartyrsList[index]['image_url']!,0 , 1,'Martyr'):
    MartyrsWidget(MartyrsList[index]['name']!,MartyrsList [index]['imageUrl']! , 0, 1,'Prisoner')*/
    ;                      } else {}
                      return const CircularLoader();
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
                        return
                          filteredList[index];
                      } else {}
                      return const CircularLoader();
                    },
                  );
                },
              ),
            ),
        ],
      ),
    );});
  }
}
