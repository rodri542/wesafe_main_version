import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';

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

      ///para abrir el cajon lateral
      //resizeToAvoidBottomInset: false,
      //drawerEdgeDragWidth: 100,
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
        color: Colors.red,
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

      ///Aqui es en donde se despliega la barra lateral
      drawer: Drawer(
        width: 150,
        elevation: 50,
        child: Column(children: const [
          SizedBox(
            height: 50,
          ),
          Text(
            "Prueba@prueba.com",
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ]),
      ),
    );
  }
}
