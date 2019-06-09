import 'package:flutter/material.dart';
import 'package:flutter_app_2/email.dart';

class DetailPage extends StatelessWidget {

  final Email email;

  DetailPage({this.email});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red[300],
          title: Text("Detail"),
          actions: <Widget>[
            IconButton(icon: Icon(Icons.share), onPressed: () {}),
            IconButton(icon: Icon(Icons.delete), onPressed: () {}),
            IconButton(icon: Icon(Icons.file_download), onPressed: () {}),

          ],),
        body: Container(color: Colors.grey[400],
          child: ListView(children: <Widget>[
            Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8)),
                margin: EdgeInsets.all(16),
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(email.title, style: TextStyle(fontSize: 24),),
                    Text(email.description),
                    Image.network("https://images.unsplash.com/photo-1556912172-45b7abe8b7e1?auto=format&fit=crop&w=1000&q=80")
                  ],
                ))
          ]),
        ));
  }
}


