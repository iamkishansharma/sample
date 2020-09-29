import 'dart:async';

import 'package:flutter/material.dart';

class MyStreamApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MyStreamingHome();
  }
}
class MyStreamingHome extends StatefulWidget {
  @override
  _MyStreamingHomeState createState() => _MyStreamingHomeState();
}

class _MyStreamingHomeState extends State<MyStreamingHome> {
  final ob = new Distance(1,100);

  StreamController<Distance> _controller;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = new StreamController<Distance>();
    _controller.add(ob);
  }
  void increment(){
    ob.centimeters++;
    ob.meters = ob.centimeters/100;
    _controller.add(ob);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Stream example'),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Text('Changing value without using setState() using StreamBuilder'),
              StreamBuilder(
                stream: _controller.stream,
                builder: (BuildContext context, snapshot){
                  if(snapshot.hasError){
                    return Text('Something Went Wrong!!!');
                  }else if(snapshot.data.toString()==null){
                    return Text('! No data found !');
                  }else{
                    return Column(
                      children: [
                        Text("${snapshot.data.toString()}"),
                      ],
                    );
                  }
                },
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          increment();
        },
        child:Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class Distance{
  double meters;
  int centimeters;
  Distance(this.meters,this.centimeters){}
  @override toString() => 'Meters: $meters \n Centimeters: $centimeters';
  
}