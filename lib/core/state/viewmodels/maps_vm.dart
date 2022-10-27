import 'dart:async';

import 'package:flutter/material.dart';
import 'package:devfest/views/maps_page/maps_search_page.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:devfest/utils/constants.dart';
import 'package:google_place/google_place.dart' as places;
import 'package:location/location.dart';

class MapsVM extends ChangeNotifier {
  TextEditingController _your_location_ctrl = TextEditingController();
  TextEditingController get yourlocation_ctrl => this._your_location_ctrl;
  set yourlocation_ctrl(TextEditingController value) {
    this._your_location_ctrl = value;
    notifyListeners();
  }

  TextEditingController _landmark_ctrl = TextEditingController();
  TextEditingController get landmarkctrl => this._landmark_ctrl;
  set landmarkctrl(TextEditingController value) {
    this._landmark_ctrl = value;
    notifyListeners();
  }

  final Completer<GoogleMapController> _controller = Completer();

  late GoogleMapController _mapController;
  get mapController => this._mapController;

  set mapController(value) {
    this._mapController = value;
    notifyListeners();
  }

  late places.GooglePlace googlePlace;
  get getGooglePlace => this.googlePlace;

  void setGooglePlace(googlePlace) {
    this.googlePlace = googlePlace;
    //notifyListeners();
  }

  List<LatLng> _polylineCoordinates = [];
  List<LatLng> get getPolylineCoordinates => this._polylineCoordinates;
  set setPolylineCoordinates(List<LatLng> polylineCoordinates) {
    this._polylineCoordinates = polylineCoordinates;
    notifyListeners();
  }

  var _currentLocation;
  get currentLocation => this._currentLocation;
  set currentLocation(var value) {
    this._currentLocation = value;
    notifyListeners();
  }

  LatLng source = const LatLng(6.5355, 3.3087);

  LatLng destination =
      const LatLng(6.4230432, 3.4450862); //Landmark event center.

  LocationData? _curentLocation;
  get getCurentLocation => this._curentLocation;

  set setCurentLocation(curentLocation) {
    this._curentLocation = curentLocation;
    notifyListeners();
  }

  List<places.AutocompletePrediction> predictions = [];

  Timer? _debounce;

  void getCurrentLocation() async {
    Location location = Location();

    location.getLocation().then((location) => setCurentLocation = location);

    GoogleMapController googleMapController = await _controller.future;

    location.onLocationChanged.listen((newLocation) {
      setCurentLocation = newLocation;
      googleMapController.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            zoom: 13.5,
            target: LatLng(newLocation.latitude!, newLocation.longitude!),
          ),
        ),
      );
      notifyListeners();
    });
  }

  void getPolyPoint() async {
    PolylinePoints polylinePoints = PolylinePoints();

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      AppConstants.google_api_key,
      PointLatLng(source.latitude, source.longitude),
      PointLatLng(destination.latitude, destination.longitude),
    );

    if (result.points.isNotEmpty) {
      result.points.forEach(
        (PointLatLng point) => _polylineCoordinates.add(
          LatLng(point.latitude, point.longitude),
        ),
      );
      notifyListeners();
    }
  }

  // setGooglePlace(places.GooglePlace(AppConstants.google_api_key));

  void initializePlaces() {
    //calling setGoogle place alone threw an error, so I used mapController to call it.
    setGooglePlace(places.GooglePlace(AppConstants.google_api_key));
  }

  void onMapCreated(GoogleMapController mapcontroller) {
    _controller.complete(mapcontroller);
  }

  void autoCompleteSearch(String value) async {
    var result = await googlePlace.autocomplete.get(value);
    if (result != null && result.predictions != null) {
      print(result.predictions!.first.description);

      predictions = result.predictions!;
      notifyListeners();
    }
  }

  void onChanged(value) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 2000), () {
      if (value.isNotEmpty) {
        //places api
        autoCompleteSearch(value);
      } else {
        //clear out the resut
      }
    });
  }
}

//void setGooglePlace(places.GooglePlace googlePlace) {}
