import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'dart:async';
import 'package:wesafe_main_version/pages/menu/lateral_bar.dart';

class MainMenuPage extends StatefulWidget {
  const MainMenuPage({super.key});

  @override
  State<MainMenuPage> createState() => _MainMenuPageState();
}

class _MainMenuPageState extends State<MainMenuPage> {
  final Completer<GoogleMapController> _controller = Completer();
  LocationData? currentLocation;
  PermissionStatus? _permissionGranted;
  bool? _serviceEnabled;
  Location location = Location();

  void isEnabled() async {
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled!) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled!) {
        return;
      }
    }
    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
  }

  void getCurrentLocation() async {
    print(location);
    currentLocation = await location.getLocation();
    print(currentLocation);
    setState(() {});
    GoogleMapController googleMapController = await _controller.future;

    location.onLocationChanged.listen(
      (newloc) {
        setState(
          () {
            currentLocation = newloc;
            googleMapController.animateCamera(
              CameraUpdate.newCameraPosition(
                CameraPosition(
                  zoom: 18,
                  target: LatLng(
                    newloc.latitude!,
                    newloc.longitude!,
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  void initState() {
    isEnabled();
    getCurrentLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawerEnableOpenDragGesture: false,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        decoration: BoxDecoration(
          border: Border.all(),
          color: Color(0xff511262),
          borderRadius: BorderRadius.circular(15),
        ),
        margin: const EdgeInsets.all(10),
        width: 180,
        height: 70,
        child: MaterialButton(
          shape:
              BeveledRectangleBorder(borderRadius: BorderRadius.circular(6.7)),
          onPressed: () {
            print('se presiona');
          },
          child: const Icon(
            color: Color.fromARGB(255, 249, 5, 5),
            Icons.warning_amber,
            size: 50,
            
          ),
        ),
      ),
      appBar: AppBar(
        elevation: 5,
        shadowColor: Colors.black,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarBrightness: Brightness.light,
        ),
        titleTextStyle: const TextStyle(
          color: Color(0xffB17A50),
          fontSize: 50,
          fontFamily: 'FuenteWeSafe',
        ),
        centerTitle: true,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Text(
              "weSafe",
            ),
          ],
        ),
      ),
      body: Container(
        alignment: Alignment.center,
        color: const Color.fromARGB(255, 179, 42, 217),
        width: double.infinity,
        height: double.infinity,
        child: Builder(
          builder: (context) {
            if (currentLocation == null) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return GoogleMap(
                buildingsEnabled: true,
                compassEnabled: true,
                myLocationEnabled: true,
                mapType: MapType.normal,
                initialCameraPosition: CameraPosition(
                  target: LatLng(
                      currentLocation!.latitude!, currentLocation!.latitude!),
                  zoom: 18,
                ),
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                },
              );
            }
          },
        ),
      ),
      drawer: const LateralBar(),
    );
  }
}
