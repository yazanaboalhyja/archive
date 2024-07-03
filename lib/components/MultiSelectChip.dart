import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../auth/provider.dart';

class MultiSelectChip extends StatefulWidget {
  final List<String> reportList;
  final AppProvider provider;
  MultiSelectChip(this.reportList  ,this.provider);
  @override
  _MultiSelectChipState createState() => _MultiSelectChipState();
}
class _MultiSelectChipState extends State<MultiSelectChip> {
  String selectedChoice = "";
  // this function will build and return the choice list
  _buildChoiceList() {
    List<Widget> choices = [] ;
    widget.reportList.forEach((item) {
      choices.add(Container(
        padding: const EdgeInsets.all(2.5),
        child: ChoiceChip(
          label: Text(item),
          selected: selectedChoice.split(",").contains(item),
          onSelected: (selected) {

            selectedChoice.split(",").contains(item)?
            selectedChoice =
            selectedChoice.split(",")[0]!=item?
                selectedChoice.replaceAll(","+item, ""):
                selectedChoice.replaceAll(item, "")
                :

            selectedChoice = selectedChoice+ ","+item;
            if(selectedChoice.isNotEmpty&&selectedChoice[0]==','){
              selectedChoice =selectedChoice.replaceFirst(",", "");
            }
            widget.provider.NewsType.text=selectedChoice;
            setState(() {
print(selectedChoice);
            });
          },
        ),
      ));
    });
    return choices;
  }
  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: _buildChoiceList(),
    );
  }}