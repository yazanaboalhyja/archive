import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../auth/provider.dart';
import '../../../core/utils/color_constants.dart';
import '../../../core/utils/global_constants.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_textfield.dart';
import '../../../widgets/height_space.dart';
import '../../settings/services/settings_services.dart';



class CreateVillageScreen extends StatefulWidget {
  static const route = '/create-village';
  const CreateVillageScreen({super.key});

  @override
  State<CreateVillageScreen> createState() => _CreateVillageScreenState();
}

class _CreateVillageScreenState extends State<CreateVillageScreen> {

  bool obscureText = true;
  bool obscureText2 = true;

  String? errorText;
  String? successMessage = '';
  String misMatchPasswordErrorText = '';

  File? imageFile  ;
  String path ="";

  @override
  void dispose() {
    super.dispose();

  }

  

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        // appBar: CustomAppBar(image: logo),
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
                      "Create Village Profile",
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
    return Consumer<AppProvider>(builder: (context, provider, x) {

      return Form(
      key: provider.addVillageKey,
      child: Center(
        child: SizedBox(
          width: 400,
          child: Column(
            children: [

              CustomTextField(
                labelText: "Village Name",
                hintText: "Enter Village name",
                controller: provider.villageName,
                // validator: validateName,
              ),

              CustomTextField(
                labelText: "City",
                hintText: "Enter Village City",
                controller: provider.villageLocation,
                // validator: validateEmail,
              ),


              CustomTextField(
                labelText: "Historical Context",
                hintText: "Enter Village Historical Context",
                controller: provider.villageDescription,
                // validator: validateName,
              ),


              CustomTextField(
                labelText: "Current Status",
                hintText: "Enter Village Current Status",
                controller: provider.villageStatus,
                // validator: validateName,
              ),
              TextButton(
                child: Text(
                  imageFile == null
                      ?
                  "Select Village Image...":
                  path,
                ),
                onPressed: () {
                  _onAddImageClick(0);
                },
              ),
              CustomButton(
                buttonText: "Create Village Atlas",
                buttonColor: primaryAppColor,
                buttonTextColor: scaffoldBackgroundColor,
                borderRadius: heightValue30,
                onTap: () {
                 
                },
              ),
            ],
          ),
        ),
      ),
    );});

  }
  Future _onAddImageClick(int index) async {
    XFile? pickedFile =
    await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
        // getFileImage(0);
        path=imageFile!.path;
      });
    }
  }

}
