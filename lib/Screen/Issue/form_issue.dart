import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracker_app/model/user.dart';
import 'package:tracker_app/model/messageModel/issue.dart';
import 'package:tracker_app/provider/auth_provider.dart';
import 'package:tracker_app/provider/issue_provider.dart';
import 'package:tracker_app/widgets/appbar_perso.dart';

class ReportIssueScreen extends ConsumerStatefulWidget {
  const ReportIssueScreen({super.key});

  @override
  ConsumerState<ReportIssueScreen> createState() {
    return _ReportIssueScreenState();
  }
}

class _ReportIssueScreenState extends ConsumerState<ReportIssueScreen> {
  Priority? _priority = Priority.low;
  String? _enteredTitle;
  String? _enteredDetails;
  Privacy _privacy = Privacy.public;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void onClickSend() {
    if (_formKey.currentState!.validate() && _priority != null) {
      _formKey.currentState!.save();

      Issue probleme = Issue(
          title: _enteredTitle!,
          detail: _enteredDetails == null ? "" : _enteredDetails!,
          dateWriting: DateTime.now(),
          writer: ref.watch<User>(authProvider),
          priority: _priority!,
          privacy: _privacy);

      ref.read(issueProvider.notifier).addMessage(probleme);
      Navigator.of(context).pop();
    }
  }

  Widget customRadioButton(
      String text, Priority priority, Color color, double screenWidth) {
    return OutlinedButton(
      onPressed: () {
        setState(() {
          _priority = priority;
        });
      },
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: color, width: 1.5),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        backgroundColor: (_priority == priority)
            ? color
            : Theme.of(context).colorScheme.onPrimary,
        fixedSize: Size(screenWidth * 0.25, 70),
        padding: const EdgeInsets.all(5),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: (_priority == priority)
              ? Theme.of(context).colorScheme.onPrimary
              : color,
          fontSize: 16,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBarPerso(
        ref.watch(authProvider),
        "Signaler un problème",
        context,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:
              EdgeInsets.symmetric(vertical: 35, horizontal: screenWidth * 0.1),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: TextFormField(
                    style: const TextStyle(fontSize: 21),
                    decoration: InputDecoration(
                        labelText: "intitulé :",
                        labelStyle: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                        filled: true,
                        fillColor: Theme.of(context).colorScheme.onPrimary,
                        border: InputBorder.none),
                    validator: (value) {
                      if (value == null || value.length > 60) {
                        return "Saisissez un intitulé valide et inferieur a 60 caractères";
                      }
                      return null;
                    },
                    onSaved: (newValue) {
                      _enteredTitle = newValue;
                    },
                  ),
                ),
                const SizedBox(
                  height: 18,
                ),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Priorité",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    textAlign: TextAlign.start,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    customRadioButton(
                        "Basse", Priority.low, const Color.fromRGBO(0, 194, 8, 1), screenWidth),
                    customRadioButton(
                        "Moyenne", Priority.medium, const Color.fromRGBO(237, 121, 14, 1), screenWidth),
                    customRadioButton(
                        "Haute", Priority.high, const Color.fromRGBO(214, 38, 38, 1), screenWidth),
                  ],
                ),
                const SizedBox(
                  height: 18,
                ),
                Container(
                  height: 180,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(10)),
                  clipBehavior: Clip.antiAlias,
                  child: TextFormField(
                    textAlignVertical: TextAlignVertical.top,
                    textAlign: TextAlign.start,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    expands: true,
                    style: const TextStyle(fontSize: 21),
                    decoration: InputDecoration(
                      alignLabelWithHint: true,
                      labelText: "Détails",
                      labelStyle: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                      filled: true,
                      fillColor: Theme.of(context).colorScheme.onPrimary,
                      border: InputBorder.none,
                    ),
                    onSaved: (newValue) {
                      _enteredDetails = newValue;
                    },
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_privacy == Privacy.public) {
                      setState(() {
                        _privacy = Privacy.private;
                      });
                    } else {
                      setState(() {
                        _privacy = Privacy.public;
                      });
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 3,
                    minimumSize: Size(screenWidth * 0.9, 60),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    backgroundColor: Theme.of(context).colorScheme.primary,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        _privacy == Privacy.public
                            ? Icons.lock_open
                            : Icons.lock_outline,
                        size: 40,
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                      Text(
                        _privacy == Privacy.public ? "Publique" : "Privé",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onPrimary,
                          fontSize: 32,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                ElevatedButton(
                  onPressed: onClickSend,
                  style: ElevatedButton.styleFrom(
                    elevation: 3,
                    minimumSize: Size(screenWidth * 0.9, 80),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    backgroundColor: Theme.of(context).colorScheme.primary,
                  ),
                  child: Text(
                    "Envoyer",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onPrimary,
                      fontSize: 32,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
