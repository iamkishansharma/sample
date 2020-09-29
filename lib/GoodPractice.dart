import 'package:flutter/material.dart';

class GoodPractices extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hello',
      home: GooPracticesHome(),
    );
  }
}
class GooPracticesHome extends StatefulWidget {
  @override
  _GooPracticesHomeState createState() => _GooPracticesHomeState();
}

class _GooPracticesHomeState extends State<GooPracticesHome> {

  /*
  /////  ?? is a NULL Operator
  /////  ?. is a NULL AWARE Operator
  var a = (variable == null)?20:variable;
  var aa = variable??20;

  var a = variable?.first;

  /////  SPREAD COLLECTION
  var oldList = [60,70,80];
  var newList = [10, 20,30,...oldList];
   */
var newsList = [r'Kishan is not laving this Planet', "Who'll be the GOD of space race",
  'Kishan is not laving this Planet', "Who'll be the GOD of space race",
  "God is great but not we why?"
  'Kishan is not laving this Planet', "Who'll be the GOD of space race",
  "God is great but not we why?"
      'Kishan is not laving this Planet', "Who'll be the GOD of space race",
  "God is great but not we why?"
      'Kishan is not laving this Planet', "Who'll be the GOD of space race",
  "God is great but not we why?"
      'Kishan is not laving this Planet', "Who'll be the GOD of space race",
  "God is great but not we why?"
      'Kishan is not laving this Planet', "Who'll be the GOD of space race",
  "God is great but not we why?"
      'Kishan is not laving this Planet', "Who'll be the GOD of space race",
  "God is great but not we why?" ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Good Practices'),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.white10,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: List.generate(newsList.length, (index) =>
                Card(
                  elevation: 2,
                  shadowColor: Colors.white,
                  color: Colors.white24,
                  child: ListTile(
                    onTap: (){},
                      leading: Icon(Icons.arrow_drop_down_circle),
                      title:Text("Headlines"),
                      subtitle: Text(newsList[index]),
                  ),
                ),
            ),
          ),
        ),
      ),
    );
  }
}
