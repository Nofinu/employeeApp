import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracker_app/data/fake_data.dart';
import 'package:tracker_app/model/messageModel/issue.dart';

class IssueNotifier extends StateNotifier<List<Issue>> {
  IssueNotifier() : super(getProblemes());

  void setValidationOnRequest(Issue message, bool validation) {
    List<Issue> problemesList = [...state];
    if (problemesList.contains(message)) {
      int id = problemesList.indexOf(message);
      message.setIsChecked();
      message.setIsValidated(validation);
      problemesList.replaceRange(id, id + 1, [message]);
    }
    state = problemesList;
  }

  void addMessage(Issue probleme) {
    List<Issue> problemesList = [...state];
    problemesList.add(probleme);
    problemesList
        .sort((a, b) => -1 * (a.dateWriting.compareTo(b.dateWriting)));
    state = problemesList;
  }

  void setViewMessage(Issue probleme) {
    List<Issue> problemesList = [...state];
    if (problemesList.contains(probleme)) {
      int index = problemesList.indexOf(probleme);
      problemesList[index].setIsView();
    }
    state = problemesList;
  }
}

final issueProvider =
    StateNotifierProvider<IssueNotifier, List<Issue>>(
        (ref) => IssueNotifier());
