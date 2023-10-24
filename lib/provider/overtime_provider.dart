import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracker_app/model/messageModel/overtime.dart';

class OvertimeNotifier extends StateNotifier<List<Overtime>> {
  OvertimeNotifier() : super([]);

  void setValidationOnRequest(Overtime message, bool validation) {
    List<Overtime> problemesList = [...state];
    if (problemesList.contains(message)) {
      int id = problemesList.indexOf(message);
      message.setIsChecked();
      message.setIsValidated(validation);
      problemesList.replaceRange(id, id + 1, [message]);
    }
    state = problemesList;
  }

  void addMessage(Overtime probleme) {
    List<Overtime> problemesList = [...state];
    problemesList.add(probleme);
    problemesList
        .sort((a, b) => -1 * (a.dateWritting.compareTo(b.dateWritting)));
    state = problemesList;
  }

  void setViewMessage(Overtime probleme) {
    List<Overtime> problemesList = [...state];
    if (problemesList.contains(probleme)) {
      int index = problemesList.indexOf(probleme);
      problemesList[index].setIsView();
    }
    state = problemesList;
  }
}

final overtimeProvider =
    StateNotifierProvider<OvertimeNotifier, List<Overtime>>(
        (ref) => OvertimeNotifier());
