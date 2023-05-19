import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';

import 'package:wesafe_main_version/pages/menu/lateral_bar.dart';

class MainMenuPage extends StatefulWidget {
  const MainMenuPage({super.key});

  @override
  State<MainMenuPage> createState() => _MainMenuPageState();
}

class _MainMenuPageState extends State<MainMenuPage> {
  final Completer<GoogleMapController> _controller = Completer();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(19.673263, -101.229802),
    zoom: 15,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
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
            color: Color.fromARGB(255, 255, 255, 255),
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
        child: GoogleMap(
          mapType: MapType.normal,
          initialCameraPosition: _kGooglePlex,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
        ),
      ),
      drawer: const LateralBar(),
    );
  }
}
