import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:palestine_archive/app_router/app_router.dart';


import '../../../Models/ActivityModel.dart';
import '../../../Models/MartyrModel.dart';
import '../../../Models/NewsModel.dart';
import '../../../Models/PrisonerModel.dart';
import '../../../core/utils/color_constants.dart';
import '../../../data.dart';
import '../../../widgets/activity_details_container.dart';
import '../../../widgets/circular_loader.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_textfield.dart';
import '../services/activties_services.dart';
import 'activity_details_screen.dart';

class UserActvitiesScreen extends StatefulWidget {
  static const String route = "/transactions-screen";
  const UserActvitiesScreen({Key? key}) : super(key: key);

  @override
  State<UserActvitiesScreen> createState() => _UserTransactionsScreenState();
}

class _UserTransactionsScreenState extends State<UserActvitiesScreen> {
  List<ActivityModel> activities = [];
  List<ActivityCard> filteredActivities = [];
  final ActivityServices activityServices = ActivityServices();
  late Future _future;
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _future = getAllActivities();
    searchController.addListener(_onSearchChanged);
  }


  void _onSearchChanged() {
    setState(() {
      if (searchController.text.isEmpty) {
        filteredActivities = ActivityCardList;
      } else {
        filteredActivities = ActivityCardList
            .where((e) =>

            e.activity.activityType.contains(searchController.text)||
                e.activity.activitySummary.contains(searchController.text)||
                e.activity.authorName.contains(searchController.text))
            .toList();
      }
    });
  }
  getAllActivities() async {
    activities = await activityServices.getAllUserActivities(
      context: context,
    );

    ActivityCardList=[];
    ActivityDate=[];

    activities.forEach((element) {
      if(!ActivityDate.contains(element.created_at)){
        ActivityDate.add(element.created_at);
      }
      ActivityCardList.add(ActivityCard(activity: element));

    });
    setState(() {
      filteredActivities = ActivityCardList;

    });

  }



List<ActivityCard> ActivityCardList=[];
  List<String> ActivityDate=[];
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: FutureBuilder(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return ActivityCardList.isEmpty
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset("assets/images/empty_list.png"),
                        const Text(
                          "There are no new activities for the users",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        CustomButton(
                            buttonText: "تحديث",
                            buttonTextColor: whiteColor,
                            onTap: () => getAllActivities())
                      ],
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        const Text(
                          "User Activities",
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomTextField(
                          hintText: "Search activities reference ",
                          controller: searchController,
                        ),
                        Expanded(
                          child: RefreshIndicator(
                            displacement: 100,
                            onRefresh: () => getAllActivities(),
                            child: ListView.builder(
                              itemCount: ActivityDate.length,
                              itemBuilder: (BuildContext context, int index) {
                               /* List<String> keys = groupTransactionsByDateText(
                                        filteredTransactions)
                                    .keys
                                    .toList();*/
                                String key = ActivityDate[index];
                               /* List<Transactions> transactionsList =
                                    groupTransactionsByDateText(
                                        filteredTransactions)[key]!;*/
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      key,
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    ListView.builder(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount: filteredActivities.where((element) => element.activity.created_at==key).length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                       /* final transactionData =
                                            transactionsList[index];*/
                                        return GestureDetector(
                                          onTap: () {
                                            AppRouter.appRouter.hideDialoug();
                                           Navigator.push(context,
                                                MaterialPageRoute(
                                              builder: (context) {
                                                return ActivityDetailsScreen(
                                                    activity:ActivityCardList.where((element) => element.activity.created_at==key).toList()[index].activity,
                                                        );
                                              },
                                            ));
                                          },
                                          child:
                                          ActivityCardList.where((element) => element.activity.created_at==key).toList()[index]

                                        );
                                      },
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
          } else {}
          return const CircularLoader();
        },
      ),
    );
  }
}
