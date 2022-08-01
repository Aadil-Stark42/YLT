import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../res/ResColor.dart';
import '../../res/ResString.dart';
import '../../utils/Utils.dart';
import '../models/OrdersDataModel.dart';

class DetailsScreen extends StatefulWidget {
  final OrdersDataModel ordersModel;
  final String title;

  DetailsScreen({required this.ordersModel, required this.title});

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  double CAMERA_ZOOM = 8;
  double CAMERA_TILT = 0;
  double CAMERA_BEARING = 30;
  late LatLng SOURCE_LOCATION;

  late LatLng DEST_LOCATION;
  Completer<GoogleMapController> _controller = Completer();

  // this set will hold my markers
  Set<Marker> _markers = {};

  // this will hold the generated polylines
  Set<Polyline> _polylines = {};

  // this will hold each polyline coordinate as Lat and Lng pairs
  List<LatLng> polylineCoordinates = [];

  // this is the key object - the PolylinePoints
  // which generates every polyline between start and finish
  PolylinePoints polylinePoints = PolylinePoints();
  String googleAPIKey = "AIzaSyA-YiqHgS6yxhPcdH26m4nLZt3LOMcv2Ac";

  // for my custom icons
  late BitmapDescriptor sourceIcon;
  late BitmapDescriptor destinationIcon;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    /*  SOURCE_LOCATION = LatLng(
        double.parse(widget.ordersModel.pickup_latitude.toString()),
        double.parse(widget.ordersModel.pickup_longitude.toString()));
    DEST_LOCATION = LatLng(
        double.parse(widget.ordersModel.drop_latitude.toString()),
        double.parse(widget.ordersModel.drop_longitude.toString()));*/

    SOURCE_LOCATION = LatLng(22.303894, 70.802162);
    DEST_LOCATION = LatLng(21.722000, 70.444504);

    setSourceAndDestinationIcons();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainColor,
        title: Text(widget.title + ' Details'),
        actions: <Widget>[],
      ),
      body: SizedBox(
        width: double.maxFinite,
        child: Padding(
          padding: const EdgeInsets.only(left: 10, top: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 70,
                height: 70,
                child: CircleAvatar(
                  backgroundColor: mainColor,
                  child: Image.asset(
                    widget.title == pendingOrdersStr
                        ? imagePath + "ic_pending.png"
                        : widget.title == processOrdersStr
                            ? imagePath + "ic_process.png"
                            : widget.title == completeOrdersStr
                                ? imagePath + "ic_complete.png"
                                : imagePath + "ic_pending.png",
                    width: 35,
                    height: 35,
                    color: whiteColor,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                widget.ordersModel.name.toString(),
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 18, fontFamily: poppins_bold),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 6,
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  Text(
                    'Order id :- #${widget.ordersModel.orderId}',
                    style: const TextStyle(
                        fontSize: 16, fontFamily: poppins_medium),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  Text(
                    'Mobile :- ${widget.ordersModel.customerPhone.toString()}',
                    style: const TextStyle(
                        fontSize: 16, fontFamily: poppins_medium),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  Text(
                    'Pick up :- ${widget.ordersModel.packupAddress.toString()}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontSize: 16, fontFamily: poppins_medium),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  Text(
                    'Drop :- ${widget.ordersModel.dropAddress.toString()}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontSize: 16, fontFamily: poppins_medium),
                  )
                ],
              ),
              SizedBox(
                height: 50,
              ),
              mapview(),
            ],
          ),
        ),
      ),
    );
  }

  Widget mapview() {
    CameraPosition initialLocation = CameraPosition(
        zoom: CAMERA_ZOOM,
        bearing: CAMERA_BEARING,
        tilt: CAMERA_TILT,
        target: SOURCE_LOCATION);
    return SizedBox(
      height: 300,
      child: GoogleMap(
          myLocationEnabled: true,
          compassEnabled: true,
          tiltGesturesEnabled: false,
          markers: _markers,
          polylines: _polylines,
          mapType: MapType.normal,
          initialCameraPosition: initialLocation,
          onMapCreated: onMapCreated),
    );
  }

  void onMapCreated(GoogleMapController controller) {
    controller.setMapStyle(mapStyles);
    _controller.complete(controller);
    setMapPins();
    setPolylines();
  }

  void setMapPins() {
    setState(() {
      // source pin
      _markers.add(Marker(
          markerId: MarkerId('sourcePin'),
          position: SOURCE_LOCATION,
          icon: sourceIcon));
      // destination pin
      _markers.add(Marker(
          markerId: MarkerId('destPin'),
          position: DEST_LOCATION,
          icon: destinationIcon));
    });
  }

  setPolylines() async {
    PolylineResult? result = await polylinePoints.getRouteBetweenCoordinates(
      googleAPIKey,
      PointLatLng(SOURCE_LOCATION.latitude, SOURCE_LOCATION.longitude),
      PointLatLng(DEST_LOCATION.latitude, DEST_LOCATION.longitude),
    );
    if (result.points.isNotEmpty) {
      // loop through all PointLatLng points and convert them
      // to a list of LatLng, required by the Polyline
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    }

    setState(() {
      // create a Polyline instance
      // with an id, an RGB color and the list of LatLng pairs
      Polyline polyline = Polyline(
          polylineId: PolylineId("poly"),
          color: Color.fromARGB(255, 40, 122, 198),
          points: polylineCoordinates);

      // add the constructed polyline as a set of points
      // to the polyline set, which will eventually
      // end up showing up on the map
      _polylines.add(polyline);
    });
  }

  void setSourceAndDestinationIcons() async {
    sourceIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5),
        imagePath + 'driving_pin.png');
    destinationIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5),
        imagePath + 'destination_map_marker.png');
  }
}
