import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../Models/VillageModel.dart';
import '../../../auth/provider.dart';
import '../../../core/utils/color_constants.dart';
import '../../../data.dart';
import '../../../screens/PalestineAtlas.dart';
import '../../../widgets/circular_loader.dart';
import '../../../widgets/width_space.dart';
import '../../auth/providers/user_provider.dart';
import '../../dashboard/services/dashboard_services.dart';
import 'AddNewVillage.dart';


class VillageScreen extends StatefulWidget {
  static const route = '/village-screen';
  VillageScreen({super.key });

  @override
  State<VillageScreen> createState() => _VillageScreenState();
}

class _VillageScreenState extends State<VillageScreen> {

  late Future future;
  List<VillageModel> mainData = [];
  List<VillageCard> WidgetList = [];
  List<VillageCard> filteredList = [];

  getAllVillage() async {
    await Provider.of<AppProvider>(context, listen: false).getVillages('http://localhost:3000');
    mainData =   Provider.of<AppProvider>(context, listen: false).VillageFilterList;
    WidgetList=[];

    mainData.forEach((element) {
      WidgetList.add(VillageCard(
         villageModel: element, ));

    });
    print(WidgetList.length.toString()+'***************');
    setState(() {
      filteredList = WidgetList;

    });
  }


  @override
  void initState() {
    super.initState();
    future = getAllVillage();
    //getAllTransactions();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context, listen: false).user;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryAppColor,
        tooltip: 'Palestine Atlas',
        onPressed: (){

          Navigator.push(context, MaterialPageRoute(builder: (context) => CreateVillageScreen(),))   ;

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
                      "Palestine Atlas",
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
                        return filteredList[index];

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
                        return filteredList [index];
                      } else {}
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
                        return  filteredList[index];

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
