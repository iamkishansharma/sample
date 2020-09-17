import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';


class TransitionAnim extends StatelessWidget {
  final VoidCallback onTap;
  final String imageName;
  final double width;
  TransitionAnim({Key key, this.onTap, this.imageName,this.width}):super(key:key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Hero(
        tag: imageName,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            child: Image.asset(
              imageName,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}

class TransitionAnim2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transition Anim'),
        backgroundColor: Colors.cyanAccent,
      ),
      body: SafeArea(
        child: Container(
          alignment: AlignmentDirectional.topCenter,
          child: Row(
            children:[
              TransitionAnim(
                width: 100,
                imageName: 'images/source.png',
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute<void>(
                      builder: (BuildContext context){
                        return Scaffold(
                          appBar: AppBar(
                            title: Text('Animation is Here'),
                            backgroundColor: Colors.cyan,
                          ),
                          body: Center(
                            child: Container(
                              child: TransitionAnim(
                                width: 300,
                                imageName: 'images/source.png',
                                onTap: (){
                                  //TODO::
                                  Navigator.pop(context);
                                },
                              ),
                            ),
                          ),
                        );
                      }
                  ));
                },
              ),
              TransitionAnim(
                width: 100,
                imageName: 'images/destination.png',
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute<void>(
                      builder: (BuildContext context){
                        return Scaffold(
                          appBar: AppBar(
                            title: Text('Animation is Here'),
                            backgroundColor: Colors.cyan,
                          ),
                          body: Center(
                            child: Container(
                              child: TransitionAnim(
                                width: 300,
                                imageName: 'images/destination.png',
                                onTap: (){
                                  //TODO::
                                  Navigator.pop(context);
                                },
                              ),
                            ),
                          ),
                        );
                      }
                  ));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
