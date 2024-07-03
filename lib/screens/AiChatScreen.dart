import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../auth/provider.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}


class _ChatPageState extends State<ChatPage> {
  TextEditingController messageController =TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(Provider.of<AppProvider>(context,listen: false).AIChatMap.length==1)
    _typeWrittingAnimation(Provider.of<AppProvider>(context,listen: false).AIChatMap[0]["message"]);
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xffeeac07),
        body: SafeArea(
            child: Stack(
              children: [
                Column(
                  children: [
                    headerChat(),
                    bodyChat(),
                    Container(
                      color:Colors.white,
                      height: MediaQuery.of(context).size.height*0.15,)
                  ],
                ),
                inputChat()
              ],
            )
        ),
      ),
    );
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
              Text("ChatBot", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),)
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
                child: Icon(Icons.call, size: 25, color: Colors.white,),
              ),
              SizedBox(width: 20),
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.black12
                ),
                child: Icon(Icons.videocam, size: 25, color: Colors.white,),
              )
            ],
          )

        ],
      ),
    );
  }
// initializing 2 variables
 // int _currentIndex = 0;
  int _currentCharIndex = 0;

// creating a function and future delay for iteration
  void _typeWrittingAnimation(String msg) {

    if (_currentCharIndex < msg.length) {
      _currentCharIndex++;
    } else {
      _currentCharIndex = 0;



    }
    setState(() {});

   Future.delayed(const Duration(milliseconds: 50), () {
     if(msg.length>_currentCharIndex)
      _typeWrittingAnimation(msg);
    });
  }

  Widget bodyChat(){

    return Consumer<AppProvider>(builder: (context, provider, x) {

      return
      Expanded(
      child: Container(
        padding: EdgeInsets.only(left: 20, right: 20, top: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40),
            topRight: Radius.circular(40),
          ),
          color: Colors.white,
        ),
        child: ListView.builder(
          itemCount: provider.AIChatMap.length,
          itemBuilder: (context, index) {

            return itemChat(

              chat : provider.AIChatMap[index]["chat"],
              message : provider.AIChatMap[index]["chat"]==1&&index==0&& provider.AIChatMap.length==1?
              provider.AIChatMap[index]["message"].substring(0, _currentCharIndex):
              provider.AIChatMap[index]["message"],

              //provider.AIChatMap[index]["message"],
              time : provider.AIChatMap[index]["time"],
            );
          },
          physics: BouncingScrollPhysics(),


        ),
      ),
    );});
  }

  Widget itemChat({
    required int chat, required String message,  required String time}){

    return Row(
      mainAxisAlignment: chat == 1 ? MainAxisAlignment.end: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        chat == 1 ?
        CircleAvatar(
          backgroundImage: AssetImage("assets/images/ChatBotAvatar.png"),

          backgroundColor: Colors.transparent,

        ): Text('$time', style: TextStyle(color: Colors.grey.shade400)),

        Flexible(
            child: Container(
              width: MediaQuery.of(context).size.width*0.8,
              margin: EdgeInsets.only(left: 15, right: 15, top: 20),
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                  color: chat==0 ? Colors.amber.shade100: Colors.amber.shade50,
                  borderRadius: chat == 0 ? BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                      bottomLeft: Radius.circular(30)
                  ): BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                      bottomRight: Radius.circular(30)
                  )
              ),
              child: Text('$message', style: TextStyle(color: Colors.black, fontSize: 16),),
            )
        ),
        chat == 1 ? Text('$time', style: TextStyle(color: Colors.grey.shade400)): SizedBox()
      ],
    );
  }

  Widget inputChat(){
    return Positioned(
      // bottom: 0,
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            color: Colors.white,
            height: 100,
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
            child: TextField(
              controller: messageController,
              decoration: InputDecoration(
                  hintText: "اكتب رسالة...",
                  hintStyle:  TextStyle(color: Colors.black ),
                  filled: true,
                  fillColor: Colors.amber.shade100,
                  labelStyle: TextStyle(fontSize: 12),
                  contentPadding: EdgeInsets.all(20),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.amber.shade100),
                      borderRadius: BorderRadius.circular(25)
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.amber.shade100),
                      borderRadius: BorderRadius.circular(25)
                  ),
                  suffixIcon: Container(
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Color(0xffeeac07)
                    ),
                    child: IconButton(icon :Icon(Icons.send_rounded,
                      color: Colors.white,
                      size: 25), onPressed: () {

                      messageController.text.isNotEmpty?
                          Provider.of<AppProvider>(context,listen: false).getAnswer(messageController.text):

                      ScaffoldMessenger.of(context).showSnackBar( SnackBar(content: Text('Write Any Question First ...')));
                      messageController.text="";
                    },),
                  )
              ),
            ),
          ),
        )
    );
  }
}
