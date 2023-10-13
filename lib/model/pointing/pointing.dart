import 'package:tracker_app/model/User.dart';
import 'package:tracker_app/model/pointing/pointing_hour.dart';
import 'package:uuid/uuid.dart';

class Pointing {
  Pointing({required this.user, required this.date});

  final String id = const Uuid().v4();
  final User user;
  final DateTime date;
  final List<PointingHour> pointingList = <PointingHour>[];

  void addPointingHour(PointingType pointingType) {
    if(pointingList.length<4){
      pointingList.add(
        PointingHour(idPointing: id, typeOfPointing: pointingType),
      );
    }
  }
}
