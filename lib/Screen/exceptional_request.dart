import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:tracker_app/data/fake_data.dart';
import 'package:tracker_app/model/messageModel/Request.dart';
import 'package:tracker_app/provider/messages_provider.dart';

final formater = DateFormat.yMd();

class ExceptionalRequest extends ConsumerStatefulWidget {
  const ExceptionalRequest({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _ExceptionalRequestState();
  }
}

class _ExceptionalRequestState extends ConsumerState<ExceptionalRequest> {
  DateTime? _selectedDate;
  String? _enteredTitle;
  String? _enteredDetail;
  final _formKey = GlobalKey<FormState>();

  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final finalDate = DateTime(now.year, now.month + 2, now.day);
    final pickedDate = await showDatePicker(
        builder: (cxt, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: ColorScheme.light(
                primary: Theme.of(context).colorScheme.tertiary,
                onSurface: Theme.of(context).colorScheme.primary,
              ),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                  foregroundColor: Theme.of(context)
                      .colorScheme
                      .primary, // button text color
                ),
              ),
            ),
            child: child!,
          );
        },
        confirmText: "Ok",
        context: context,
        initialDate: now,
        firstDate: firstDate,
        lastDate: finalDate);
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  void onPressSend() {
    if (_formKey.currentState!.validate() && _selectedDate != null) {
      print("passe");
      _formKey.currentState!.save();

      Request request = Request(
          title: _enteredTitle!,
          detail: _enteredDetail!,
          writter: user[0],
          dateWritting: DateTime.now(),
          requestDate: _selectedDate!);

          ref.read(messageProvider.notifier).addMessage(request);
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
          "Demande Exceptionelle",
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
                      print(value);
                      if (value == null || value!.length > 60) {
                        return "Saisissez un intitulé valide et inferieur a 60 caractères";
                      }
                      return null;
                    },
                    onSaved: (newValue) {
                      _enteredTitle = newValue!;
                    },
                  ),
                  const SizedBox(
                    height: 35,
                  ),
                  Row(
                    children: [
                      Text(
                        _selectedDate == null
                            ? "Pas de date selectionée"
                            : formater.format(_selectedDate!),
                      ),
                      IconButton(
                        onPressed: _presentDatePicker,
                        icon: const Icon(Icons.calendar_month),
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
                      _enteredDetail = newValue!;
                    },
                  ),
                  const SizedBox(
                    height: 35,
                  ),
                  ElevatedButton(
                    onPressed: onPressSend,
                    style: ElevatedButton.styleFrom(
                        elevation: 3, minimumSize: Size(screenWidth * 0.8, 60)),
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
