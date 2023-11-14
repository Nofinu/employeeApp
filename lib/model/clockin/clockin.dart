import 'package:intl/intl.dart';
import 'package:tracker_app/model/user.dart';
import 'package:tracker_app/model/clockin/clockin_hour.dart';
import 'package:uuid/uuid.dart';

final DateFormat formater = DateFormat.MMMMd();

class Clockin {
  Clockin({required this.user, required this.date});

  final String id = const Uuid().v4();
  final User user;
  final DateTime date;
  final List<ClockinHour> clockinList = <ClockinHour>[];

  void addClockinHour(ClockinType pointingType) {
    if(clockinList.length<4){
      clockinList.add(
        ClockinHour(idPointing: id, typeOfPointing: pointingType),
      );
    }
  }

  
  String getDate (){
    return formater.format(date);
  }
}
