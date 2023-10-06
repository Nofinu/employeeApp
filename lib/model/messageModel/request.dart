import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tracker_app/widgets/request_message_item.dart';
import 'package:tracker_app/model/messageModel/message.dart';

final formater = DateFormat.yMMMMd();

class Request extends Message {
  Request(
      {required super.title,
      required super.detail,
      required super.writter,
      required super.dateWritting,
      required this.requestDate,
      this.isCheked = false,
      this.isvalidated = false});

      final DateTime requestDate;
      bool isCheked;
      bool isvalidated;

    String getRequestDate (){
      return formater.format(requestDate);
    }

    void setIsValidated (bool validation){
      isvalidated = validation;
    }

    void setIsChecked(){
      isCheked = true;
    }

    @override
    Widget showWidget (void Function(bool validation,Request request) onClickValidationButton ){
      return RequestMessageItem(request: this,onClickValidationButton: onClickValidationButton,);
    }
}
