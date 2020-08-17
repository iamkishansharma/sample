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
  }
  MapType mapType = MapType.normal;
  int count = 0;
  Location _location;
  LocationData _locationData;
  LatLng latLng;

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
      floatingActionButton: FloatingActionButton(
        onPressed: () async{
          _locationData = await _location.getLocation();
          latLng = LatLng(_locationData.latitude,_locationData.longitude);
          },
        child: Icon(Icons.my_location),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      backgroundColor: Colors.lightGreenAccent,
      body: GoogleMap(
        onMapCreated: myOnMapCreated,
        initialCameraPosition: CameraPosition(
          target: latLng,
          zoom: 20,
        ),
        mapType: mapType,
        },
      ),
    );
  }
}
