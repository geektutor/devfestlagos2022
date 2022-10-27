import 'package:devfest/core/router/navigator.dart';
import 'package:devfest/core/state/providers.dart';
import 'package:devfest/utils/constants.dart';
import 'package:devfest/views/maps_page/maps_search_page.dart';
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
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    ref.watch(mapsVm).getCurrentLocation();
    ref.watch(mapsVm).getPolyPoint();
  }

  @override
  Widget build(BuildContext context) {
    var vm = ref.watch(mapsVm);
    return Scaffold(
      body: vm.getCurentLocation == null
          ? const Center(
              child: CircularProgressIndicator(
                color: Colors.blue,
              ),
            )
          : SafeArea(
              child: Container(
                width: double.infinity,
                child: Stack(children: [
                  GoogleMap(
                    onMapCreated: vm.onMapCreated,
                    initialCameraPosition: CameraPosition(
                        target: LatLng(vm.getCurentLocation!.latitude!,
                            vm.getCurentLocation!.longitude!),
                        zoom: 13.2),
                    markers: {
                      Marker(
                        markerId: MarkerId("currentLocation"),
                        position: LatLng(vm.getCurentLocation!.latitude!,
                            vm.getCurentLocation!.longitude!),
                      ),
                      Marker(
                        markerId: MarkerId("source"),
                        position: vm.source,
                      ),
                      Marker(
                          markerId: MarkerId('destination'),
                          position: vm.destination)
                    },
                    polylines: {
                      Polyline(
                          polylineId: PolylineId("route"),
                          points: vm.getPolylineCoordinates,
                          color: Colors.blue,
                          width: 6)
                    },
                  ),
                  Positioned(
                    top: 70,
                    left: 24,
                    right: 24,
                    child: GestureDetector(
                      onTap: () {
                        // AppNavigator.pushNamed(Routes.mapsSearch);
                        var pickedLocation = Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MapSearchPage()));
                        print(pickedLocation.runtimeType);
                        setState(() {
                          vm.currentLocation = pickedLocation;
                        });
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

                  //Directions Component
                  Visibility(
                      visible: vm.currentLocation != null,
                      child: Positioned(
                        top: 144,
                        left: 24,
                        right: 24,
                        child: Container(
                          //  width: double.infinity,
                          padding: EdgeInsets.all(16),

                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Image.asset(
                                    'assets/images/png/Rectangle 39.png',
                                    width: 80,
                                    height: 80,
                                  ),
                                  SizedBox(
                                    width: 16,
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        'Your Destination ETA is',
                                        style: TextStyle(
                                            color: AppColors.grey0,
                                            fontSize: 16),
                                      ),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      Text(
                                        '2 hr 34 min away',
                                        style: TextStyle(
                                            color: Color(0xff4285F4),
                                            fontSize: 28),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 24,
                              ),
                              //View Direction Button
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: () {},
                                  child: Text(
                                    'View Directions',
                                    style: TextStyle(
                                        color: AppColors.white, fontSize: 18),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Color(0xff4285F4),
                                      padding:
                                          EdgeInsets.symmetric(vertical: 24),
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(88)))),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ))
                ]),
              ),
            ),
    );
  }
}
