import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:news_app/auht_type_selector.dart';
import 'package:news_app/developers_page.dart';
import 'package:news_app/SignInPage.dart';
import 'package:news_app/news.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

import 'package:shared_preferences/shared_preferences.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class settingsPage extends StatefulWidget {
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<settingsPage> {
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
            child: RaisedButton(
              color: Colors.green,
              highlightColor: Colors.red,
              elevation: 10,
              child: Text(
                "Geliştiriciler",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => developersPage(),
                ),
              ),
            ),
            padding: const EdgeInsets.all(16.0),
            alignment: Alignment.center,
          ),
          Builder(
            builder: (context) => RaisedButton(
              color: Colors.green,
              padding: const EdgeInsets.all(16.0),
              child: Text("ÇIKIŞ"),
              textColor: Colors.white,
              onPressed: () async {
                  Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AuthTypeSelector()));
                final User user = _auth.currentUser; // Eskiden asenkrondu
                if (user == null) {
                  Scaffold.of(context).showSnackBar(const SnackBar(
                    content: Text("Henüz giriş yapılmamış"),
                  ));
                  return;
                }

                await _auth.signOut(); // Çıkış yapma kodu

                final String uid = user.uid;
                Scaffold.of(context).showSnackBar(SnackBar(
                  content: Text("$uid başarıyla çıkış yaptı"),
                ));

                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SignInPage(),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
