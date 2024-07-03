import 'package:flutter/material.dart';

import '../components/SetListTile.dart';

class AppRouter {
  AppRouter._();
  static AppRouter appRouter = AppRouter._();
  GlobalKey<NavigatorState> navigatorKey = GlobalKey();
  showCustomDialoug(String title, String content,[Function? okPressed]) {
    showDialog(
        context: navigatorKey.currentContext!,
        builder: (context) {
          return AlertDialog(
            title: Text(title),
            content: Text(content),
            actions: [
              TextButton(
                  onPressed: ()async {
                   if(okPressed!=null) {
                    await okPressed();

                  //  navigatorKey.currentState!.pop();
                    }else{
                     navigatorKey.currentState!.pop();
                   }
                  },
                  child: Text('Ok'))
            ],
          );
        });
  }

  showLoadingDialoug() {
    showDialog(
      barrierDismissible: false,
      context: navigatorKey.currentContext!,
      builder: (BuildContext context) {
        return AlertDialog(
          content: new Row(
            children: [
              CircularProgressIndicator(),
              Container(
                  margin: EdgeInsets.only(left: 7), child: Text("Loading...")),
            ],
          ),
        );
      },
    );
  }

  hideDialoug() {
    navigatorKey.currentState!.pop();
  }

  goToWidgetAndReplace(Widget widget) {
    navigatorKey.currentState!
        .pushReplacement(MaterialPageRoute(builder: (context) {
      return widget;
    }));
  }

  goToWidget(Widget widget) {
    navigatorKey.currentState!.push(MaterialPageRoute(builder: (context) {
      return widget;
    }));
  }

  showAlertDialog(BuildContext context , Map<String,Function?> choices) {
    final SetListTiles _setListTiles = new SetListTiles(choices);

    return showDialog(
      builder: (context) => AlertDialog(
        title: Text('Choose Filter Type'),
        content: new SingleChildScrollView(
          child: Column(
            children: [
              _setListTiles,
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Cancel'),
          ),

        ],
      ),
      context: context,
    );
  }
}

