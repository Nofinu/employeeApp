import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tracker_app/model/user.dart';
import 'package:tracker_app/model/messageModel/problem.dart';
import 'package:tracker_app/provider/auth_provider.dart';
import 'package:tracker_app/provider/messages_provider.dart';
import 'package:tracker_app/widgets/appbar_perso.dart';

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
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void onClickSend() {
    if (_formKey.currentState!.validate() && _priority != null) {
      _formKey.currentState!.save();

      Probleme probleme = Probleme(
          title: _enteredTitle!,
          detail: _enteredDetails == null ? "" : _enteredDetails!,
          dateWritting: DateTime.now(),
          writter: ref.watch<User>(authProvider),
          priority: _priority!);

      ref.read(messageProvider.notifier).addMessage(probleme);
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
                        labelStyle: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
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
                  height: 35,
                ),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Priorité",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    textAlign: TextAlign.start,
                  ),
                ),
                const SizedBox(height: 8,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    customRadioButton(
                        "Basse", Priority.low, Colors.green, screenWidth),
                    customRadioButton(
                        "Moyenne", Priority.medium, Colors.orange, screenWidth),
                    customRadioButton(
                        "Haute", Priority.high, Colors.red, screenWidth),
                  ],
                ),
                const SizedBox(
                  height: 35,
                ),
                Container(
                  height: 220,
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
                      labelStyle: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
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
                  height: 35,
                ),
                ElevatedButton(
                  onPressed: onClickSend,
                  style: ElevatedButton.styleFrom(
                    elevation: 3,
                    minimumSize: Size(screenWidth * 0.9, 60),
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
