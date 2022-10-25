import 'package:devfest/core/router/navigator.dart';
import 'package:devfest/core/state/providers.dart';
import 'package:devfest/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:devfest/utils/colors.dart';

class MapsPage extends StatefulHookConsumerWidget {
  const MapsPage({super.key});

  @override
  ConsumerState<MapsPage> createState() => _MapsPageState();
}

class _MapsPageState extends ConsumerState<MapsPage> {
  late GoogleMapController mapController;
  final LatLng source = const LatLng(6.465423, 3.406438);
  final LatLng destination = const LatLng(6.4230432, 3.4450862);

  List<LatLng> polylineCoordinates = [];

  void getPolyPoint() async {
    PolylinePoints polylinePoints = PolylinePoints();

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      AppConstants.google_api_key,
      PointLatLng(source.latitude, source.longitude),
      PointLatLng(destination.latitude, destination.longitude),
    );

    if (result.points.isNotEmpty) {
      result.points.forEach(
        (PointLatLng point) => polylineCoordinates.add(
          LatLng(point.latitude, point.longitude),
        ),
      );
      setState(() {});
    }
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  void initState() {
    getPolyPoint();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var vm = ref.watch(mapsVm);
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          child: Stack(children: [
            GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition:
                  CameraPosition(target: destination, zoom: 13.2),
              markers: {
                Marker(markerId: MarkerId('destination'), position: destination)
              },
              polylines: {
                Polyline(
                    polylineId: PolylineId("route"),
                    points: polylineCoordinates,
                    color: Colors.blue,
                    width: 7)
              },
            ),
            Positioned(
              top: 70,
              left: 24,
              right: 20,
              child: GestureDetector(
                onTap: () {
                  AppNavigator.pushNamed(Routes.mapsSearch);
                },
                child: Container(
                  //  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 19),
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.search,
                        color: Color(0xff797A7C),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        'Search your location here',
                        style: TextStyle(color: AppColors.grey12),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
