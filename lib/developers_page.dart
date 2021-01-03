import 'package:flutter/material.dart';

class developersPage extends StatefulWidget {
  _DevelopersPageState createState() => _DevelopersPageState();
}

class _DevelopersPageState extends State<developersPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cloud Firestore"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            child: Text("Mücahid Uygun"),
            padding: const EdgeInsets.all(16.0),
            alignment: Alignment.center,
          ),
        ],
      ),
    );
  }
}
