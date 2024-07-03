import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../auth/provider.dart';

class MyButton extends StatelessWidget {
  final Function()? onTap;

  const MyButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(builder: (context, provider, x) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(25),
        decoration: BoxDecoration(
          color: //Color.fromARGB(255, 71, 233, 133)
          Color(0xffeeac07)
           ,
          borderRadius: BorderRadius.circular(8),
        ),
        child:  Center(
          child:
       !provider.isLoading?
          Text(
            "continue".tr(),
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25),
          ):
           CircularProgressIndicator()
          ,
        ),
      ),
    );});
}}

class MyButtonAgree extends StatelessWidget {
  final Function()? onTap;
  final String text;
  const MyButtonAgree({super.key, required this.onTap, required this.text});

  @override
  Widget build(BuildContext context) {

    return Consumer<AppProvider>(builder: (context, provider, x) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(25),
        decoration: BoxDecoration(
          color: const Color(0xffeeac07),
          borderRadius: BorderRadius.circular(8),
        ),
        child:  Center(
          child:
          !provider.isLoading?Text(
            text,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25),
          ):CircularProgressIndicator(),
        ),
      ),
    );});
  }
}