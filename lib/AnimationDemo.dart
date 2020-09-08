import 'dart:math';

import 'package:flutter/material.dart';

import 'TransitionAnimationDemo.dart';

class AnimationHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: AnimationDemo(),
    );
  }
}

class AnimationDemo extends StatefulWidget {
  @override
  _AnimationDemoState createState() => _AnimationDemoState();
}

class _AnimationDemoState extends State<AnimationDemo> {
  void handleClick(String value) {
    switch (value) {
      case 'Random Animation':
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => NextAnimationClass()));
        break;
      case 'Tween Animation':
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => TweenAnimationDemo()));
        break;
      case 'Transition Anim':
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => TransitionAnim2()));
        break;
    }
  }

  double opa = 0.2;
  bool b = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Animation Demo'),
        backgroundColor: Colors.purpleAccent,
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: handleClick,
            itemBuilder: (BuildContext context) {
              return {'Random Animation', 'Tween Animation','Transition Anim'}.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            AnimatedOpacity(
              duration: Duration(seconds: 1),
              opacity: opa,
              child: Image.asset('images/source.png'),
            ),
            RaisedButton(
              child: Text('Animate'),
              elevation: 5.0,
              onPressed: () {
                //TODO::
                setState(() {
                  if (opa <= 1.0 && b) {
                    opa += 0.2;
                    b = true;
                  } else {
                    opa -= 0.2;
                    b = false;
                  }
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}


class NextAnimationClass extends StatefulWidget {
  @override
  _NextAnimationClassState createState() => _NextAnimationClassState();
}

class _NextAnimationClassState extends State<NextAnimationClass> {
  Color randomColor() {
    return Color(Random().nextInt(0xFFFFFFFF));
  }

  double getBorderRadius() {
    return Random().nextInt(100).toDouble();
  }

  double borderRadius = 10.0;
  Color animColor = Colors.cyanAccent;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Animation Demo'),
        backgroundColor: Colors.black26,
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 200,
                height: 200,
                child: AnimatedContainer(
                  curve: Curves.easeOut,
                  duration: Duration(seconds: 1),
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: animColor,
                    borderRadius: BorderRadius.circular(borderRadius),
                  ),
                ),
              ),
              FittedBox(
                child: AnimatedContainer(
                  duration: Duration(seconds: 1),
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    color: animColor,
                    borderRadius: BorderRadius.circular(borderRadius),
                  ),
                  child: MaterialButton(
                    elevation: 10.0,
                    child: Text('Click Me'),
                    onPressed: () {
                      setState(() {
                        animColor = randomColor();
                        borderRadius = getBorderRadius();
                      });
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class TweenAnimationDemo extends StatefulWidget {
  @override
  _TweenAnimationDemoState createState() => _TweenAnimationDemoState();
}

class _TweenAnimationDemoState extends State<TweenAnimationDemo>
    with TickerProviderStateMixin {
  AnimationController controller,controller2,controller3;
  Animation<double> growAnimation, opacityAnimation;
  Animation<double> rotateAnimation, translateAnimation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller =
        AnimationController(duration: Duration(seconds: 4), vsync: this);
    growAnimation = Tween<double>(begin: 0, end: 500).animate(controller);

    growAnimation.addListener(() {
      setState(() {

      });
    });

    growAnimation.addStatusListener((status) {
      print("$status");
    });

    opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(controller);
    opacityAnimation.addListener(() {
      setState(() {

      });
    });
    controller.forward();

    controller2 =
        AnimationController(duration: Duration(seconds: 3), vsync: this);
    rotateAnimation = Tween<double>(begin: 0,end: 6).animate(controller2);
    rotateAnimation.addListener(() {
      setState(() {

      });
    });
    controller2.forward();

    controller3 =
        AnimationController(duration: Duration(seconds: 3), vsync: this);
    translateAnimation = Tween<double>(begin: -500,end: 300,).animate(controller3);
    translateAnimation.addListener(() {
      setState(() {

      });
    });
    controller3.forward();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TweenAnimation'),
        backgroundColor: Colors.red,
      ),
      body: SafeArea(
          child: Transform.translate(
            offset: Offset(0,translateAnimation.value),
            child: Transform.rotate(
              angle: rotateAnimation.value,
              child: Opacity(
                opacity: opacityAnimation.value,
                child: Center(child: Container(
                    width: growAnimation.value,
                    height: growAnimation.value,
                    child: FlutterLogo())),
              ),
            ),
          ),
    ),);
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
    controller2.dispose();
    controller3.dispose();
  }
}
