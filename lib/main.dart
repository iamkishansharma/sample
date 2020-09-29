import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:sample/FileHandingDemo.dart';
import 'package:sample/GoodPractice.dart';
import 'package:sample/LearningNewThings.dart';
import 'package:sample/ProviderDemo.dart';
import 'package:sample/StreamBuilderDemo.dart';
import 'package:sample/TakePitureDemo.dart';
import 'dart:math';
import 'AnimationDemo.dart';
import 'ApiCallDemo.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import 'LoationOnMaps.dart';
import 'google_maps_ex.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final cameras = await availableCameras();
  var myCamera = cameras.first;

  runApp(MyApp(myCamera));
}

class MyApp extends StatelessWidget {
  final myCamera;

  MyApp(this.myCamera);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "My Application",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        backgroundColor: Colors.amber,
        primaryColor: Colors.amber,
        accentColor: Colors.white,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => PageOne(),
        '/second': (context) => PageTwo(),
        '/third': (context) => TakePitureDemo(
              camera: myCamera,
            ),
        '/fileHandling': (context) => MyFileDemo(),
        '/g_map':(context) => GoogleMapState(),
        '/apiCall': (context)=> EmailVerifier(),
        '/mapMarkers': (context) => LocationOnMaps(),
        '/gotoAnimation': (context) => AnimationHome(),

        //After Mid Term
        '/newThings': (context) => LearningNewThings(),
        '/providerDemo':(context)=> ProvideDemoApp(),
        '/streamingApp': (context) => MyStreamApp(),
        '/goodPractices':(context) => GoodPractices(),
      },
    );
  }
}

class PageOne extends StatelessWidget {
  final int noOne = Random().nextInt(9) + 1;
  final int noTwo = Random().nextInt(9) + 1;

  int count = 0;
  final myController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("First Screen"),
        centerTitle: true,
        backgroundColor: Colors.cyan,
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Center(
              child: Text(
                "$noOne + $noTwo = ",
                style: TextStyle(
                  fontSize: 50.0,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
            TextField(
              inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
              keyboardType: TextInputType.number,
              controller: myController,
              decoration: InputDecoration(
                  hoverColor: Colors.blue.shade200,
                  border: InputBorder.none,
                  hintText: 'Enter the Answer'),
            ),
            FlatButton(
              color: Colors.greenAccent,
              onPressed: () {
                int a = int.parse(myController.text);
                if (a == (noOne + noTwo)) {
                  Navigator.pushNamed(context, '/second');
                } else {}
              },
              child: Text("Submit"),
            ),
            FlatButton(
              color: Colors.deepOrange,
              onPressed: () {
                Navigator.pushNamed(context, '/fileHandling');
              },
              child: Text("Goto File Handling"),
            ),

            FlatButton(
              color: Colors.lightGreen,
              onPressed: () {
                Navigator.pushNamed(context, '/g_map');
              },
              child: Text("Goto Maps"),
            ),

            //API here
            FlatButton(
              color: Colors.blueAccent,
              onPressed: () {
                Navigator.pushNamed(context, '/apiCall');
              },
              child: Text("Goto Email Verifier"),
            ),

            FlatButton(
              color: Colors.pinkAccent,
              onPressed: () {
                Navigator.pushNamed(context, '/mapMarkers');
              },
              child: Text("Goto Map Markers"),
            ),

            FlatButton(
              color: Colors.deepOrangeAccent,
              onPressed: () {
                Navigator.pushNamed(context, '/gotoAnimation');
              },
              child: Text("Goto Animation"),
            ),
            FlatButton(
              color: Colors.cyanAccent,
              onPressed: () {
                Navigator.pushNamed(context, '/newThings');
              },
              child: Text("Goto Buttons"),
            ),
            FlatButton(
              color: Colors.deepPurpleAccent,
              onPressed: () {
                Navigator.pushNamed(context, '/providerDemo');
              },
              child: Text("Provider Demo"),
            ),
            FlatButton(
              color: Colors.blueGrey,
              onPressed: () {
                Navigator.pushNamed(context, '/streamingApp');
              },
              child: Text("Streaming Demo"),
            ),
            FlatButton(
              color: Colors.brown,
              onPressed: () {
                Navigator.pushNamed(context, '/goodPractices');
              },
              child: Text("Good Practices"),
            ),

            FittedBox(
              child: FlatButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(100))
                ),
                color: Colors.orangeAccent,
                onPressed: () async {
                  SharedPreferences pref =
                  await SharedPreferences.getInstance();
                  int countFromPref = pref.getInt("myAcc2") ?? 0;
                  print(++countFromPref);
                  pref.setInt('myAcc2', countFromPref);
                },
                child: Text("Click to count++"),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class PageTwo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Second Screen"),
      ),
      body: Center(
        child: Column(
          children: <Widget>[

            RaisedButton(
              onPressed: () async {
                Navigator.pushNamed(context, '/third');
                // var url = 'sms:1234567890';
                // if (await canLaunch(url)) {
                //   launch(url);
                // } else {
                //   print('not able to reach !!!!');
                // }
              },
              child: Text('GO to Camera'),
            ),

            RaisedButton(
              onPressed: () async {
//                var sms = 'sms:1234567890'; //sms
//                var url = "tel:9845852024"; //dialer
                 var url = "https://kishansharma.netlify.app"; // browser
//                 var url = "mailto:kishan@heycode.com"; //email
//                var url = "file:";
                 if (await canLaunch(url)) {
                   launch(url);
                 } else {
                   print('not able to reach !!!!');
                 }
              },
              child: Text('Open Browser'),
            ),
          ],
        ),
      ),
    );
  }
}
