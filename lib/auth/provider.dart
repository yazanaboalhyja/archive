import 'dart:io';

import 'package:flutter/material.dart';
import 'package:palestine_archive/Models/MartyrModel.dart';
import 'package:palestine_archive/Models/NewsModel.dart';
import 'package:palestine_archive/Models/PrisonerModel.dart';
import 'package:palestine_archive/Models/VideoModel.dart';
import 'package:palestine_archive/Models/VillageModel.dart';
import 'package:palestine_archive/app_router/app_router.dart';
import 'package:palestine_archive/reposetories/ApiService.dart';
import 'package:palestine_archive/screens/MainScreen.dart';
import 'package:palestine_archive/screens/Welcome.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:string_validator/string_validator.dart';
import 'package:easy_localization/easy_localization.dart';

import '../Models/ActivityModel.dart';
import '../Models/UserModel.dart';
import '../core/utils/custom_dialogs.dart';

class AppProvider extends ChangeNotifier {
  GlobalKey<FormState> signInKey = GlobalKey();
  GlobalKey<FormState> signUpKey = GlobalKey();
  GlobalKey<FormState> addPrisonerKey = GlobalKey();
  GlobalKey<FormState> addMartyrKey = GlobalKey();
  GlobalKey<FormState> addVideoKey = GlobalKey();
  GlobalKey<FormState> addNewsKey = GlobalKey();
  GlobalKey<FormState> addVillageKey = GlobalKey();


  TextEditingController registerEmailController = TextEditingController();
  TextEditingController searchTextEditingController = TextEditingController();
  TextEditingController loginEmailController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController userPhoneController = TextEditingController();
  TextEditingController passwordRegisterController = TextEditingController();
  TextEditingController passwordLoginController = TextEditingController();


  TextEditingController prisonerNameController = TextEditingController();
  TextEditingController dateOfBirthController = TextEditingController();
  TextEditingController dateOfArrestController = TextEditingController();
  TextEditingController placeOfBirthController = TextEditingController();
  TextEditingController lifeStoryController = TextEditingController();

  TextEditingController martyrNameController = TextEditingController();
  TextEditingController dateOfDeathController = TextEditingController();
  TextEditingController causeOfDeathController = TextEditingController();
  TextEditingController placeOfDeathController = TextEditingController();
  TextEditingController nationalityController = TextEditingController();
  TextEditingController deathStoryController = TextEditingController();

  TextEditingController locationController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();


  TextEditingController newsTitle =  TextEditingController() ,
      NewsContent =  TextEditingController() , NewsSource =  TextEditingController() , NewsType =  TextEditingController();

  TextEditingController villageName =  TextEditingController() ,
      villageDescription =  TextEditingController() ,
      villageLocation =  TextEditingController(),villageStatus =  TextEditingController() ;



  final String key = "theme";
  SharedPreferences? _prefs;
  late File _imageFile  ;
  late MartyrModel? _selectedMartyr;
  late PrisonerModel _selectedPrisoner;
  late VideoModel _selectedVideo;
  late NewsModel _selectedNews;
  late VillageModel _selectedVillage;
  bool isLoading = false;
   UserModel _DbloggedUser=UserModel(username: '', name: '');
   List<Map<String,dynamic>> _AIChatMap = [
     {"chat":1,
   "message" :"مرحباً أنا صديقتك ليلى  , تشرفت بمعرفتك , أنا هنا لأكون رفيقتك في رحلتك لاستكشاف تاريخ فلسطين وللإجابة على جميع استفساراتك بكل ما يتعلق بالقضايا المعاصرة , هل أنت مستعد؟ هيا لنبدأ رحلتنا ... يمكنك طرح جميع الأسئلة التي تخطر على بالك عن فلسطين وتراثها لأجيب عليها",
"time" : "${DateTime.now().hour.toString()}:${DateTime.now().minute.toString()}"
   }];
List<MartyrModel> _MartyrFilterList =[];
  List<PrisonerModel> _PrisonerFilterList =[];
  List<NewsModel> _NewsFilterList =[];
  List<VillageModel> _VillageFilterList =[];
  List<VideoModel> _VideoFilterList =[];
  List<ActivityModel> _ActivityFilterList =[];
  late bool _darktheme;

  bool get darkTheme => _darktheme;
  File get imageFile => _imageFile;
  MartyrModel get selectedMartyr => _selectedMartyr!;
  PrisonerModel get selectedPrisoner => _selectedPrisoner;
  VideoModel get selectedVideo => _selectedVideo;
  NewsModel get selectedNews => _selectedNews;
  VillageModel get selectedVillage => _selectedVillage;
  List<Map<String,dynamic>> get AIChatMap => _AIChatMap;
  UserModel get DbloggedUser => _DbloggedUser;
  List<MartyrModel> get MartyrFilterList => _MartyrFilterList;
  List<PrisonerModel> get PrisonerFilterList => _PrisonerFilterList;
  List<NewsModel> get NewsFilterList => _NewsFilterList;
  List<VillageModel> get VillageFilterList => _VillageFilterList;
  List<VideoModel> get VideoFilterList => _VideoFilterList;
  List<ActivityModel> get ActivityFilterList => _ActivityFilterList;
  AppProvider() {
    _darktheme = false;
    getMartyrs();
    getPrisoners();
    getNews();
    getVillages();
    getVideos();
    _loadprefs();
  }

  switchthemelight() {
    _darktheme = false;
    _saveprefs();
    notifyListeners();
  }

  switchthemedark() {
    _darktheme = true;
    _saveprefs();
    notifyListeners();
  }

  _initiateprefs() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  _loadprefs() async {
    await _initiateprefs();
    _darktheme = _prefs?.getBool(key) ?? false;
    notifyListeners();
  }

  _saveprefs() async {
    await _initiateprefs();
    _prefs?.setBool(key, _darktheme);
  }

  String? emailValidation(String email) {
    if (email == null || email.isEmpty) {
      return "Required field";
    } else if (!(isEmail(email))) {
      return "Incorrect email syntax";
    }
  }

  String? passwordValidation(String password) {
    if (password == null || password.isEmpty) {
      return "Required field";
    }
    else if (password.length <= 3) {
      return 'Error, the password must be larger than 6 letters';
    }
  }
  SignIn() async {
    if (signInKey.currentState!.validate()) {
      isLoading = true;
      notifyListeners();
      signInKey.currentState!.save();
      try {
       _DbloggedUser= (await ApiService.apiHelper.SignIn(
            loginEmailController.text, passwordLoginController.text))!;
       print(DbloggedUser!.name);
       getMyActivity();

      }catch(ex){
        print(ex.toString());
      }
      loginEmailController.text="";
      passwordLoginController.text="";
      isLoading = false;
      notifyListeners();
    }
  }
  SignUp() async {
    if (signUpKey.currentState!.validate()) {
      isLoading = true;
      notifyListeners();
      signUpKey.currentState!.save();
      try {
        await ApiService.apiHelper.SignUp(
            registerEmailController.text, passwordRegisterController.text,
        userPhoneController.text,userNameController.text
        );
      }catch(ex){
        print(ex.toString());
      }
      registerEmailController.text="";
      passwordRegisterController.text="";
      userNameController.text="";
      userPhoneController.text="";
      isLoading = false;
      notifyListeners();
    }
  }
  addPrisoner(String photoUrl ,[String? WebURL , BuildContext? context]) async {
    if (addPrisonerKey.currentState!.validate()) {
      isLoading = true;
      notifyListeners();
      addPrisonerKey.currentState!.save();
      try {
        if(photoUrl!="") {
          WebURL==null?
          await ApiService.apiHelper.AddPrisoner(
              dateOfBirthController.text,
              placeOfBirthController.text,
              lifeStoryController.text,
              dateOfArrestController.text,
              prisonerNameController.text,
              photoUrl
          ):
          await ApiService.apiHelper.AddPrisoner(
              dateOfBirthController.text,
              placeOfBirthController.text,
              lifeStoryController.text,
              dateOfArrestController.text,
              prisonerNameController.text,
              photoUrl,
            WebURL ,
            context
          )
          ;
          dateOfBirthController.text="";
          placeOfBirthController.text="";
          lifeStoryController.text="";
          prisonerNameController.text="";
          dateOfArrestController.text="";
        }
        else{
        WebURL==null?
        AppRouter.appRouter.showCustomDialoug("خطأ في البياتات", "تأكد أنك قمت برفع صورة مناسبة قبل عملية تأكيد الإصافة"):
        showErrorMessage(
            context: context!,
            title: "خطأ في البياتات",
            message:'message: تأكد أنك قمت برفع صورة مناسبة قبل عملية تأكيد الإصافة',
            onTap: () {
              AppRouter.appRouter.hideDialoug()  ;
            });

        ;
        }
      }catch(ex){
        print(ex.toString());
      }

      isLoading = false;
      notifyListeners();
    }
  }


  addNewReport(String photoUrl , [String? WebURL] ) async {
    if (addNewsKey.currentState!.validate()) {
      isLoading = true;
      notifyListeners();
      addNewsKey.currentState!.save();
      try {
        if(photoUrl!="") {
          WebURL==null?
          await ApiService.apiHelper.AddNewsReport(
              newsTitle.text,
              NewsSource.text,
              NewsContent.text,
              NewsType.text,
              photoUrl
          ):
          await ApiService.apiHelper.AddNewsReport(
              newsTitle.text,
              NewsSource.text,
              NewsContent.text,
              NewsType.text,
              photoUrl,WebURL
          )

          ;
          newsTitle.clear();
          NewsSource.clear();
          NewsContent.clear();
          NewsType.clear();


        } else{
          AppRouter.appRouter.showCustomDialoug("خطأ في البياتات", "تأكد أنك قمت برفع صورة مناسبة قبل عملية تأكيد الإصافة");
        }
      }catch(ex){
        print(ex.toString());
      }


      // getNews();


      isLoading = false;
      notifyListeners();
    }

  }
  addNewVillage(String photoUrl ) async {
    if (addVillageKey.currentState!.validate()) {
      isLoading = true;
      notifyListeners();
      addVillageKey.currentState!.save();
      try {
        if(photoUrl!="") {
          await ApiService.apiHelper.AddNewVillage(
              villageName.text,
              villageLocation.text,
              villageDescription.text,
              villageStatus.text,
              photoUrl
          );
          villageName.clear();
          villageLocation.clear();
          villageStatus.clear();
          villageDescription.clear();


        } else{
          AppRouter.appRouter.showCustomDialoug("خطأ في البياتات", "تأكد أنك قمت برفع صورة مناسبة قبل عملية تأكيد الإصافة");
        }
      }catch(ex){
        print(ex.toString());
      }


     // getVillage();


      isLoading = false;
      notifyListeners();
    }

  }

  addMartyr(String photoUrl , [String? WebURL] ) async {
    if (addMartyrKey.currentState!.validate()) {
      isLoading = true;
      notifyListeners();
      addMartyrKey.currentState!.save();
      try {
        if(photoUrl!="") {
          WebURL==null?
          await ApiService.apiHelper.AddMartyr(
              dateOfBirthController.text,
              deathStoryController.text,
              dateOfDeathController.text,
              martyrNameController.text,
              nationalityController.text,
              placeOfDeathController.text,
              causeOfDeathController!.text!,
              photoUrl
          ):
          await ApiService.apiHelper.AddMartyr(
              dateOfBirthController.text,
              deathStoryController.text,
              dateOfDeathController.text,
              martyrNameController.text,
              nationalityController.text,
              placeOfDeathController.text,
              causeOfDeathController!.text!,
              photoUrl , WebURL
          )

          ;
          dateOfBirthController.clear();
          placeOfBirthController.clear();
          deathStoryController.clear();
          causeOfDeathController.clear();
          dateOfDeathController.clear();
          martyrNameController.clear();
          nationalityController.clear();
          placeOfDeathController.clear();

        } else{
          AppRouter.appRouter.showCustomDialoug("خطأ في البياتات", "تأكد أنك قمت برفع صورة مناسبة قبل عملية تأكيد الإصافة");
        }
      }catch(ex){
        print(ex.toString());
      }
     // getReviewMartyrs();
      isLoading = false;
      notifyListeners();
    }

  }
  addVideo(String VideoUrl ) async {
    if (addVideoKey.currentState!.validate()) {
      isLoading = true;
      notifyListeners();
      addVideoKey.currentState!.save();
        try {
          if(VideoUrl!="") {

            await ApiService.apiHelper.AddVideo(
              locationController.text,
              descriptionController.text,
              VideoUrl
          );
          locationController.text="";
          descriptionController.text="";
          }else{
            AppRouter.appRouter.showCustomDialoug("خطأ في البياتات", "تأكد أنك قمت بتحميل الفيديو قبل عملية تأكيد الإصافة");

          }
        } catch (ex) {
          print(ex.toString());
        }

      isLoading = false;
      notifyListeners();
    }
  }
   getSelectedMartyr(int id,[String? webURL]) async{
    _selectedMartyr =webURL==null? await ApiService.apiHelper.getMartyrById(id):
    await ApiService.apiHelper.getMartyrById(id , webURL)
    ;
    webURL==null? getMartyrs():getMartyrs(webURL);
    notifyListeners();
  }
  getSelectedPrisoner(int id,[String? webURL]) async{
    _selectedPrisoner =webURL==null? await ApiService.apiHelper.getPrisonerById(id) :
    await ApiService.apiHelper.getPrisonerById(id , webURL);
    webURL==null? getPrisoners():getPrisoners(webURL);
    notifyListeners();
  }
  getSelectedVideo(int id,[String? webURL]) async{
    _selectedVideo = webURL==null?await ApiService.apiHelper.getVideoById(id)
    :await ApiService.apiHelper.getVideoById(id , webURL)
    ;
    webURL==null?getVideos():getVideos(webURL);
    notifyListeners();
  }
  getSelectedNews(int id ,[String? webURL]) async{
    _selectedNews = webURL==null?await ApiService.apiHelper.getNewsById(id): await ApiService.apiHelper.getNewsById(id ,webURL);
    getNews();
    notifyListeners();
  }
  getSelectedVillage(int id,[String? webURL]) async{
    _selectedVillage = webURL==null? await ApiService.apiHelper.getVillageById(id):
    await ApiService.apiHelper.getVillageById(id , webURL);
    getVillages();
    notifyListeners();
  }
  getMartyrs([String? webURL]) async{
    _MartyrFilterList=[];
    _MartyrFilterList = webURL==null?
    await ApiService.apiHelper.getMartyrs(): await ApiService.apiHelper.getMartyrs(webURL);
    print(_MartyrFilterList.length);
    notifyListeners();
  }
  searchMartyr(String text)async{
    if(text.isEmpty){
      getMartyrs();
    }
    else{
      _MartyrFilterList= _MartyrFilterList.where((element) =>
      element.full_name!.toLowerCase().contains(text.toLowerCase())||
          element.description!.toLowerCase().contains(text.toLowerCase())

      ).toList();
  }
    notifyListeners();
  }
  searchNews(String text)async{
    if(text.isEmpty){
      getNews();
    }
    else{
      _NewsFilterList= _NewsFilterList.where((element) =>
      element.name!.toLowerCase().contains(text.toLowerCase())||
          element.description!.toLowerCase().contains(text.toLowerCase())||
    element.submitted_by_name!.toLowerCase().contains(text.toLowerCase())||
          element.source!.toLowerCase().contains(text.toLowerCase())
      ).toList();
    }
    notifyListeners();
  }
  searchVideos(String text)async{
    if(text.isEmpty){
      getVideos();
    }
    else{
      _VideoFilterList= _VideoFilterList.where((element) =>
          element.description!.toLowerCase().contains(text.toLowerCase())||
          element.submitted_by_name!.toLowerCase().contains(text.toLowerCase())
      ).toList();
    }
    notifyListeners();
  }
  filterNewsByDate(String date)async{
    if(date.isEmpty){
      getNews();
    }
    else{
      print(date);

      _NewsFilterList= _NewsFilterList.where((element) =>
          DateTime.parse(element.created_at!).compareTo(DateTime.parse(date))==0||
              DateTime.parse(element.created_at!).compareTo(DateTime.parse(date))==1
      ).toList();
    }
    notifyListeners();
  }
  searchVillage(String text)async{
    if(text.isEmpty){
      getVillages();
    }
    else{
      _VillageFilterList= _VillageFilterList.where((element) =>
      element.village_name!.toLowerCase().contains(text.toLowerCase())||
          element.historical_context!.toLowerCase().contains(text.toLowerCase())||
          element.current_status.toLowerCase().contains(text.toLowerCase())||
          element.city.toLowerCase().contains(text.toLowerCase())||
          element.submitted_by_name!.toLowerCase().contains(text.toLowerCase())
      ).toList();
    }
    notifyListeners();
  }
  searchMartyrByDeathPlace(String text)async{
    if(text.isEmpty){
      getMartyrs();
    }
    else{
      print(text);
      _MartyrFilterList= _MartyrFilterList.where((element) =>
      element.place_of_death!.toLowerCase()==text.toLowerCase()
      ).toList();
    }
    notifyListeners();
  }
  searchMartyrByBirthPlace(String text)async{
    if(text.isEmpty){
      getMartyrs();
    }
    else{
      print(text);
      _MartyrFilterList= _MartyrFilterList.where((element) =>
      element.nationality.toLowerCase()==text.toLowerCase()
      ).toList();
    }
    notifyListeners();
  }
  getPrisoners([String? webURL]) async{
    _PrisonerFilterList=[];
    _PrisonerFilterList = webURL==null?
    await ApiService.apiHelper.getPrisoners() :await ApiService.apiHelper.getPrisoners(webURL);
    print(_PrisonerFilterList);
    notifyListeners();
  }
  getNews([String? webURL]) async{
    _NewsFilterList=[];
    _NewsFilterList =webURL==null?
    await ApiService.apiHelper.getNews() :await ApiService.apiHelper.getNews(webURL);
    print(_NewsFilterList);
    notifyListeners();
  }
  getVillages([String? webURL]) async{
    _VillageFilterList=[];
    _VillageFilterList =webURL==null?
    await ApiService.apiHelper.getVillages() :await ApiService.apiHelper.getVillages(webURL);
    print(_VillageFilterList);
    notifyListeners();
  }
  getVideos([String? webURL]) async{
    _VideoFilterList=[];
    _VideoFilterList =
    webURL==null?await ApiService.apiHelper.getVideos():await ApiService.apiHelper.getVideos(webURL) ;
    print(_VideoFilterList);
    notifyListeners();
  }
  getMyActivity() async{
    _ActivityFilterList=[];
    _ActivityFilterList =
    await ApiService.apiHelper.getMyActivities() ;
    print(_ActivityFilterList);
    notifyListeners();
  }
  getAnswer(String question) async{
    AIChatMap.add({"chat":0,
      "message" :question,
      "time" : "${DateTime.now().hour.toString()}:${DateTime.now().minute.toString()}"
    });
    notifyListeners();
    AIChatMap.add(
    await ApiService.apiHelper.getAnswer(question)) ;
    notifyListeners();
  }
  getMartyrforToday() async{
    _MartyrFilterList=[];
    _MartyrFilterList =
    await ApiService.apiHelper.getMartyrforToday() ;
    print(_MartyrFilterList.length);
    notifyListeners();
  }
  checkUser() async {
    try {
      SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
      if (sharedPreferences.getString('auth-token')!.isNotEmpty && DbloggedUser.name!.isNotEmpty) {

        AppRouter.appRouter.goToWidgetAndReplace(MainScreen());
      } else {
        AppRouter.appRouter.goToWidgetAndReplace(WelcomePage());
      }
    } catch (e) {
      print(e);
    }

  }
  DeleteActivity(String ActivityType ,String ActivityID)async{
  await ApiService.apiHelper.DeleteActivity(ActivityType,ActivityID);
   getMyActivity();
  }


  EditVideo(String VideoId ,String description)async{
    await ApiService.apiHelper.EditVideo(VideoId,description);
    getMyActivity();
    getVideos();

  }

  EditPrisoner(String PrisonerId ,String date_of_arrest , life_story)async{
    await ApiService.apiHelper.EditPrisoner(PrisonerId,date_of_arrest, life_story );
    getMyActivity();
    getPrisoners();

  }
  EditNews(String NewsId ,String description , String source)async{
    await ApiService.apiHelper.EditNews(NewsId,description, source );
    getMyActivity();
    getNews();

  }
  EditVillage(String villageId ,String historical_context ,String current_status)async{
    await ApiService.apiHelper.EditVillage(villageId,historical_context, current_status );
    getMyActivity();
    getVillages();

  }
forgetPassword()async{
    if(loginEmailController.text.isNotEmpty)
    await ApiService.apiHelper.forgetPassword(loginEmailController.text);
    else
      AppRouter.appRouter.showCustomDialoug("Empty Email" ,"Please Fill Email Text Field before" );
}
  signOut() async {
    try {
      SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
      await sharedPreferences.setString('auth-token', '');
      //_DbloggedUser =UserModel(username: '', name: '');
     // notifyListeners();
      AppRouter.appRouter.goToWidgetAndReplace(WelcomePage());
    } catch (e) {
      print(e);
    }

  }
}