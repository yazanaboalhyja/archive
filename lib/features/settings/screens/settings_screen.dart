import 'package:flutter/material.dart';
import 'package:palestine_archive/app_router/app_router.dart';

import '../../../config/routes/custom_push_navigators.dart';
import '../../../widgets/height_space.dart';
import '../widgets/settings_card.dart';
import 'create_admin_screen.dart';
import 'delete_admin_screen.dart';


class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const HeightSpace(15),
            SettingsCard(
                icon: Icons.person,
                settingsOperation: "Create Admin",
                settingsOperationDescription: "Create a new admin ",
                onPressed: () {
                  AppRouter.appRouter.goToWidget(CreateAdminScreen());

                  //namedNav(context, CreateAdminScreen.route);
                }),
            const HeightSpace(15),
            SettingsCard(
                icon: Icons.delete,
                settingsOperation: "Delete Admin ",
                settingsOperationDescription:
                    "Delete an existing admin ",
                onPressed: () {
                  AppRouter.appRouter.goToWidget(DeleteAdminScreen());

               //   namedNav(context, DeleteAdminScreen.route);
                }),
            const HeightSpace(15),

          ],
        ),
      ),
    );
  }
}
