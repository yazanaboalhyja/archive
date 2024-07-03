import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../auth/provider.dart';
import '../../../core/utils/color_constants.dart';
import '../../../core/utils/global_constants.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_textfield.dart';
import '../../../widgets/height_space.dart';
import '../../settings/services/settings_services.dart';



class CreatePrisonerScreen extends StatefulWidget {
  static const route = '/create-prisoner';
  const CreatePrisonerScreen({super.key});

  @override
  State<CreatePrisonerScreen> createState() => _CreatePrisonerScreenState();
}

class _CreatePrisonerScreenState extends State<CreatePrisonerScreen> {

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
                      "Create Prisoner Profile",
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
      key: provider.addPrisonerKey,
      child: Center(
        child: SizedBox(
          width: 400,
          child: Column(
            children: [

              CustomTextField(
                labelText: "Prisoner Name",
                hintText: "Enter full name",
                controller: provider.prisonerNameController,
                // validator: validateName,
              ),
              CustomTextField(
                icon: IconButton(icon:Icon(Icons.calendar_month),

                  onPressed: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    lastDate: DateTime.now(),
                    firstDate: DateTime(1990),
                    initialDate: DateTime.now(),
                  );
                  if (pickedDate == null) return;

                  provider.dateOfBirthController.text=DateFormat('yyyy-MM-dd').format(pickedDate);

                },),
                labelText: "Date of birth",
                hintText: "Enter Prisoner Birth Date",
                controller:  provider.dateOfBirthController,
                // validator: validateEmail,
              ),
              CustomTextField(
                labelText: "Birth Place",
                hintText: "Enter Prisoner Birth Place",
                controller: provider.placeOfBirthController,
                // validator: validateEmail,
              ),

              CustomTextField(
                icon: IconButton(icon:Icon(Icons.calendar_month),

                  onPressed: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      lastDate: DateTime.now(),
                      firstDate: DateTime(1990),
                      initialDate: DateTime.now(),
                    );
                    if (pickedDate == null) return;

                    provider.dateOfArrestController.text=DateFormat('yyyy-MM-dd').format(pickedDate);

                  },),
                labelText: "Date of Arrest",
                hintText: "Enter Prisoner Arrest Date",
                controller:  provider.dateOfArrestController,
                // validator: validateEmail,
              ),

              CustomTextField(
                labelText: "Life Story",
                hintText: "Enter Life Story",
                controller: provider.lifeStoryController,
                // validator: validateName,
              ),
             TextButton(
                child: Text(
                    imageFile == null
                        ?
                        "Select Prisoner Image...":
                  path,
                ),
                onPressed: () {
                  _onAddImageClick(0);
                },
              ),
              CustomButton(
                buttonText: "Create Prisoner Profile",
                buttonColor: primaryAppColor,
                buttonTextColor: scaffoldBackgroundColor,
                borderRadius: heightValue30,
                onTap: () async{
                  if(provider.addPrisonerKey.currentState!.validate() ){
                    await provider.addPrisoner(
                        path ,'http://localhost:3000' , context);
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
