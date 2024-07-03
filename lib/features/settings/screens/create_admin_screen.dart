import 'package:flutter/material.dart';

import '../../../core/utils/color_constants.dart';
import '../../../core/utils/global_constants.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_textfield.dart';
import '../../../widgets/height_space.dart';
import '../services/settings_services.dart';



class CreateAdminScreen extends StatefulWidget {
  static const route = '/create-admin';
  const CreateAdminScreen({super.key});

  @override
  State<CreateAdminScreen> createState() => _CreateAdminScreenState();
}

class _CreateAdminScreenState extends State<CreateAdminScreen> {

  final TextEditingController emailController = TextEditingController();


  String? errorText;
  String? successMessage = '';

  final SettingsServices settingsServices = SettingsServices();
  final createAdminFormKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();

    emailController.dispose();
  }

  void createAdmin() async {
    //final authProvider = Provider.of<AuthProvider>(context, listen: false);
    if (createAdminFormKey.currentState!.validate()) {

        settingsServices.createAdmin(
          context: context,
          email: emailController.text,
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
                      "Create Admin ",
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
      key: createAdminFormKey,
      child: Center(
        child: SizedBox(
          width: 400,
          child: Column(
            children: [

              CustomTextField(
                labelText: "Email",
                hintText: "Enter your email address",
                controller: emailController,
                // validator: validateEmail,
              ),


              CustomButton(
                buttonText: "Create Admin",
                buttonColor: primaryAppColor,
                buttonTextColor: scaffoldBackgroundColor,
                borderRadius: heightValue30,
                onTap: () {
                  createAdmin();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
