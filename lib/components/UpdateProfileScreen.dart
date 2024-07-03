import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class UpdateProfileScreen extends StatelessWidget {
  const UpdateProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () {
          Navigator.pop(context);
        }, icon: const Icon(LineAwesomeIcons.angle_left)),
        title: Text("Edit Profile", style: Theme.of(context).textTheme.headline4),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              // -- IMAGE with ICON
              Stack(
                children: [
                  SizedBox(
                    width: 120,
                    height: 120,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child:  Image(image: NetworkImage("https://st4.depositphotos.com/14903220/22197/v/1600/depositphotos_221970610-stock-illustration-abstract-sign-avatar-icon-profile.jpg"))),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 35,
                      height: 35,
                      decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(100), color: Colors.grey),
                      child: const Icon(LineAwesomeIcons.camera, color: Colors.black, size: 20),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 50),

              // -- Form Fields
              Form(
                child: Column(
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(
                          label: Text("Ibrahim AbdAlhadi"), prefixIcon: Icon(LineAwesomeIcons.user)),
                    ),
                    const SizedBox(height: 100 - 20),
                    TextFormField(
                      decoration: const InputDecoration(
                          label: Text("ibrahim@gmail.com"), prefixIcon: Icon(LineAwesomeIcons.envelope_1)),
                    ),
                    const SizedBox(height: 100 - 20),
                    TextFormField(
                      decoration: const InputDecoration(
                          label: Text("0564441221"), prefixIcon: Icon(LineAwesomeIcons.phone)),
                    ),
                    const SizedBox(height: 100 - 20),
                    TextFormField(
                      obscureText: true,
                      decoration: InputDecoration(
                        label: const Text("Password"),
                        prefixIcon: const Icon(Icons.fingerprint),
                        suffixIcon:
                        IconButton(icon: const Icon(LineAwesomeIcons.eye_slash), onPressed: () {}),
                      ),
                    ),
                    const SizedBox(height: 100),

                    // -- Form Submit Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xffeeac07),
                            side: BorderSide.none,
                            shape: const StadiumBorder()),
                        child: const Text("Edit Profile", style: TextStyle(color: Colors.white)),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // -- Created Date and Delete Button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text.rich(
                          TextSpan(
                            text: "Join",
                            style: TextStyle(fontSize: 12),
                            children: [
                              TextSpan(
                                  text: "Join",
                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12))
                            ],
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.redAccent.withOpacity(0.1),
                              elevation: 0,
                              foregroundColor: Colors.red,
                              shape: const StadiumBorder(),
                              side: BorderSide.none),
                          child: const Text("Delete Account"),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}