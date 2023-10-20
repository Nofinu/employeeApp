

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracker_app/data/fake_data.dart';
import 'package:tracker_app/model/messageModel/request.dart';

class RequestNotifier extends ChangeNotifier {
  List<Request> requestList = getRequest();

  void setValidationOnRequest(Request message, bool validation) {
    if (requestList.contains(message)) {
      int id = requestList.indexOf(message);
      message.setIsChecked();
      message.setIsValidated(validation);
      requestList.replaceRange(id, id + 1, [message]);
      notifyListeners();
    }
  }

  void addMessage(Request request) {
    requestList.add(request);
    requestList.sort((a, b) => -1 * (a.dateWritting.compareTo(b.dateWritting)));
    notifyListeners();
  }

  int getNotification() {
    int cpt = 0;
    for (int i = 0; i < requestList.length; i++) {
      if (!requestList[i].isView) {
        cpt++;
      }
    }
    return cpt;
  }

  void setViewMessage(Request request) {
    if (requestList.contains(request)) {
      int index = requestList.indexOf(request);
      requestList[index].setIsView();
      notifyListeners();
    }
  }

}

final requestProvider = ChangeNotifierProvider<RequestNotifier>((ref) => RequestNotifier());