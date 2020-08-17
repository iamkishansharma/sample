import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class MyFileDemo extends StatefulWidget {
  @override
  _MyFileDemoState createState() => _MyFileDemoState();
}

class _MyFileDemoState extends State<MyFileDemo> {
  var textController = TextEditingController();

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  Future<String> get localPath async {
    final myDir = await getExternalStorageDirectory();
    return myDir.parent.parent.parent.parent.path;
  }

  Future<File> get localFile async {
    final path = await localPath;
    return File("$path/myFile.txt");
  }

  String readData = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("File Handling Demo"),
        backgroundColor: Colors.cyan,
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            TextField(
              controller: textController,
            ),
            Row(
              children: <Widget>[
                FlatButton(
                  onPressed: () async {
                    if (textController.text.length > 0) {
                      File txtFile = await localFile;
                      txtFile.writeAsString(textController.text,
                          mode: FileMode.append);

                      textController.clear(); //
                    } else {
                      print("Enter some Text");

                      showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                content: Text("Enter some Text!" +
                                    Platform.operatingSystemVersion),
                                title: Text("File Handling Error"),
                                actions: [
                                  FlatButton(
                                    color: Colors.blue,
                                    child: Text("OK"),
                                    onPressed: () {},
                                  )
                                ],
                              ));
                    }
                  },
                  color: Colors.pinkAccent,
                  child: Text("Save File"),
                ),
                FlatButton(
                  color: Colors.pinkAccent,
                  onPressed: () async {
                    try {
                      File txtFile = await localFile;
                      String fileContent = await txtFile.readAsString();
                      setState(() {
                        readData = fileContent;
                      });
                    } catch (e) {
                      print(e.toString());
                    }
                  },
                  child: Text("Read File"),
                ),
              ],
            ),
            Text("Text From Read File\n$readData"),
          ],
        ),
      ),
    );
  }
}
