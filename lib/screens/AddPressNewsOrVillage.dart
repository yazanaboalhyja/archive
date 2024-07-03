

import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:palestine_archive/app_router/app_router.dart';
import 'package:palestine_archive/components/MultiSelectChip.dart';
import 'package:provider/provider.dart';

import '../Models/ImageUploadModel.dart';
import '../auth/provider.dart';

class AddPressNewsOrVillagePage extends StatefulWidget {
  late bool isPressNews ;
  AddPressNewsOrVillagePage(bool isPressNews){
    this.isPressNews = isPressNews;
  }
  @override
  State<AddPressNewsOrVillagePage> createState() => _AddPressNewsOrVillagePageState();
}

class _AddPressNewsOrVillagePageState extends State<AddPressNewsOrVillagePage> {
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
  File? imageFile;
  String path ="";



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
              inputChat('add'.tr(),TextEditingController(),provider)
            ],
          )
      ),
    );});
  }


  Widget headerChat(){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,

        children: [
          Row(
            children: [
              IconButton(onPressed: () {
                Navigator.pop(context);
              },
                  icon: Icon(Icons.arrow_back_ios, size: 25,color: Colors.white,)),
              Text(widget.isPressNews?'add_new_press_news'.tr():"add_new_village".tr(), style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),)
            ],
          ),
          Row(
            children: [

              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.black12
                ),
                child: Icon(Icons.add, size: 25, color: Colors.white,),
              )
            ],
          )

        ],
      ),
    );
  }



  Widget bodyChat(){
    return Consumer<AppProvider>(builder: (context, provider, x) {

    return Expanded(
      child: SingleChildScrollView(
        child: Container(
          height: widget.isPressNews? 1300:1000,
          padding: EdgeInsets.only(left: 20, right: 20, top: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40),
              topRight: Radius.circular(40),
            ),
            color: Color(0xffb8b8b8),
          ),
          child: ListView(
           physics: BouncingScrollPhysics(),
            children: [
              Form(
                key: widget.isPressNews?provider.addNewsKey:provider.addVillageKey,
                child: Card(
                  child: Container(
                    height: MediaQuery.of(context)
                        .size
                        .width *
                        0.6,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black
                                .withOpacity(0.4),
                            offset: Offset(0, 25),
                            blurRadius: 10,
                            spreadRadius: -2)
                      ],
                      color: Colors.white,
                      borderRadius:
                      BorderRadius.circular(10.0),

                    ),
                    child: imageFile == null
                        ?  IconButton(
                      icon: Icon(Icons.photo),
                      onPressed: () {
                        _onAddImageClick(0);
                      },
                    ): Image.file(
                      imageFile!,
                      fit: BoxFit.cover,
                    ),

                  ),

                ),
              ),
              SizedBox(height: 10,),
              widget.isPressNews?
              inputChat("عنوان الخبر" , provider.newsTitle , provider):
              inputChat("اسم القرية" , provider.villageName , provider),
              widget.isPressNews?
              inputChat("مصدر الخبر" , provider.NewsSource,provider):
              inputChat("موقع القرية" , provider.villageLocation,provider)
              ,
              widget.isPressNews?
              inputChat("محتوى الخبر" , provider.NewsContent, provider):
              inputChat("وصف تاريخي عن القرية" , provider.villageDescription,provider)
              ,

              widget.isPressNews?
              SizedBox():
              inputChat("حالة القرية الحالية" , provider.villageStatus, provider),
              widget.isPressNews?
              inputChat("فئة الخبر" , TextEditingController(), provider):
              SizedBox()
              ,
          
            ],

          ),
        ),
      ),
    );});
  }



  Widget inputChat(String text , TextEditingController myController ,  AppProvider provider){
    return
      Align(
        alignment: Alignment.bottomCenter,
        child: Container(
         // color: Colors.white,
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: !provider.darkTheme ?Colors.white:Colors.black26,

          ),
          height: text=="محتوى الخبر"|| text=="فئة الخبر"|| text == "وصف تاريخي عن القرية"?320:text !='add'.tr()?100:50,
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
          child: text !='add'.tr() ?
          text !="فئة الخبر"?
          TextField(
            keyboardType:  text !="محتوى الخبر" || text != "وصف تاريخي عن القرية"?TextInputType.text:TextInputType.multiline,
            controller: myController,
            maxLines: null,
            expands: text=="محتوى الخبر"|| text == "وصف تاريخي عن القرية"?true:false,
            decoration: InputDecoration(
              hintText: "$text",
              filled: true,
              //fillColor: Colors.purple.shade100,

              labelStyle: TextStyle(fontSize: 12),
              contentPadding: EdgeInsets.all(20),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.purple.shade100),
                  borderRadius: BorderRadius.circular(25)
              ),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.purple.shade100),
                  borderRadius: BorderRadius.circular(25)
              ),

            ),
          ):
           MultiSelectChip(NewsCategory,provider)

              :
          Row(
              children: [
                SizedBox(
                  width: 200,
                  child: ElevatedButton(
                    onPressed: (() async {
                      if ( widget.isPressNews && provider.addNewsKey.currentState!.validate()) {
                        await provider.addNewReport(
                            path
                        );
                        print(path);
                      }
                      else if(!widget.isPressNews&&provider.addVillageKey.currentState!.validate() ){
                        await provider.addNewVillage(
                            path);
                      }
                      else {
                        print('not valid');
                      }
                    }),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xffeeac07), side: BorderSide.none, shape: const StadiumBorder()),
                    child:  Text(text, style: TextStyle(color: Colors.white)),
                  ),
                ),
                Expanded(child: SizedBox())
              ] ),
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

