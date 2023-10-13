import 'package:flutter/material.dart';
import 'package:tracker_app/model/fake_day.dart';

class TypeOfWorkPanel extends StatelessWidget {
  const TypeOfWorkPanel({super.key, required this.fakeDay});

  final FakeDay fakeDay;

  String _toUpperCase(String value) {
    String letter = value[0];
    return value.replaceFirst(value[0], letter.toUpperCase());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
      decoration: BoxDecoration(
        color: fakeDay.repos
            ? Colors.grey
            : ((fakeDay.type == TypeOfWork.dev ||
                    fakeDay.type == TypeOfWork.preparation)
                ? const Color.fromRGBO(0, 194, 8, 1)
                : const Color.fromRGBO(214, 38, 38, 1)),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        fakeDay.repos ? "Repos" : _toUpperCase(fakeDay.type.name),
        style: const TextStyle(fontSize: 20),
      ),
    );
  }
}
