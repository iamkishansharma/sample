import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShowImage extends StatelessWidget {
  final String imagePath;

  Future<String>get imageFile async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    String path1 = pref.getString('myAcc');
    return path1;
  }
  String showImage (){
    return imagePath;
 }
  ShowImage({Key key, this.imagePath}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
      ),
      body: Container(
      width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.redAccent,
        child: InteractiveViewer(
          boundaryMargin: EdgeInsets.all(20.0),
          minScale: 0.1,
          maxScale: 10,
          scaleEnabled: true,
          child: Image.file(File(showImage()),),
        ),
      ),
      floatingActionButton: Container(
        width: 100.0,
        height: 100.0,
        child: FittedBox(
          child: FloatingActionButton(
            backgroundColor: Colors.cyanAccent,
            child: Icon(Icons.account_balance),
            onPressed: (){
              print("Clicked !");
            },
            elevation: 10.0,
            splashColor: Colors.blueAccent,
            hoverColor: Colors.redAccent,
          ),
        ),
      ),
    );
  }
}
