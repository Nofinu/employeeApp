import 'package:intl/intl.dart';
import 'package:tracker_app/model/messageModel/message.dart';


final DateFormat formater = DateFormat.yMMMMd();

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

}
