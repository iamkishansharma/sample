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
      body: Center(
        child: Image.file(File(showImage()),),
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
