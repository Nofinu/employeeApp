import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tracker_app/model/user.dart';
import 'package:tracker_app/model/messageModel/request.dart';

final DateFormat formater = DateFormat.yMMMMd().add_Hm();

abstract class Message {
  Message(
      {required this.title,
      required this.detail,
      required this.dateWriting,
      required this.writer,
      this.isCheked = false,
      this.isvalidated = false});

  final String title;
  final String detail;
  final DateTime dateWriting;
  final User writer;
  bool isView = false;
  bool isCheked;
  bool isvalidated;

  void onClickValidationButton(bool validation, Request request) {}

  void setIsView() {
    isView = true;
  }

  Widget showWidget(
    void Function(bool validation, Request request) onClickValidationButton,
  ) {
    return const Text("message Not found");
  }

  String getDate() {
    return formater.format(dateWriting);
  }

  void setIsValidated(bool validation) {
    isvalidated = validation;
  }

  void setIsChecked() {
    isCheked = true;
  }
}
