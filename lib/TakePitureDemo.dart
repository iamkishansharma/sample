import 'dart:math';

import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sample/ShowImage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TakePitureDemo extends StatefulWidget {
  final CameraDescription camera;

  TakePitureDemo({Key key, @required this.camera}) : super(key: key);

  @override
  _TakePitureDemoState createState() => _TakePitureDemoState();
}

class _TakePitureDemoState extends State<TakePitureDemo> {
  CameraController _controller;
  Future<void> _controllerFuture;

  @override
  void initState() {
    super.initState();
    _controller = CameraController(widget.camera, ResolutionPreset.ultraHigh);
    _controllerFuture = _controller.initialize();

    @override
    void dispose() {
      _controller.dispose();
      super.dispose();
    }
  }

  Future<String> get localPath async {
    final myDir = await getExternalStorageDirectory();
    return myDir.parent.parent.parent.parent.path;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Text('Camera Screen'),
      ),
      body: FutureBuilder<void>(
        future: _controllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return CameraPreview(
              _controller,
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      floatingActionButton: Container(
        padding: EdgeInsets.only(bottom: 20.0),
        width: 100.0,
        height: 100.0,
        child: FittedBox(
          child: FloatingActionButton(
            onPressed: () async {
              try {
                await _controllerFuture;
                final dir = await localPath;
                final path = '$dir/'+'${DateTime.now()}.png';
//            final path = join((await getTemporaryDirectory()).path, '8.png');
                print(path);
                await _controller.takePicture(path);

                SharedPreferences pref = await SharedPreferences.getInstance();
                String ss = path??pref.getString("myAcc");
                print(ss);
                pref.setString('myAcc', ss);

                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ShowImage(
                          imagePath: path,
                        )));
              } catch (e) {
                print(e);
              }
            },
            backgroundColor: Colors.white,
            child: Icon(Icons.camera_alt),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterDocked,
    );
  }
}
