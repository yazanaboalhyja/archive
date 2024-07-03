import 'package:flutter/material.dart';
import 'package:palestine_archive/app_router/app_router.dart';

class SetListTiles extends StatefulWidget {
  String filterChoice ="";
late Map<String,Function?> choices;
  SetListTiles(  Map<String,Function?> choices){
    this.choices= choices;
  }

  @override
  _SetListTilesState createState() => _SetListTilesState();
}

class _SetListTilesState extends State<SetListTiles> {
  List<Widget> listtile = [];

  Widget build(BuildContext context) {
    listtile = [];
  listtile =   widget.choices.keys.map((e) {
    return ListTile(
      title: Text(
        e,
      ),
      leading: new Radio(
        value: e,
        groupValue: widget.filterChoice,
        onChanged: (v) {
          if(widget.choices[e]!=null){
            widget.choices[e]!(e.toString());
          }
          AppRouter.appRouter.hideDialoug();

          setState(() {
            widget.filterChoice = v.toString();
          });

        },
      ),
    );
    
  }).toList();
    return Column(
      children: <Widget>[
   ...listtile
      ],
    );
  }
}