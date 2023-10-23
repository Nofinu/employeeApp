import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracker_app/data/fake_data.dart';
import 'package:tracker_app/model/messageModel/request.dart';

class RequestNotifier extends StateNotifier<List<Request>> {
  RequestNotifier() : super(getRequest());

  void setValidationOnRequest(Request message, bool validation) {
    List<Request> requestList = [...state];
    if (requestList.contains(message)) {
      int id = requestList.indexOf(message);
      message.setIsChecked();
      message.setIsValidated(validation);
      requestList.replaceRange(id, id + 1, [message]);
    }
    state = requestList;
  }

  void addMessage(Request request) {
    List<Request> requestList = [...state];
    requestList.add(request);
    requestList.sort((a, b) => -1 * (a.dateWritting.compareTo(b.dateWritting)));
    state = requestList;
  }

  int getNotification() {
    List<Request> requestList = [...state];
    int cpt = 0;
    for (int i = 0; i < requestList.length; i++) {
      if (!requestList[i].isView) {
        cpt++;
      }
    }
    return cpt;
  }

  void setViewMessage(Request request) {
    List<Request> requestList = [...state];
    if (requestList.contains(request)) {
      int index = requestList.indexOf(request);
      requestList[index].setIsView();
    }
    state = requestList;
  }
}

final requestProvider = StateNotifierProvider<RequestNotifier, List<Request>>(
    (ref) => RequestNotifier());
