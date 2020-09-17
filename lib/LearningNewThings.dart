import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LearningNewThings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'New Things',

      home: LearningNewHome(),
    );
  }
}

class LearningNewHome extends StatefulWidget {
  @override
  _LearningNewHomeState createState() => _LearningNewHomeState();
}

class _LearningNewHomeState extends State<LearningNewHome> {
  void showAndroidAlertDialog( context,tt){
    showDialog(context: context, builder:(BuildContext context){
      if(tt){
        return AlertDialog(
          title: Text("AlertDialog Android Style"),
          content: Text("Body of the Alert Dialog"),
          actions: [
            FlatButton(
              onPressed: (){
                Navigator.pop(context);
              },
              child: Text("OK"),
            ),
            FlatButton(
              onPressed: (){},
              child: Text("Cancel"),
            ),
          ],);
      }else{
        return CupertinoAlertDialog(
          title: Text("AlertDialog IOS Style"),
          content: Text("Body of the Alert Dialog"),
          actions: [
            FlatButton(
              onPressed: (){
                Navigator.pop(context);},
              child: Text("OK"),
            ),
            FlatButton(
              onPressed: (){},
              child: Text("Cancel"),
            ),
          ],
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Learning New Things'),
        backgroundColor: Colors.cyanAccent,
      ),
      body: Container(
        child: Column(
          children: [
            FlatButton(
              color: Colors.red,
              onPressed: (){
                showAndroidAlertDialog(context, true);
              },
              child: Text('Click Me'),
            ),

            SizedBox(height: 5.0,),
            CupertinoButton(
              color: Colors.teal,
              minSize: 5.0,
              onPressed: (){
                showAndroidAlertDialog(context,false);
              },
              child: Text('Click Me'),
            ),
            SizedBox(height: 5.0,),
            FloatingActionButton(
              onPressed: (){},
              backgroundColor: Colors.yellowAccent,
              child: Icon(Icons.ac_unit),
            ),
            SizedBox(height: 5.0,),
            FloatingActionButton(
              onPressed: (){},
              backgroundColor: Colors.blueAccent,
              child: Icon(Icons.threed_rotation),
            ),
          ],
        ),
      ),
    );
  }
}
