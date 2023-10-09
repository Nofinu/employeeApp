import 'package:flutter/material.dart';
import 'package:tracker_app/model/messageModel/request.dart';

class RequestDetailScreen extends StatelessWidget {
  const RequestDetailScreen(
      {super.key,
      required this.request,
      required this.onClickValidationButton});

  final Request request;

  final void Function(bool validation, Request request) onClickValidationButton;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final List<Widget> buttonCheck = [];

    if (!request.isCheked) {
      buttonCheck.add(
        ElevatedButton(
          onPressed: () {
            onClickValidationButton(false, request);
            Navigator.of(context).pop();
          },
          style: ElevatedButton.styleFrom(
              elevation: 5,
              backgroundColor: const Color.fromRGBO(205, 0, 0, 1),
              minimumSize: Size(screenWidth * 0.4, 80)),
          child: Icon(
            Icons.cancel_outlined,
            color: Theme.of(context).colorScheme.onPrimary,
            size: screenWidth * 0.3,
          ),
        ),
      );
      buttonCheck.add(
        SizedBox(
          width: screenWidth * 0.1,
        ),
      );
      buttonCheck.add(
        ElevatedButton(
          onPressed: () {
            onClickValidationButton(true, request);
            Navigator.of(context).pop();
          },
          style: ElevatedButton.styleFrom(
              elevation: 5,
              backgroundColor: const Color.fromRGBO(0, 194, 8, 1),
              minimumSize: Size(screenWidth * 0.4, 80)),
          child: Icon(
            Icons.check,
            color: Theme.of(context).colorScheme.onPrimary,
            size: screenWidth * 0.3,
          ),
        ),
      );
    } else {
      buttonCheck.add(
        Container(
          width: screenWidth * 0.8,
          height: 80,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: request.isvalidated
                ? const Color.fromRGBO(0, 194, 8, 1)
                : const Color.fromRGBO(205, 0, 0, 1),
          ),
          child: Icon(
            request.isvalidated ? Icons.check : Icons.cancel_outlined,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "${request.writter.firstname} ${request.writter.lastname}",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Text(
            request.title,
            style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          Text(
            request.getRequestDate(),
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Text(
            request.detail,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: buttonCheck,
          )
        ],
      ),
    );
  }
}
