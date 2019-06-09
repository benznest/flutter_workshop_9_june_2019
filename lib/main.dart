import 'package:flutter/material.dart';
import 'package:flutter_app_2/detail_page.dart';
import 'package:flutter_app_2/email.dart';
import 'package:flutter_app_2/provider/email_provider.dart';
import 'package:provider/provider.dart';

void main() {
  Provider.debugCheckInvalidValueType = null;
  runApp(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MultiProvider(
            providers: [
              Provider(builder: (BuildContext context) => EmailProvider())
            ], child: MyHomePage()),
      ));
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  EmailProvider emailProvider;
  TextEditingController textEditingController = TextEditingController();

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    emailProvider = Provider.of<EmailProvider>(context);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('MyApp'),
        backgroundColor: Colors.red[300],
        actions: <Widget>[
          IconButton(icon: Icon(Icons.filter_list), onPressed: () {}),
        ],
      ),
      drawer: Drawer(child: ListView(
          children: <Widget>[
            Container(constraints: BoxConstraints.expand(height: 200),
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [Colors.red[200], Colors.purple[300]],
                      begin: Alignment.topRight, end: Alignment.bottomLeft)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CircleAvatar(child: Icon(Icons.movie)),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Flutter App",
                        style: TextStyle(color: Colors.white, fontSize: 24,
                            fontWeight: FontWeight.bold)),
                  )
                ],),
            ),
            buildMenu(title: "Profile", subtitle: "View your profile", icon: Icons.person)
          ])),
      body: Column(
        children: <Widget>[
          Container(color: Colors.red[300],
              child: Container(
                  margin: EdgeInsets.only(bottom: 12, left: 16, right: 16),
                  padding: EdgeInsets.all(6),
                  decoration: BoxDecoration(color: Colors.white,
                      borderRadius: BorderRadius.circular(6)),
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.search, color: Colors.grey,),
                      Expanded(child:
                      TextField(controller: textEditingController,
                          decoration: InputDecoration.collapsed(hintText: "something.."),
                          onChanged: (text) {
                            filterEmail(text);
                          })),
                    ],
                  ))),
          Expanded(
              child: Container(color: Colors.grey[400],
                  child: buildListView)),
        ],
      ),
    );
  }

  Widget get buildListView {
    return ChangeNotifierProvider(builder: (BuildContext context) {
      return emailProvider;
    }, child: Consumer<EmailProvider>(builder: (context, emailProvider, child) {
      return ListView.builder(padding: EdgeInsets.only(top: 16),
          itemCount: emailProvider.countEmailFiltered,
          itemBuilder: (BuildContext context, int index) {
            Email email = emailProvider.getEmailFiltered(index);
            return GestureDetector(child: buildRowEmail(index, email),
                onTap: () => navigateToDetailPage(email));
          });
    }));
  }

  Container buildRowEmail(int index, Email email) {
    return Container(
        decoration: BoxDecoration(color: Colors.white,
            borderRadius: BorderRadius.circular(8)),
        margin: EdgeInsets.symmetric(vertical: 4, horizontal: 16),
        padding: EdgeInsets.all(16),
        child: Row(children: <Widget>[
          CircleAvatar(child: Icon(Icons.email),
            backgroundColor: Colors.red[300],),
          Expanded(child:
          Padding(
            padding: EdgeInsets.only(left: 16),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(email.title, style: TextStyle(fontSize: 18),),
                Text(email.description),
              ],),
          )),
          Padding(
            padding: EdgeInsets.only(left: 16),
            child: Column(crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(email.time, style: TextStyle(fontSize: 18),),
                  GestureDetector(
                      child: ChangeNotifierProvider(builder: (BuildContext context) {
                        return emailProvider;
                      }, child: Consumer<EmailProvider>(builder: (context, emailProvider, child) {
                        return buildIconFavorite(emailProvider.getEmailFiltered(index).favorite);
                      })),
                      onTap: () {
                        toggleFavorite(index);
                      }),
                ]),
          )
        ]));
  }

  Icon buildIconFavorite(bool isFavorite) {
    if (isFavorite) {
      return Icon(Icons.star, color: Colors.yellow);
    } else {
      return Icon(Icons.star_border);
    }
  }

  ListTile buildMenu({String title, String subtitle, IconData icon}) {
    return ListTile(
        title: Text(title),
        subtitle: Text(subtitle),
        leading: Icon(icon));
  }

  void toggleFavorite(int index) {
    emailProvider.toggleFavorite(index);
  }

  navigateToDetailPage(Email email) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => DetailPage(email: email)));
  }

  void filterEmail(String text) {
    emailProvider.filter(text);
  }
}
