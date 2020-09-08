import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:path/path.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
class LocationOnMaps extends StatefulWidget {
  @override
  _LocationOnMapsState createState() => _LocationOnMapsState();
}

class _LocationOnMapsState extends State<LocationOnMaps> {

  Location _location = Location();
  double _cla = 31.250,
      _clo = 75.7051;
  Set<Marker> _markers = Set<Marker>();
  Set<Polyline> _polyline = Set<Polyline>();
  GoogleMapController _googleMapController;

  BitmapDescriptor sourceImage, destinationImage;
  LocationData destinationLoc, currentLocation;

  int imageSize = 100;

  List<LatLng> polyLineCoordinates;
  PolylinePoints polylinePoints = PolylinePoints();
  static const String googleApiKey = "AIzaSyAiucOdNfh2LnBR7IPs_K17nf-MsaZCv_k";//API KEY

  Future<Uint8List> getBytesFromAsset(String path, int size) async{
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: size);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png)).buffer.asUint8List();
  }

  void setBitmapDescriptors() async {
    sourceImage = await BitmapDescriptor.fromBytes(await getBytesFromAsset('images/source.png',imageSize));
    destinationImage = await BitmapDescriptor.fromBytes(await getBytesFromAsset('images/destination.png',imageSize));

    // sourceImage = await BitmapDescriptor.fromAssetImage(
    //     ImageConfiguration(devicePixelRatio: 1.5), 'images/source.png');
    // destinationImage = await BitmapDescriptor.fromAssetImage(
    //     ImageConfiguration(devicePixelRatio: 1.5), 'images/destination.png');
  }

  void setInitialLocation() async {
    currentLocation = await _location.getLocation();
    destinationLoc = LocationData.fromMap({'latitude':_cla, 'longitude':_clo});
//     destinationLoc = currentLocation;
  }

  void showThingsOnMap(){
    var pin1Position = LatLng(currentLocation.latitude, currentLocation.longitude);
    var pin2Position = LatLng(destinationLoc.latitude, destinationLoc.longitude);
    _markers.add(Marker(
      markerId: MarkerId('current'),
      position: pin1Position,
      icon: sourceImage,
    ));
    _markers.add(Marker(
      markerId: MarkerId('destination'),
      position: pin2Position,
      icon: destinationImage,
    ));
    setPolyLines();
    print("//////////////////////////////////////////");
  }


  void onMyMapCreated(GoogleMapController mapController) async {

    await setBitmapDescriptors();
    await setInitialLocation();

    _googleMapController = mapController;
    _location.onLocationChanged.listen((newLocation) {
      _googleMapController.animateCamera(
          CameraUpdate.newCameraPosition(CameraPosition(
            target: LatLng(newLocation.latitude, newLocation.longitude),
            zoom: 8.0,
          )));
      setState(() {
        currentLocation = newLocation;
        _cla = newLocation.latitude;
        _clo = newLocation.longitude;
          showThingsOnMap();
      });
    });

  }

  void setPolyLines() async{
    List<PointLatLng> result = (await polylinePoints?.getRouteBetweenCoordinates(googleApiKey,
        PointLatLng(currentLocation.latitude,currentLocation.longitude),
        PointLatLng(destinationLoc.latitude,destinationLoc.longitude))).points;
    //getting points
      if(result.isNotEmpty){
        result.forEach((PointLatLng p) {
        polyLineCoordinates.add(LatLng(p.latitude,p.longitude));
      });
        setState(() {
          //drawing line
          _polyline.add(Polyline(
            width: 4,
            polylineId: PolylineId('poly'),
            points: polyLineCoordinates,
            color: Colors.blueAccent,

          ));
        });
    }else{
        print("***************************");
      }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Location & Marker"),),
      body: GoogleMap(
        onMapCreated: onMyMapCreated,
        compassEnabled: true,
        tiltGesturesEnabled: true,
        myLocationEnabled: true,
        markers: _markers,
        polylines: _polyline,
        initialCameraPosition: CameraPosition(
          target: LatLng(_cla, _clo),
          zoom: 10,
          tilt: 80,
        ),
      ),
    );

  }


}