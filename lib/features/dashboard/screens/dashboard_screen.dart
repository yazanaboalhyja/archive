import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../core/utils/color_constants.dart';
import '../../../data.dart';
import '../../../widgets/circular_loader.dart';
import '../../../widgets/width_space.dart';
import '../../actvities/services/activties_services.dart';
import '../../auth/providers/user_provider.dart';
import '../services/dashboard_services.dart';
import '../widgets/dashboard_container.dart';

class DashboardScreen extends StatefulWidget {
  static const String route = "/dashboard";
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final DashBoardServices dashBoardServices = DashBoardServices();

  late Future future;
  List<int> mainData = [];

  getDashBoardData() async {

    mainData =  await dashBoardServices.getTotalDashboard(
      context: context,
    );
  }

  @override
  void initState() {
    super.initState();
    future = getDashBoardData();
    //getAllTransactions();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context, listen: false).user;
    return Scaffold(
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
                      "Dashboard",
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
                itemCount: title.length,
                itemBuilder: (BuildContext context, int index) {
                  return FutureBuilder(
                    future: future,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        return DashboardContainer(
                          icon: Icons.ad_units_rounded,

                          color: colors[index],
                          title: title[index],
                          mainData: mainData[index].toString(),
                          topIcon: topIcons[index],
                          topIconColor: topIconsColor[index],
                          willContainRow: willContainRow[index],
                        );
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
                itemCount: title.length,
                itemBuilder: (BuildContext context, int index) {
                  return FutureBuilder(
                    future: future,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        return DashboardContainer(
                          icon: Icons.ad_units_rounded,

                          color: colors[index],
                          title: title[index],
                          mainData: mainData[index].toString(),
                          topIcon: topIcons[index],
                          topIconColor: topIconsColor[index],
                          willContainRow: willContainRow[index],
                        );
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
                itemCount: title.length,
                itemBuilder: (BuildContext context, int index) {
                  return FutureBuilder(
                    future: future,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        return DashboardContainer(
                          icon: Icons.ad_units_rounded,
                          color: colors[index],
                          title: title[index],
                          mainData: mainData[index].toString(),
                          topIcon: topIcons[index],
                          topIconColor: topIconsColor[index],
                          willContainRow: willContainRow[index],
                        );
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
