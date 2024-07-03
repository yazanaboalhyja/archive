import 'package:flutter/material.dart';

import '../../../core/utils/color_constants.dart';
import '../../../core/utils/global_constants.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_textfield.dart';
import '../../../widgets/height_space.dart';
import '../services/settings_services.dart';


class DeleteAdminScreen extends StatefulWidget {
  static const route = '/delete-admin';
  const DeleteAdminScreen({super.key});

  @override
  State<DeleteAdminScreen> createState() => _DeleteAdminScreenState();
}

class _DeleteAdminScreenState extends State<DeleteAdminScreen> {
  final TextEditingController usernameController = TextEditingController();

  bool obscureText = true;

  String? errorText;
  String? successMessage = '';

  final SettingsServices settingsServices = SettingsServices();
  final deleteAdminFormKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    usernameController.dispose();
 }

  void deleteAdmin() async {
    //final authProvider = Provider.of<AuthProvider>(context, listen: false);
    if (deleteAdminFormKey.currentState!.validate()) {
      settingsServices.deleteAdminOrUser(
        context: context,
        username: usernameController.text,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
         appBar: AppBar(),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const HeightSpace(10),
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: Text(
                      "Delete Admin",
                      style: TextStyle(
                        fontSize: heightValue37,
                        fontWeight: FontWeight.w900,
                        height: 1.5,
                      ),
                    ),
                  ),
                  formUI()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget formUI() {
    return Form(
      key: deleteAdminFormKey,
      child: Center(
        child: SizedBox(
          width: 400,
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: CustomTextField(
                      willContainPrefix: true,
                      labelText: "Admin Email",
                      hintText: "Admin Email",
                      prefixIcon: const Icon(Icons.alternate_email),
                      controller: usernameController,
                    ),
                  ),
                ],
              ),

              CustomButton(
                buttonText: "Delete Admin",
                buttonColor: primaryAppColor,
                buttonTextColor: scaffoldBackgroundColor,
                borderRadius: heightValue30,
                onTap: () {
                  deleteAdmin();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
