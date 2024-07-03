import 'package:flutter/material.dart';

import '../../features/PostScreen/Martyrs/Martyrs_screen.dart';
import '../../features/auth/screens/login_screen.dart';
import '../../features/dashboard/screens/dashboard_screen.dart';
import '../../features/settings/screens/create_admin_screen.dart';
import '../../features/settings/screens/delete_admin_screen.dart';
import '../../widgets/home.dart';


Route<dynamic> appRoutes(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case LoginScreen.route:
      return MaterialPageRoute(
        builder: (context) {
          return const LoginScreen();
        },
        settings: routeSettings,
      );
    case Home.route:
      return MaterialPageRoute(
        builder: (context) {
          return const Home();
        },
        settings: routeSettings,
      );
    case DashboardScreen.route:
      return MaterialPageRoute(
        builder: (context) {
          return const DashboardScreen();
        },
        settings: routeSettings,
      );
    case CreateAdminScreen.route:
      return MaterialPageRoute(
        builder: (context) {
          return const CreateAdminScreen();
        },
        settings: routeSettings,
      );

    case DeleteAdminScreen.route:
      return MaterialPageRoute(
        builder: (context) {
          return const DeleteAdminScreen();
        },
        settings: routeSettings,
      );


    default:
      return MaterialPageRoute(
        builder: (_) => const Scaffold(
          body: Center(
            child: Text("Sorry, This page dosen't exist"),
          ),
        ),
      );
  }
}
