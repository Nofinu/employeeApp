import 'package:flutter/material.dart';
import 'package:tracker_app/data/fake_data.dart';
import 'package:tracker_app/widgets/message_box_item.dart';

class AdminMessageBoxScreen extends StatefulWidget {
  const AdminMessageBoxScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _AdminMessageBoxScreenState();
  }
}

class _AdminMessageBoxScreenState extends State<AdminMessageBoxScreen> {

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Messagerie",
          style: TextStyle(
            color: Theme.of(context).colorScheme.onPrimary,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          for(int i =0; i<user.length;i++)
            MessageBoxItem(user: user[i]),
        ],
      ),
    );
  }
}
