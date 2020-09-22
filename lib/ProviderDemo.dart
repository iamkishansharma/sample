import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProvideDemoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        FutureProvider<CountryModel>(
            initialData: new CountryModel("India"),
            create: (context) => getCountryModelFromNetwork()),
        FutureProvider<ProvinceModel>(
            initialData: new ProvinceModel("Punjab"),
            create: (context) => getProvinceModelFromNetwork()),
      ],
      child: MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: Text('Provider Demo'),
          ),
          body: Column(
            children: [
              Center(
                child: Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height / 10,
                  color: Colors.blueAccent,
                  child: Consumer<CountryModel>(
                    builder: (context, cm, child) {
                      return RaisedButton(
                        child: Text('Update State'),
                        onPressed: () {},
                      );
                    },
                  ),
                ),
              ),
              Center(
                child: Container(
                  alignment: AlignmentDirectional.center,
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height / 10,
                  color: Colors.cyanAccent,
                  child: Consumer<CountryModel>(
                    builder: (context, cm, child) {
                      return Text(
                        cm.countryName,
                        style: TextStyle(fontSize: 30.0),
                      );
                    },
                  ),
                ),
              ),
              /////Todo::

              Center(
                child: Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height / 10,
                  color: Colors.blueAccent,
                  child: Consumer<ProvinceModel>(
                    builder: (context, cm, child) {
                      return RaisedButton(
                        child: Text('Update Province'),
                        onPressed: () {},
                      );
                    },
                  ),
                ),
              ),
              Center(
                child: Container(
                  alignment: AlignmentDirectional.center,
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height / 10,
                  color: Colors.cyanAccent,
                  child: Consumer<ProvinceModel>(
                    builder: (context, cm, child) {
                      return Text(
                        cm.proName,
                        style: TextStyle(fontSize: 30.0),
                      );
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

Future<CountryModel> getCountryModelFromNetwork() async {
  await Future.delayed(Duration(seconds: 6));
  return CountryModel("Nepal");
}

class CountryModel with ChangeNotifier {
  String countryName = "India";

  CountryModel(this.countryName);
}

Future<ProvinceModel> getProvinceModelFromNetwork() async {
  await Future.delayed(Duration(seconds: 10));
  return ProvinceModel("Bagmati");
}

class ProvinceModel with ChangeNotifier {
  String proName = "Punjab";

  ProvinceModel(this.proName);
}
