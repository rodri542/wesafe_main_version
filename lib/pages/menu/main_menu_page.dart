import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'dart:async';
import 'package:wesafe_main_version/pages/menu/lateral_bar.dart';
import '../../json_user.dart';

class MainMenuPage extends StatefulWidget {
  const MainMenuPage({super.key, required this.getting});
  final getting;

  @override
  State<MainMenuPage> createState() => _MainMenuPageState();
}

class _MainMenuPageState extends State<MainMenuPage> {
  BitmapDescriptor destinationIcon = BitmapDescriptor.defaultMarker;
  final Completer<GoogleMapController> _controller = Completer();
  LocationData? currentLocation;
  PermissionStatus? _permissionGranted;
  bool? _serviceEnabled;
  Location location = Location();
  StreamSubscription<LocationData>? listener;
  JsonParser? jsonParser;

  static const LatLng _kGooglePlex = LatLng(19.721178712723866, -101.18615112227262);

  void setCustomMarkerIcon() {
    BitmapDescriptor.fromAssetImage(
      ImageConfiguration(size: Size(10, 10)),
      'assets/logo/LogoSinFondo_1.png',
    ).then((value) {
      destinationIcon = value;
    });
  }

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
    currentLocation = await location.getLocation();
    print(currentLocation);
    setState(() {});
    GoogleMapController googleMapController = await _controller.future;

    listener = location.onLocationChanged.listen(
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

  getMethod() async {
    try {
      var theUrl =
          Uri.https('wesafeoficial.000webhostapp.com', '/newAlert.php');
      var res = await http.post(theUrl, body: {
        'ubi': '$currentLocation',
        'fecha': '${DateTime.now()}',
        'estado': '1',
        'usuario': '${jsonParser?.getUsuario()}',
      });
      print(res.body);

      var responsBody = json.decode(res.body);
    } catch (e) {
      print('Error aaaaaaaaaaaaaaaaaaaaaaaaaaaa      ${e}');
    }
  }

  void inicia() {
    jsonParser = JsonParser(widget.getting);
  }

  @override
  void initState() {
    setCustomMarkerIcon();
    isEnabled();
    getCurrentLocation();
    super.initState();
    inicia();
  }

  @override
  void dispose() {
    listener?.cancel();

    super.dispose();
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
            getMethod();
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
               
                markers: {
                  Marker(
                    markerId: MarkerId('Alerta'),
                    position: _kGooglePlex,
                    icon: destinationIcon,
                  )
                },
                
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
