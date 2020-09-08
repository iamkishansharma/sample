import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';


//class GooleMapEx extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return MaterialApp(
//
//    );
//  }
//}


class GoogleMapState extends StatefulWidget {
  @override
  _GoogleMapStateState createState() => _GoogleMapStateState();
}

class _GoogleMapStateState extends State<GoogleMapState> {
 GoogleMapController myMapController;
  void myOnMapCreated(GoogleMapController mapController){
    myMapController = mapController;
//    _location.onLocationChanged.listen((event) {
//      myMapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
//        target: LatLng(event.latitude,event.longitude),
//        zoom: 20,
//      )));
//    });
  }
  MapType mapType = MapType.normal;
  int count = 0;
  Location _location;
  LocationData _locationData;
  LatLng latLng;

  Future<LocationData> getMyLocation()async{
    return await _location.getLocation();
  }


void changeMap(){
  setState(() {
    count++;
  if(count%2==0){
    return mapType = MapType.normal;
  }
  else{
    return mapType = MapType.satellite;

  }
  });
}

  @override
  Widget build(BuildContext context) {
    _location = Location();
    latLng = LatLng(31.2560,75.7051);

    return Scaffold(
      appBar: AppBar(
        title: Text("MapsK"),
      ),
      floatingActionButton: Container(
        width: 70,
        height: 70,
        margin: EdgeInsets.only(bottom: 80.0),
        child: FloatingActionButton(
          onPressed: () async{
            print("Getting Location....");
            _locationData = await _location.getLocation();
            print("Location Set");
            setState(() {
              print("Showing Location....");
              print("${_locationData.latitude} \n ${_locationData.longitude}");
              latLng = LatLng(_locationData.latitude,_locationData.longitude);
            });

          },
          child: Icon(Icons.my_location),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      backgroundColor: Colors.lightGreenAccent,
      body: SafeArea(
        child: Flex(
          direction: Axis.horizontal,
          children: <Widget>[
            Flexible(
              flex: 10,
              child: Column(
                children: <Widget>[
                  Expanded(
                    flex: 9,
                    child: GoogleMap(
                      onMapCreated: myOnMapCreated,
                      myLocationButtonEnabled: false,
                      myLocationEnabled: true,
                      initialCameraPosition: CameraPosition(
                        target: latLng,
                        zoom: 10,
                      ),
                      mapType: mapType,
                    ),
                  ),

                  Expanded(
                    flex: 1,
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            width: 100,
                            height: 500,
                            color: Colors.pinkAccent,
                            child: IconButton(
                              splashColor: Colors.cyanAccent,
                              icon: Icon(Icons.map),
                              onPressed: (){
                                print("Hello");
                                changeMap();
                              },
                            ),
                          ),
                        ),
                        SizedBox(width: 10,),
                        Container(
                          width: 100,
                          height: 500,
                          color: Colors.cyan,
                          child: IconButton(
                            splashColor: Colors.cyanAccent,
                            icon: Icon(Icons.airport_shuttle),
                            onPressed: (){
                              print("Hello");
                              changeMap();
                            },
                          ),
                        ),
                        SizedBox(width: 10,),
                        Container(
                          width: 100,
                          height: 500,
                          color: Colors.purpleAccent,
                          child: IconButton(
                            splashColor: Colors.cyanAccent,
                            icon: Icon(Icons.motorcycle),
                            onPressed: (){
                              print("Hello");
                              changeMap();
                            },
                          ),
                        ),
                        SizedBox(width: 10,),
                        Container(
                          width: 100,
                          height: 500,
                          color: Colors.pinkAccent,
                          child: IconButton(
                            splashColor: Colors.cyanAccent,
                            icon: Icon(Icons.directions_car),
                            onPressed: (){
                              print("Hello");
                              changeMap();
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

          ],
        ),
      )
    );
  }
}
