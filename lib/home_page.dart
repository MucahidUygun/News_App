import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:news_app/SignInPage.dart';
import 'package:news_app/news.dart';
import 'package:http/http.dart' as http;
import 'package:news_app/settings_page.dart';
import 'package:url_launcher/url_launcher.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class HomePage extends StatelessWidget {
  // Eskiden Firestore'du.
  TextEditingController searchController;

  Future<News> getData() async {
    final response = await http.get(
        'https://newsapi.org/v2/top-headlines?country=tr&category=business&apiKey=9b7435faa59b4bff9d7c411bb23b1d18');
    return newsFromJson(response.body);
  }
  init(){
    searchController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cloud Firestore"),
        actions: [
          Builder(
            builder: (context) => IconButton(
              icon: Icon(Icons.settings),
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => settingsPage(),
                ),
              ),     
            ),
          )
        ],
      ),
      body: Center(
          child: FutureBuilder<News>(
        future: getData(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Veriler yükleniyor...'),
                    SizedBox(
                      height: 50,
                    ),
                    CircularProgressIndicator(),
                  ],
                ),
              );
              break;
            default:
              if (snapshot.hasError)
                return Center(
                  child: Text('Hata: ${snapshot.error}'),
                );
              else
                return ListView.builder(
                  itemCount: snapshot.data.articles.length,
                  itemBuilder: (context, index) {
                    List<Article> response = snapshot.data.articles;
                    Article item = response[index];
                    return Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
                      child: InkWell(
                        onTap: () => launch(
                            '${item.url}'),
                        child: ListTile(
                          leading: item.urlToImage != null ? Image.network(
                          item.urlToImage,
                          height: 70,
                          width: 70,) : SizedBox.shrink(),
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                item.title,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
          }
        },
      )),
    );
  }
}
