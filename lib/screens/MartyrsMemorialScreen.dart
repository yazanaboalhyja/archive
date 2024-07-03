import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:palestine_archive/Models/MartyrModel.dart';
import 'package:palestine_archive/app_router/app_router.dart';
import 'package:palestine_archive/screens/MartyrsProfile.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

import '../auth/provider.dart';
import '../components/MartyrsWidget.dart';
import 'AddNewMartyrOrPrisoner.dart';

class MartyrsMemorialPage extends StatefulWidget {
  @override
  _MartyrsMemorialPageState createState() => _MartyrsMemorialPageState();
}

class _MartyrsMemorialPageState extends State<MartyrsMemorialPage> {
  int SelectedFilter =0;
  String date="";
  final TextEditingController searchController = TextEditingController();

  List<MartyrsWidget> MartyrsWidgetList =[];
  List<MartyrModel> filteredMartyrs = [];

  void SelectDateFilter() async{

    await showDatePicker(
      context: context,
      initialDate:  DateTime.now(),
      firstDate: DateTime(1990),
      lastDate: DateTime.now(),
    ).then((selectedDate) {
      if (selectedDate != null) {
        setState(() {

date = DateFormat('yyyy-MM-dd').format(selectedDate);
        });
      }
    });}
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    searchController.addListener(_onSearchChanged);

}
  void _onSearchChanged() {
    Provider.of<AppProvider>(context , listen: false).searchMartyr(searchController.text);

  }
  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(builder: (context, provider, x) {
       MartyrsWidgetList =[];
       provider.MartyrFilterList.forEach((element) {
         MartyrsWidgetList.add(
             MartyrsWidget(element.full_name!,element.image_url!, element.views , element.id , element.type));
       });


      return Scaffold(


        floatingActionButton: provider.DbloggedUser.username!=''?FloatingActionButton(
          backgroundColor: const Color(0xffeeac07),
          tooltip: 'Add New Memorial',
          onPressed: (){

            AppRouter.appRouter.goToWidget(AddMartyrsOrPrisonerPage(false));
          },
          child: const Icon(Icons.add, color: Colors.white, size: 28),
        ):SizedBox(),
        body: SafeArea(
          child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                    'https://i.pinimg.com/564x/93/f2/7a/93f27a7f4785ac818ef5e6bbcfc83353.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 20),
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back_ios),
                        color: Colors.white,
                        onPressed: ()async {
                          await Provider.of<AppProvider>(context , listen: false).getMartyrs();
                          AppRouter.appRouter.hideDialoug();
                        },
                      ),
                      SizedBox(
                      height: 45,
                      width: MediaQuery.of(context).size.width*0.8,
                      child: TextField(
                        style: GoogleFonts.abel(
                          color: const Color(0xff020202),
                          fontSize: 20,
                          fontWeight: FontWeight.w100,
                          letterSpacing: 0.5,
                        ),
                        controller: searchController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: const Color(0xfff1f1f1),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide.none,
                          ),
                          hintText: "Search for Martyrs...",

                          hintStyle: GoogleFonts.poppins(
                              color: const Color(0xffb2b2b2),
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                              letterSpacing: 0.5,
                              decorationThickness: 6),
                          prefixIcon: const Icon(Icons.search),
                          prefixIconColor: Colors.black,
                        ),
                      ),
                    ),
                      Expanded(child: SizedBox(
                          child:
                          PopupMenuButton(

                            icon: const Icon(Icons.filter_list_rounded,color: Colors.white,),
                            onSelected: (item) =>
                                AppRouter.appRouter.goToWidget(AddMartyrsOrPrisonerPage(false)),
                            itemBuilder: (context) => [
                              PopupMenuItem(

                                child: StatefulBuilder(
                                  builder: (_context, _setState) =>
                                      CheckboxListTile(
                                        contentPadding: EdgeInsets.zero,

                                        activeColor: Colors.amber,
                                        value: SelectedFilter==0,
                                        onChanged:  (value) {
                                          //isSelected=value!;
                                          _setState(() => SelectedFilter = 0);
                                          provider.getMartyrs();
                                          AppRouter.appRouter.hideDialoug();
                                        },
                                        title: Text("Page View"),
                                      ),

                                ),
                              ),
                              PopupMenuItem(

                                child: StatefulBuilder(
                                  builder: (_context, _setState) =>
                                      CheckboxListTile(
                                        activeColor: Colors.amber,
                                        value: SelectedFilter==1,
                                        onChanged: (value) {
                                          AppRouter.appRouter.hideDialoug();

                                          AppRouter.appRouter.showAlertDialog(context, {
                                            "Tulkarm": Provider.of<AppProvider>(context , listen: false).searchMartyrByBirthPlace,
                                            "Jenin": Provider.of<AppProvider>(context , listen: false).searchMartyrByBirthPlace ,
                                            "Ramallah":Provider.of<AppProvider>(context , listen: false).searchMartyrByBirthPlace,
                                            "Nablus":Provider.of<AppProvider>(context , listen: false).searchMartyrByBirthPlace});

                                          _setState(() => SelectedFilter = 1);
                                        }
                                        ,
                                        title: Text("Birth Place"),
                                      ),

                                ),
                              ),
                              PopupMenuItem(

                                child: StatefulBuilder(
                                  builder: (_context, _setState) =>
                                      CheckboxListTile(
                                        activeColor: Colors.amber,
                                        value: SelectedFilter==2,
                                        onChanged: (value) {
                                          AppRouter.appRouter.hideDialoug();
                                          AppRouter.appRouter.showAlertDialog(context, {
                                            "Tulkarm": Provider.of<AppProvider>(context , listen: false).searchMartyrByDeathPlace,
                                            "Jenin": Provider.of<AppProvider>(context , listen: false).searchMartyrByDeathPlace ,
                                            "Ramallah":Provider.of<AppProvider>(context , listen: false).searchMartyrByDeathPlace,
                                            "Nablus":Provider.of<AppProvider>(context , listen: false).searchMartyrByDeathPlace});

                                          _setState(() => SelectedFilter = 2);}
                                        ,
                                        title: Text("Death Place"),
                                      ),

                                ),

                              ),
                              PopupMenuItem(

                                child: StatefulBuilder(
                                  builder: (_context, _setState) =>
                                      CheckboxListTile(
                                        activeColor: Colors.amber,
                                        value: SelectedFilter==3,
                                        onChanged: (value) async{
                                          _setState(() => SelectedFilter = 3);

                                          AppRouter.appRouter.hideDialoug();

                                          AppRouter.appRouter.showAlertDialog(context, {"Today":  provider.getMartyrforToday,"Select Date": SelectDateFilter} , );


                                        }
                                        ,
                                        title: Text("Death Date"),
                                      ),

                                ),
                              ),
                            ],
                          )

                      )),
                  ]),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      children: [

                        Expanded(child: SizedBox()),
                        Text(
                          "martyrs_memorial".tr(),
                          style:  TextStyle(
                              fontSize: 30,
                             // fontWeight: FontWeight.bold,
                              color: !Provider.of<AppProvider>(context , listen: false).darkTheme?Color(0xFF00416b): Colors.white
                          ),
                        ),
                        const Icon(
                          LineAwesomeIcons.memory,
                        //  color: Colors.blue,
                          size: 30,
                        ),
                        Expanded(child: SizedBox()),
                      ],
                    ),
                  ),
                  const SizedBox(height: 50),
                  Container(
                      margin: EdgeInsets.only(left: 30),
                      width: double.infinity,
                      alignment: Alignment.centerLeft,
                      child: MartyrsWidgetList.isNotEmpty?Wrap(
                        spacing: 20,
                        runSpacing: 30,
                        children: [

                       ...MartyrsWidgetList
                        ],
                      ):Center(
                        child: Text("No Data Found.."),
                      ))
                  ,
                ],
              ),
            ),
          ),
        ),
      );

    }


    );
  }
}


