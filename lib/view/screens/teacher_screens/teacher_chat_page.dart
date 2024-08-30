

import 'package:flutter/material.dart';
import 'package:iquran/res/constants.dart';


class TeacherChatScreen extends StatefulWidget {

  @override
  State<TeacherChatScreen> createState() => _TeacherChatScreenState();
}

class _TeacherChatScreenState extends State<TeacherChatScreen> {
  TextEditingController messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Container(
          color: AppColor.kbtnColor,
          padding: EdgeInsets.only(top: 60.0),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height/1.12,
                  margin: EdgeInsets.only(top: 50),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(topRight: Radius.circular(30), topLeft: Radius.circular(30),),
                  ),

              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.arrow_back_sharp,
                        color: Color(0xffeff1fc),
                      ),
                    ),
                    SizedBox(
                      width: 90.0,
                    ),
                    Text(
                      '',
                      style: TextStyle(
                          color: Color(0xffeff1fc),
                          fontSize: 20.0,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
              Container(
                alignment: Alignment.bottomCenter,
                margin: EdgeInsets.only(left: 20, right: 20, bottom: 20),
                child: Material(
                  elevation: 5.0,
                  borderRadius: BorderRadius.circular(30),
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30)),
                    child:  TextFormField(

                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Type a message",
                          hintStyle: TextStyle(color: Colors.black45),
                          suffixIcon: GestureDetector(
                              onTap: (){

                              },
                              child: Icon(Icons.send_rounded))
                      ),
                    ),
                  ),


                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}