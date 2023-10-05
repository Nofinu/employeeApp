import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracker_app/data/fake_data.dart';
import 'package:tracker_app/model/messageModel/problem.dart';
import 'package:tracker_app/provider/messages_provider.dart';

enum Priority { low, medium, high }

class ReportProblemeScreen extends ConsumerStatefulWidget {
  const ReportProblemeScreen({super.key});

  @override
  ConsumerState<ReportProblemeScreen> createState() {
    return _SignalerProblemeScreenState();
  }
}

class _SignalerProblemeScreenState extends ConsumerState<ReportProblemeScreen> {
  Priority? _priority = Priority.low;
  String? _enteredTitle;
  String? _enteredDetails;
  final _formKey = GlobalKey<FormState>();

  void onClickSend() {
    if (_formKey.currentState!.validate() && _priority != null) {
      _formKey.currentState!.save();

      Probleme probleme = Probleme(
          title: _enteredTitle!,
          detail: _enteredDetails == null ? "" : _enteredDetails!,
          dateWritting: DateTime.now(),
          writter: user[0],
          priority: _priority!);

        ref.read(messageProvider.notifier).addMessage(probleme);
        Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Signaler un probleme",
          style: TextStyle(
            color: Theme.of(context).colorScheme.onBackground,
            fontSize: 28,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:
              EdgeInsets.symmetric(vertical: 35, horizontal: screenWidth * 0.1),
          child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    style: const TextStyle(fontSize: 21),
                    decoration: InputDecoration(
                      labelText: "intitulé :",
                      filled: true,
                      fillColor: Theme.of(context).colorScheme.onBackground,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
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
                  const SizedBox(
                    height: 35,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Priorité :",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 22),
                        textAlign: TextAlign.start,
                      ),
                      ListTile(
                        title: const Text('Basse'),
                        leading: Radio<Priority>(
                          value: Priority.low,
                          groupValue: _priority,
                          onChanged: (Priority? value) {
                            setState(() {
                              _priority = value;
                            });
                          },
                        ),
                      ),
                      ListTile(
                        title: const Text('Moyenne'),
                        leading: Radio<Priority>(
                          value: Priority.medium,
                          groupValue: _priority,
                          onChanged: (Priority? value) {
                            setState(() {
                              _priority = value;
                            });
                          },
                        ),
                      ),
                      ListTile(
                        title: const Text('Haute'),
                        leading: Radio<Priority>(
                          value: Priority.high,
                          groupValue: _priority,
                          onChanged: (Priority? value) {
                            setState(() {
                              _priority = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 35,
                  ),
                  TextFormField(
                    style: const TextStyle(fontSize: 21),
                    decoration: InputDecoration(
                      labelText: "Detail :",
                      filled: true,
                      fillColor: Theme.of(context).colorScheme.onBackground,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    onSaved: (newValue) {
                      _enteredDetails = newValue;
                    },
                  ),
                  const SizedBox(
                    height: 35,
                  ),
                  ElevatedButton(
                    onPressed: onClickSend,
                    style: ElevatedButton.styleFrom(
                      elevation: 3,
                      minimumSize: Size(screenWidth * 0.8, 60),
                    ),
                    child: Text(
                      "Envoyer",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onBackground,
                        fontSize: 32,
                      ),
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
