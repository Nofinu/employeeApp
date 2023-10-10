import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tracker_app/model/User.dart';
import 'package:tracker_app/model/messageModel/request.dart';

final formater = DateFormat.yMMMMd().add_Hm();

 abstract class Message {
  Message ({required this.title, required this.detail, required this.dateWritting, required this.writter});
  final String title;
  final String detail;
  final DateTime dateWritting;
  final User writter;
  bool isView = false;
  
  void onClickValidationButton (bool validation,Request request){

  }

  void setIsView (){
    isView = true;
  }

  Widget showWidget (void Function(bool validation,Request request) onClickValidationButton,){
    return const Text("message Not found");
  }

  String getDate (){
    return formater.format(dateWritting);
  }
}