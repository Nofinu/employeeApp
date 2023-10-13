import 'package:flutter/material.dart';
import 'package:tracker_app/Screen/messageBox/report_problem.dart';
import 'package:tracker_app/model/messageModel/problem.dart';

class ProblemeDetailScreen extends StatelessWidget {
  const ProblemeDetailScreen({super.key, required this.probleme});

  final Probleme probleme;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Probleme Detail",
          style: TextStyle(
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
      ),
      body: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                probleme.title,
                style:
                    const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              Icon(
                Icons.priority_high_rounded,
                color: probleme.priority == Priority.low
                    ? Colors.green
                    : probleme.priority == Priority.medium
                        ? Colors.yellow
                        : Colors.red,
                        size: 28,
              ),
            ],
          ),
          const SizedBox(height: 35,),
          Text(probleme.getDate(),style: const TextStyle(fontSize: 26),),
          const SizedBox(height: 25,),
          Text(probleme.detail,style: const TextStyle(fontSize: 22),),
        ],
      ),
    );
  }
}
