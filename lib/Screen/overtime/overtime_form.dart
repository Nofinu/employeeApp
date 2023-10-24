import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:tracker_app/model/messageModel/overtime.dart';
import 'package:tracker_app/model/user.dart';
import 'package:tracker_app/provider/auth_provider.dart';
import 'package:tracker_app/provider/overtime_provider.dart';
import 'package:tracker_app/widgets/appbar_perso.dart';

final formater = DateFormat.yMd();

class OvertimeFormScreen extends ConsumerStatefulWidget {
  const OvertimeFormScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _OvertimeFormScreenState();
  }
}

class _OvertimeFormScreenState extends ConsumerState<OvertimeFormScreen> {
  DateTime? _selectedDate;
  String? _enteredTitle;
  String? _enteredDetail;
  int? _enteredHours;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _presentDatePicker() async {
    final DateTime now = DateTime.now();
    final DateTime firstDate = DateTime(now.year - 1, now.month, now.day);
    final DateTime finalDate = DateTime(now.year, now.month + 2, now.day);
    final DateTime? pickedDate = await showDatePicker(
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
      _formKey.currentState!.save();

      Overtime overtime = Overtime(
          title: _enteredTitle!,
          detail: _enteredDetail!,
          writter: ref.watch<User>(authProvider),
          dateWritting: DateTime.now(),
          nbrHours: _enteredHours!,
          dateOvertime: _selectedDate!);

      ref.read(overtimeProvider.notifier).addMessage(overtime);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBarPerso(ref.watch(authProvider),
          "Demander des heures supplémentaire", context),
      body: SingleChildScrollView(
        child: Padding(
          padding:
              EdgeInsets.symmetric(vertical: 35, horizontal: screenWidth * 0.1),
          child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
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
                        _enteredTitle = newValue!;
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 35,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                      child: Row(
                        children: <Widget>[
                          IconButton(
                            onPressed: _presentDatePicker,
                            icon: const Icon(
                              Icons.calendar_month,
                              size: 50,
                            ),
                          ),
                          Text(
                            _selectedDate == null
                                ? "Pas de date selectionée"
                                : formater.format(_selectedDate!),
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 35,
                  ),
                  Container(
                    height: 140,
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
                        _enteredDetail = newValue;
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 35,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: TextFormField(
                      initialValue: "0",
                      style: const TextStyle(fontSize: 21),
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      decoration: InputDecoration(
                          labelText: "Nombre d'heures :",
                          labelStyle: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                          filled: true,
                          fillColor: Theme.of(context).colorScheme.onPrimary,
                          border: InputBorder.none),
                      validator: (value) {
                        if (value == null || int.parse(value) <= 0) {
                          return "Saisissez un nombre d'heures correcte";
                        }
                        return null;
                      },
                      onSaved: (newValue) {
                        _enteredHours = int.parse(newValue!);
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 35,
                  ),
                  ElevatedButton(
                    onPressed: onPressSend,
                    style: ElevatedButton.styleFrom(
                      elevation: 3,
                      fixedSize: Size(screenWidth * 0.8, 60),
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
              )),
        ),
      ),
    );
  }
}
