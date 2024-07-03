import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../auth/provider.dart';
import '../../../components/MultiSelectChip.dart';
import '../../../core/utils/color_constants.dart';
import '../../../core/utils/global_constants.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_textfield.dart';
import '../../../widgets/height_space.dart';
import '../../settings/services/settings_services.dart';



class AddNewNewsScreen extends StatefulWidget {
  static const route = '/create-news';
  const AddNewNewsScreen({super.key});

  @override
  State<AddNewNewsScreen> createState() => _CreateVillageScreenState();
}

class _CreateVillageScreenState extends State<AddNewNewsScreen> {


  bool obscureText = true;
  bool obscureText2 = true;

  String? errorText;
  String? successMessage = '';
  String misMatchPasswordErrorText = '';

  File? imageFile  ;
  String path ="";
  List<String> NewsCategory =[
    "General",
    "Business",
    "Sport",
    "Art",
    "Education",
    "Humanitarian Efforts",
    "Diplomatic Initiatives",
    "Cultural Events",
    "Health",
    "Economy",
  ];
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
                      "Add Last News",
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
      key: provider.addNewsKey,
      child: Center(
        child: SizedBox(
          width: 400,
          child: Column(
            children: [


              CustomTextField(
                labelText: "News Title",
                hintText: "Enter news Title",
                controller: provider.newsTitle,
                // validator: validateEmail,
              ),
              CustomTextField(
                labelText: "News source",
                hintText: "Enter news Source",
                controller: provider.NewsSource,
                // validator: validateEmail,
              ),

              CustomTextField(
                labelText: "News content",
                hintText: "Enter news content",
                controller: provider.NewsContent,
                // validator: validateEmail,
              ),


              MultiSelectChip(NewsCategory,provider),

              TextButton(
                child: Text(
                  imageFile == null
                      ?
                  "Select Image For Report...":
                  path,
                ),
                onPressed: () {
                  _onAddImageClick(0);
                },
              ),
              CustomButton(
                buttonText: "Add New Report",
                buttonColor: primaryAppColor,
                buttonTextColor: scaffoldBackgroundColor,
                borderRadius: heightValue30,
                onTap: () async {
                  if (provider.addNewsKey.currentState!.validate()) {
                    await provider.addNewReport(
                        path ,'http://localhost:3000'
                    );
                    print(path);
                  }

                  else {
                    print('not valid');
                  }

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
