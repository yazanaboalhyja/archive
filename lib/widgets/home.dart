import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../app_router/app_router.dart';
import '../config/routes/custom_push_navigators.dart';
import '../core/utils/assets.dart';
import '../core/utils/color_constants.dart';
import '../core/utils/global_constants.dart';
import '../features/PostScreen/Martyrs/Martyrs_screen.dart';
import '../features/PostScreen/News/news_screen.dart';
import '../features/PostScreen/Videos/videos_screen.dart';
import '../features/PostScreen/Village/atlas_screen.dart';
import '../features/actvities/screens/user_activties_screen.dart';
import '../features/auth/providers/user_provider.dart';
import '../features/auth/screens/login_screen.dart';
import '../features/dashboard/screens/dashboard_screen.dart';
import '../features/settings/screens/settings_screen.dart';
import 'custom_button.dart';
import 'height_space.dart';

class Home extends StatefulWidget {
  static const String route = "/home";
  const Home({super.key});
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final List<Widget> _pages = [
    const DashboardScreen(),
    const UserActvitiesScreen(),
    MartyrsOrPrisonerScreen(),
    MartyrsOrPrisonerScreen(isPrisoner: true,),
    NewsScreen(),
    VillageScreen(),
    VideosScreen(),

    const SettingsScreen()
  ];

  late PageController _pageController;

  int _currentIndex = 0;

  void _changePage(int index) {
    setState(() {
      _currentIndex = index;
      if (_scaffoldKey.currentState!.isDrawerOpen) {
        Navigator.pop(context);
      }
      _pageController.animateToPage(index,
          duration: const Duration(milliseconds: 300), curve: Curves.ease);
    });
  }

  void logOut(BuildContext context) async {
    try {
      SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
      await sharedPreferences.setString('x-auth-token', '');

      AppRouter.appRouter.goToWidgetAndReplace(LoginScreen());
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery
        .of(context)
        .size;
    final orientation = MediaQuery
        .of(context)
        .orientation;
    final isDesktop = ResponsiveBreakpoints
        .of(context)
        .isDesktop &&
        orientation == Orientation.landscape;
  /*  final userProvider = Provider
        .of<UserProvider>(context, listen: false)
        .user;*/
    return Consumer<UserProvider>(builder: (context, userProvider, x) {

      return
      Scaffold(
      key: _scaffoldKey,
      drawer: isDesktop
          ? null
          : Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const HeightSpace(15),
            Image.asset(
              mainLogo,
              height: 40,
            ),
            const HeightSpace(15),
            CircleAvatar(
              radius: 40,
              child: Center(
                child: Text(
                 userProvider.user.fullname[0],
                      //userProvider.user.type,
                  style: const TextStyle(fontSize: 25),
                ),
              ),
            ),
            const HeightSpace(15),
            const HeightSpace(5),
            Text(userProvider.user.email),
            userProvider.user.type == "user"
                ? const SizedBox.shrink()
                :
            ListTile(
              title: const Text('Dashboard'),
              leading: const Icon(Icons.space_dashboard_rounded),
              selected: _currentIndex == 0,
              onTap: () => _changePage(0),
            ),
            ListTile(
              title: const Text('Martyrs Memorial'),
              leading: const Icon(Icons.ad_units_rounded),
              selected: _currentIndex == 2,
              onTap: () => _changePage(2),
            ),
            ListTile(
              title: const Text('Prisoner'),
              leading: const Icon(Icons.ad_units_rounded),
              selected: _currentIndex == 3,
              onTap: () => _changePage(3),
            ),
            ListTile(
              title: const Text('Last News'),
              leading: const Icon(Icons.newspaper),
              selected: _currentIndex == 4,
              onTap: () => _changePage(4),
            ),
            ListTile(
              title: const Text('Palestine Atlas'),
              leading: const Icon(Icons.map_outlined),
              selected: _currentIndex == 5,
              onTap: () => _changePage(5),
            ),
            ListTile(
              title: const Text('Videos'),
              leading: const Icon(Icons.movie),
              selected: _currentIndex == 6,
              onTap: () => _changePage(6),
            ),
            userProvider.user.type == "user"
                ? const SizedBox.shrink()
                :
            ListTile(
              title: const Text('User Activities'),
              leading: const Icon(Icons.send_rounded),
              selected: _currentIndex == 1,
              onTap: () => _changePage(1),
            ),

             userProvider.user.type == "user"
                ? const SizedBox.shrink()
                : ListTile(
                 title: const Text('Settings'),
                   leading: const Icon(Icons.settings),
                  selected: _currentIndex == 7,
                  onTap: () => _changePage(7),
            ),
            CustomButton(
                buttonText: "Log Out",
                buttonTextColor: secondaryAppColor,
                onTap: () {
                  logOut(context);
                }),
          ],
        ),
      ),
      appBar: isDesktop
          ? null
          : AppBar(
        leading: isDesktop
            ? null
            : IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () => _scaffoldKey.currentState!.openDrawer(),
        ),
      ),
      body: Row(
        children: [
          if (isDesktop)
            SizedBox(
              width: screenWidth / 5,
              child: Drawer(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    const HeightSpace(15),
                    Image.asset(
                      mainLogo,
                      height: 40,
                    ),
                    const HeightSpace(15),
                    CircleAvatar(
                      radius: 40,
                      child: Center(
                        child: Text(
                        //  userProvider.fullname[0]??
                              '',
                          style: const TextStyle(fontSize: 25),
                        ),
                      ),
                    ),
                    const HeightSpace(15),
                    Center(
                      child: Text(
                          "${userProvider.user.fullname} (${userProvider.user.type
                              .toUpperCase()})"),
                    ),
                    const HeightSpace(5),
                    Center(child: Text(userProvider.user.email)),
                    const HeightSpace(10),
                    userProvider.user.type == "agent" || userProvider.user.type == "user"
                        ? Container(
                      height: 90,
                      width: 200,
                      decoration: const BoxDecoration(
                        color: greyScale850,
                      ),
                      child: Center(
                        child: Column(
                          children: [
                            Image.asset(
                              infoCircle,
                              height: 50,
                              color: Colors.red,
                            ),
                            const Text(
                              "Please Note, User accounts have limited features",
                              style: TextStyle(fontSize: 13),
                              textAlign: TextAlign.center,
                            )
                          ],
                        ),
                      ),
                    )
                        : const SizedBox.shrink(),
                    const HeightSpace(10),
                    userProvider.user.type == "user"
                        ? const SizedBox.shrink()
                        :
                    ListTile(
                      title: const Text('Dashboard'),
                      leading: const Icon(Icons.space_dashboard_rounded),
                      selected: _currentIndex == 0,
                      onTap: () => _changePage(0),
                    ),

                    userProvider.user.type == "user"
                        ? const SizedBox.shrink()
                        :
                    ListTile(
                      title: const Text('User Activities'),
                      leading: const Icon(Icons.send_rounded),
                      selected: _currentIndex == 1,
                      onTap: () => _changePage(1),
                    ),
                    ExpansionTile(title:  Text('Post Screens'),
                      leading: const Icon(Icons.publish),
                      children: [  ListTile(
                        title: const Text('Martyrs Memorial'),
                        leading: const Icon(Icons.ad_units_rounded),
                        selected: _currentIndex == 2,
                        onTap: () => _changePage(2),
                      ),
                        ListTile(
                          title: const Text('Prisoner Profile'),
                          leading: const Icon(Icons.ad_units_rounded),
                          selected: _currentIndex == 3,
                          onTap: () => _changePage(3),
                        ),
                        ListTile(
                          title: const Text('Last News'),
                          leading: const Icon(Icons.newspaper),
                          selected: _currentIndex == 4,
                          onTap: () => _changePage(4),
                        ),
                        ListTile(
                          title: const Text('Palestine Atlas'),
                          leading: const Icon(Icons.map_outlined),
                          selected: _currentIndex == 5,
                          onTap: () => _changePage(5),
                        ),
                        ListTile(
                          title: const Text('Videos'),
                          leading: const Icon(Icons.movie),
                          selected: _currentIndex == 6,
                          onTap: () => _changePage(6),
                        )
                      ],
                    ),


                    userProvider.user.type == "user"
                        ? const SizedBox.shrink()
                        : ListTile(
                        title: const Text('Settings'),
                        leading: const Icon(Icons.settings),
                      selected: _currentIndex == 7,
                      onTap: () => _changePage(7),
                    ),

                    CustomButton(
                        buttonText: "Log Out",
                        buttonTextColor: secondaryAppColor,
                        onTap: () {
                          logOut(context);
                        }),
                  ],
                ),
              ),
            ),
          Expanded(
            child: PageView(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: _pages,
              onPageChanged: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
            ),
          )
        ],
      ),
    );});
  }
}
