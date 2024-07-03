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



class CreateMartyrScreen extends StatefulWidget {
  static const route = '/create-martyr';
  const CreateMartyrScreen({super.key});

  @override
  State<CreateMartyrScreen> createState() => _CreateAdminScreenState();
}

class _CreateAdminScreenState extends State<CreateMartyrScreen> {


  File? imageFile  ;
  String path ="";




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
                      "Create Martyr Profile",
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
      key: provider.addMartyrKey,
      child: Center(
        child: SizedBox(
          width: 400,
          child: Column(
            children: [

              CustomTextField(
                labelText: "Martyr Name",
                hintText: "Enter full name",
                controller:  provider.martyrNameController,
                // validator: validateName,
              ),
              CustomTextField(
                labelText: "Nationality",
                hintText: "Enter Martyr Nationality",
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

                  provider.dateOfBirthController.text=DateFormat('yyyy-MM-dd').format(pickedDate);

                },),
                labelText: "Date of birth",
                hintText: "Enter Martyr Birth Date",
                controller: provider.dateOfBirthController,
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

                    provider.dateOfDeathController.text=DateFormat('yyyy-MM-dd').format(pickedDate);

                  },),
                labelText: "Date of Death",
                hintText: "Enter Martyr Death Date",
                controller: provider.dateOfDeathController,
                // validator: validateEmail,
              ),
              CustomTextField(
                labelText: "Death Place",
                hintText: "Enter Martyr Death Place",
                controller:  provider.placeOfDeathController,
                // validator: validateEmail,
              ),
              CustomTextField(
                labelText: "Martyr Cause Of Death",
                hintText: "Enter Cause of Death",
                controller:  provider.causeOfDeathController,
                // validator: validateName,
              ),
              CustomTextField(
                labelText: "Martyr Life description",
                hintText: "Enter Life description",
                controller:  provider.lifeStoryController,
                // validator: validateName,
              ),
             TextButton(
                child: Text(
                    imageFile == null
                        ?
                        "Select Martyr Image...":
                  path,
                ),
                onPressed: () {
                  _onAddImageClick(0);
                },
              ),
              CustomButton(
                buttonText: "Create Martyr Profile",
                buttonColor: primaryAppColor,
                buttonTextColor: scaffoldBackgroundColor,
                borderRadius: heightValue30,
                onTap: () async{

                  if(provider.addMartyrKey.currentState!.validate() ){
                    await provider.addMartyr(
                        path ,'http://localhost:3000');
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
