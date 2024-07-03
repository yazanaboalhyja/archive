import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:palestine_archive/app_router/app_router.dart';
import 'package:http/http.dart' as http;
import 'package:palestine_archive/auth/provider.dart';
import 'package:provider/provider.dart';

import '../Models/ImageUploadModel.dart';

class AddMartyrsOrPrisonerPage extends StatefulWidget {
  bool isPrisoners;

  AddMartyrsOrPrisonerPage([this.isPrisoners=false]);

  @override
  State<AddMartyrsOrPrisonerPage> createState() =>
      _AddMartyrsOrPrisonerPageState();
}

class _AddMartyrsOrPrisonerPageState extends State<AddMartyrsOrPrisonerPage> {
  File? imageFile  ;
  String path ="";
  var imagePath;

  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(builder: (context, provider, x) {
      return Scaffold(
        backgroundColor: Color(0xffeeac07),
        body: SafeArea(
            child: Stack(
              children: [
                Column(
                  children: [
                    headerChat(),
                    bodyChat(),
                  ],
                ),
                inputChat('add'.tr(), null, provider)
              ],
            )),
      );});
    }

        Widget headerChat() {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.arrow_back_ios,
                      size: 25,
                      color: Colors.white,
                    )),
                Text(
                  widget.isPrisoners!
                      ? 'add_new_prisoner'.tr()
                      : 'add_new_martyrs_memorial'.tr(),
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                )
              ],
            ),
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.black12),
                  child: Icon(
                    Icons.add,
                    size: 25,
                    color: Colors.white,
                  ),
                )
              ],
            )
          ],
        ),
      );
    }

    Widget bodyChat() {
      return Consumer<AppProvider>(builder: (context, provider, x) {
        return Expanded(
          child: SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height+700,
              padding: EdgeInsets.only(left: 20, right: 20, top: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
                color: Color(0xffb8b8b8),
              ),
              child: Form(
                key: widget.isPrisoners?provider.addPrisonerKey:provider.addMartyrKey,
                child: ListView(
                  physics: BouncingScrollPhysics(),
                  children: [
                    Card(
                      child: Container(
                        height: MediaQuery.of(context).size.width * 0.6,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withOpacity(0.4),
                                offset: Offset(0, 25),
                                blurRadius: 10,
                                spreadRadius: -2)
                          ],
                          color: !provider.darkTheme ?Colors.white:Colors.grey,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: imageFile == null
                            ? IconButton(
                          icon: Icon(Icons.photo),
                          onPressed: () {
                            _onAddImageClick(0);
                          },
                        )
                            : Image.file(
                          imageFile!,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    widget.isPrisoners!
                        ? inputChat("prisoner_name".tr(), provider.prisonerNameController,
                        provider)
                        : inputChat("martyr_name".tr(), provider.martyrNameController,
                        provider),
                    !widget.isPrisoners!
                        ? SizedBox()
                        :
                    inputChat("birth_place".tr(), provider.placeOfBirthController,
                        provider),

                    inputChat("birth_date".tr(), provider.dateOfBirthController,
                        provider),
                    widget.isPrisoners!
                        ? SizedBox()
                        : inputChat("nationality".tr(),
                        provider.nationalityController, provider),

                    widget.isPrisoners!
                        ? inputChat("arrest_date".tr(),
                        provider.dateOfArrestController, provider)
                        : inputChat("death_of_date".tr(),
                        provider.dateOfDeathController, provider),
                    widget.isPrisoners!
                        ? SizedBox()
                        : inputChat("place_of_death".tr(),
                        provider.placeOfDeathController, provider),
                    widget.isPrisoners!
                        ? SizedBox()
                        : inputChat("cause_of_death".tr(),
                        provider.causeOfDeathController, provider),
                    widget.isPrisoners!?
                    inputChat(
                        "life_story".tr(), provider.lifeStoryController, provider):
                    inputChat(
                        "description".tr(), provider.deathStoryController, provider)
                    ,
                  ],
                ),
              ),
            ),
          ),
        );
      });
    }

    Widget inputChat(
        String text, TextEditingController? controller, AppProvider provider) {
      return Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          margin: EdgeInsets.all(5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: !provider.darkTheme ?Colors.white:Colors.black26,

          ),
          height: text == "life_story".tr()||text == "description".tr()
              ? 500
              : text != 'add'.tr()
              ? 100
              : 50,
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
          child: text != 'add'.tr()
              ? TextFormField(
              controller: controller,
              keyboardType: text != "life_story".tr() ||text != "description".tr()
                  ? TextInputType.text
                  : TextInputType.multiline,
              maxLines: null,
              expands: text == "life_story".tr() ||text == "description".tr() ? true : false,
              readOnly: text.contains("تاريخ")||text.contains("Date"),
              decoration: InputDecoration(
                icon: text.contains("تاريخ")||text.contains("Date")
                    ? IconButton(
                    onPressed: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        lastDate: DateTime.now(),
                        firstDate: DateTime(1990),
                        initialDate: DateTime.now(),
                      );
                      if (pickedDate == null) return;
                      text.contains("الميلاد")||text.contains("birth")?
                       provider.dateOfBirthController.text = DateFormat('yyyy-MM-dd').format(pickedDate)
                    : text.contains("الاستشهاد")||text.contains("Death")?
                      provider.dateOfDeathController.text = DateFormat('yyyy-MM-dd').format(pickedDate)
                      :
                      provider.dateOfArrestController.text = DateFormat('yyyy-MM-dd').format(pickedDate);


                    },
                    icon: Icon(Icons.calendar_month))
                    : null,
                hintText: "$text",
                filled: true,
                labelStyle: TextStyle(fontSize: 12),
                contentPadding: EdgeInsets.all(20),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.purple.shade100),
                    borderRadius: BorderRadius.circular(25)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.purple.shade100),
                    borderRadius: BorderRadius.circular(25)),
              ),
              validator: (val) {
                //Validation
                if (val == null || val.isEmpty) {
                  return 'Please enter some data into field';
                }
                return null;
              })
              : Row(children: [
            SizedBox(
              width: 200,
              child: ElevatedButton(
                onPressed: (() async {
                  if ( widget.isPrisoners && provider.addPrisonerKey.currentState!.validate()) {
                    // await SignIn(provider.loginEmailController.text,provider.passwordLoginController.text);
                    await provider.addPrisoner(
                    path
                    );
                    print(path);
                  }
                  else if(!widget.isPrisoners&&provider.addMartyrKey.currentState!.validate() ){
                    await provider.addMartyr(
                        path);
                  }
                  else {
                    print('not valid');
                  }
                }),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xffeeac07),
                    side: BorderSide.none,
                    shape: const StadiumBorder()),
                child:!provider.isLoading?

                Text(text, style: TextStyle(color: Colors.white)):
                    CircularProgressIndicator()
                ,
              ),
            ),
            Expanded(child: SizedBox())
          ]),
        ),
      );
    }

    Future _onAddImageClick(int index) async {
      XFile? pickedFile =
      await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        setState(() {
          imageFile = File(pickedFile.path);
          getFileImage(0);
          path=imageFile!.path;
        });
      }
    }

    void getFileImage(int index) async {
      setState(() {

        ImageUploadModel imageUpload = new ImageUploadModel();
        imageUpload.isUploaded = false;
        imageUpload.uploading = false;
        imageUpload.imageFile = imageFile;
        imageUpload.imageUrl = '';
      });
    }
  }
