import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<ValidMail> fetchEmailValidity(String email) async {
  final response =
      await http.get("https://api.trumail.io/v2/lookups/json?email=$email");
  if (response.statusCode == 200) {
    return ValidMail.fromJson(json.decode(response.body));
  } else {
    print("Email is not Verified!");
    return null;
  }
}

class ValidMail {
  final bool validFormat;
  final bool deliverable;
  final String address;

  ValidMail({this.validFormat, this.deliverable, this.address});

  factory ValidMail.fromJson(Map<String, dynamic> json) {
    return ValidMail(
      validFormat: json['validFormat'],
      deliverable: json['deliverable'],
      address: json['address'],
    );
  }
}

class EmailVerifier extends StatefulWidget {
  @override
  _EmailVerifierState createState() => _EmailVerifierState();
}

class _EmailVerifierState extends State<EmailVerifier> {
  TextEditingController _controller = TextEditingController();
  Future<ValidMail> metaDataAboutEmail;
  bool showProcessing = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HTTP API Request(Email Verifier)'),
      ),
      body: SafeArea(
        child: Container(
          color: Colors.pinkAccent,
          child: Column(
            children: <Widget>[
              TextField(
                controller: _controller,
                decoration: InputDecoration(
                  hintText: 'kishan@gmail.com',
                  labelText: 'Email',
                ),
              ),
              RaisedButton(
                child: Text('Verify my Email'),
                onPressed: () {
                  setState(() {
                    metaDataAboutEmail = fetchEmailValidity(_controller.text);
                    if(showProcessing){
                      showProcessing = false;
                    }else{
                      showProcessing = true;
                    }
                  });
                },
              ),
              Expanded(
                child: Center(
                  child: FutureBuilder<ValidMail>(
                    future: metaDataAboutEmail,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Column(
                          children: <Widget>[
                            Text(snapshot.data.address),
                            Text(snapshot.data.validFormat?"Valid Format":"Not valid format"),
                            Text(snapshot.data.deliverable?"Email is correct & can receive emails":"This email doesn't exist"),
                          ],
                        );
                      }
                      return showProcessing?CircularProgressIndicator():Text("Not able to show Processing...");
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
