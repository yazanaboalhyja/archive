import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../auth/provider.dart';

class MyTextField extends StatelessWidget {
  final controller;
  final String hintText;
  final bool obscureText;
  TextInputType? keyType;
   MyTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
     keyType=TextInputType.text
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator:(val) => val!.isEmpty ? 'Please fill out this field' : null,
      controller: controller,
      keyboardType: keyType,
      obscureText: obscureText,
      decoration: InputDecoration(
          enabledBorder:  OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade400),
          ),
          //fillColor:  !Provider.of<AppProvider>(context).darkTheme? Colors.grey.shade200:Colors.,
          filled: true,
          hintText: hintText.tr(),
          hintStyle: TextStyle(color:Colors.grey[500])),
    );
  }
}

class MyPasswordTextField extends StatefulWidget {
  final controller;
  final String hintText;
    bool obscureText;
   MyPasswordTextField({
    super.key,
    required this.controller,
    required this.hintText,
     this.obscureText =true,
  });

  @override
  State<MyPasswordTextField> createState() => _MyPasswordTextFieldState();
}

class _MyPasswordTextFieldState extends State<MyPasswordTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (val) => val!.isEmpty ? 'Please fill out this field' : null,
      controller: widget.controller,
      obscureText: widget.obscureText,
      decoration: InputDecoration(
          suffixIcon:  IconButton(
              icon: widget.obscureText?Icon(Icons.visibility_off):
              Icon(Icons.visibility_rounded),
            onPressed: () {
                setState(() {
                  widget.obscureText=!widget.obscureText;
                });
            }
              ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade400),
          ),
          fillColor: Colors.grey.shade200,
          filled: true,
          hintText: widget.hintText.tr(),
          hintStyle: TextStyle(color: Colors.grey[500])),
    );
  }
}