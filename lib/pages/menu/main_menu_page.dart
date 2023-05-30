import 'dart:convert';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:permission_handler/permission_handler.dart'
    as permission_handler;
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'dart:async';
import 'package:wesafe_main_version/pages/menu/lateral_bar.dart';
import '../../json_alert.dart';
import '../../json_user.dart';

class MainMenuPage extends StatefulWidget {
  const MainMenuPage({super.key, required this.getting});
  final getting;

  @override
  State<MainMenuPage> createState() => _MainMenuPageState();
}

class _MainMenuPageState extends State<MainMenuPage> {
  List<int>? frontImageBytes2;
  List<int>? rearImageBytes2;
  Uint8List? audioBytes2;
  final Completer<GoogleMapController> _controller = Completer();

  final recorder = FlutterSoundRecorder();
  bool _isRecording = false;
  int Verificado = 0;
  BitmapDescriptor destinationIcon = BitmapDescriptor.defaultMarker;
  LocationData? currentLocation;
  PermissionStatus? _permissionGranted;
  bool? _serviceEnabled;
  Location location = Location();
  StreamSubscription<LocationData>? listener;
  JsonParser? jsonParser;
  JsonAlertParser? jsonAlertParser;
  final Map<MarkerId, Marker> _markers = {};
  int recordCount = 0;
  int recordCount2 = 0;
  bool cambio = false;
  String? response;

  Future initRecorder() async {
    final status3 = await permission_handler.Permission.microphone.request();
    if (status3 != PermissionStatus.granted) {
      print('error en el permiso');
    }
    await recorder.openRecorder();
    recorder.setSubscriptionDuration(const Duration(milliseconds: 500));
  }

  void getAlerts() async {
    try {
      while (true) {
        var theUrl =
            Uri.https('wesafeoficial.000webhostapp.com', '/getAlertData.php');
        var res = await http.post(theUrl);
        var responsBody = res.body;
        response = responsBody;
        jsonAlertParser = JsonAlertParser(responsBody);
        recordCount2 = jsonAlertParser!.getRecordCount();

        if (recordCount2 != recordCount) {
          setState(
            () {
              print(
                  'ESTE ES UNOO $recordCount2 YYYYYYYY ESTE ES OTRO $recordCount');
              createMarker();
            },
          );
        }

        await Future.delayed(Duration(seconds: 5));
      }
    } catch (e) {
      print(e);
    }
  }

  void setCustomMarkerIcon() {
    BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(size: Size(10, 10)),
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
    setState(() {});

    listener = location.onLocationChanged.listen(
      (newloc) {
        currentLocation = newloc;
      },
    );
  }

  void inicia() {
    jsonParser = JsonParser(widget.getting);
    Verificado = jsonParser!.getVerificado();
  }

  @override
  void initState() {
    getAlerts();
    setCustomMarkerIcon();
    isEnabled();
    getCurrentLocation();
    initRecorder();
    super.initState();
    inicia();
  }

  @override
  void dispose() {
    listener?.cancel();
    recorder.closeRecorder();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawerEnableOpenDragGesture: false,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Verificado == 1
          ? Container(
              decoration: BoxDecoration(
                border: Border.all(),
                color: Color(0xff511262),
                borderRadius: BorderRadius.circular(15),
              ),
              margin: const EdgeInsets.all(10),
              width: 180,
              height: 70,
              child: MaterialButton(
                shape: BeveledRectangleBorder(
                    borderRadius: BorderRadius.circular(6.7)),
                onPressed: () async {
                  //DBSaving();
                  await _captureImages();
                  await _startRecording();
                  print('se presiona');
                },
                child: const Icon(
                  color: Color.fromARGB(255, 249, 5, 5),
                  Icons.warning_amber,
                  size: 50,
                ),
              ),
            )
          : Container(
              decoration: BoxDecoration(
                border: Border.all(),
                color: Color(0xff511262),
                borderRadius: BorderRadius.circular(15),
              ),
              margin: const EdgeInsets.all(10),
              width: 190,
              height: 70,
              child: MaterialButton(
                  shape: BeveledRectangleBorder(
                      borderRadius: BorderRadius.circular(6.7)),
                  onPressed: false ? () {} : null,
                  child: const Text(
                    'Debe verificar su cuenta para poder enviar alertas',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  )),
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
              return Builder(builder: (context) {
                return GoogleMap(
                  markers: markers,
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
              });
            }
          },
        ),
      ),
      drawer: LateralBar(
        getting: widget.getting,
        jsonAlertParser: response,
      ),
    );
  }

  LocationData convertStringToLocation(int index) {
    // Eliminar los caracteres no deseados de la cadena de texto
    final cleanedString = jsonAlertParser!
        .getUbicacion(index)
        .replaceAll('LocationData<', '')
        .replaceAll('>', '')
        .replaceAll('lat: ', '')
        .replaceAll('long: ', '');

    // Dividir la cadena en latitud y longitud
    final coordinates = cleanedString.split(',');

    // Obtener los valores de latitud y longitud
    final latitude = double.parse(coordinates[0].trim());
    final longitude = double.parse(coordinates[1].trim());

    // Crear un nuevo objeto LocationData con los valores extraídos
    final locationData = LocationData.fromMap({
      'latitude': latitude,
      'longitude': longitude,
    });

    return locationData;
  }

  Set<Marker> get markers => _markers.values.toSet();

  void createMarker() {
    _markers.clear();

    if (jsonAlertParser != null) {
      final markerId = MarkerId(_markers.length.toString());

      recordCount = jsonAlertParser?.getRecordCount() ?? 0;
      print('ESTE ES EL RECORD COUNT $recordCount');

      for (var i = 0; i < recordCount; i++) {
        print('esta es la i: $i');
        final marcador = Marker(
          markerId: MarkerId('${jsonAlertParser?.getIdAlerta(i)}'),
          position: LatLng(
            convertStringToLocation(i).latitude!,
            convertStringToLocation(i).longitude!,
          ),
          icon: destinationIcon,
        );
        setState(() {
          print('${jsonAlertParser?.getIdAlerta(i)}');
          _markers[MarkerId('${jsonAlertParser?.getIdAlerta(i)}')] = marcador;
          print('ESTE el largo de markers ${_markers.length}');
        });
      }
    }
  }

  Future<void> _captureImages() async {
    // Inicializar la cámara
    final cameras = await availableCameras();
    final camera = cameras.first;
    final camera2 = cameras.last;

    // Iniciar la cámara
    final cameraController = CameraController(
      camera,
      ResolutionPreset.medium,
    );

    final cameraController2 = CameraController(
      camera2,
      ResolutionPreset.medium,
    );
    await cameraController.initialize();
    await cameraController2.initialize();

    // Tomar la foto de la cámara frontal
    final frontImagePath = await cameraController.takePicture();
    // Tomar la foto de la cámara trasera
    final rearImagePath = await cameraController2.takePicture();

    // Convertir las imágenes a bytes
    List<int> frontImageBytes = await frontImagePath.readAsBytes();
    List<int> rearImageBytes = await rearImagePath.readAsBytes();
    // Guardar las imágenes en la base de datos
    frontImageBytes2 = frontImageBytes;
    rearImageBytes2 = rearImageBytes;

    print('FOTO 1111111111111111111111111111111 $frontImageBytes2');
    print('FOTO 2222222222222222222222222222222 $rearImageBytes2');

    ///await guardar las fotos();

    await cameraController.dispose();
    await cameraController2.dispose();
  }

  Future<void> _startRecording() async {
    try {
      await recorder.startRecorder(toFile: 'audio');
      _isRecording = true;
      Timer(Duration(seconds: 5), () {
        if (_isRecording) {
          _stopRecording();
        }
      });
    } catch (e) {
      print('PUTAMADRE ${e}');
    }
  }

  Future<void> _stopRecording() async {
    try {
      final filePath = await recorder.stopRecorder();
      final file = File(filePath!);
      final audioBytes = await file.readAsBytes();
      print('AUDIOOOOOOOOOOOOOOOOOOOOO $audioBytes');
      audioBytes2 = audioBytes;
      // Aquí puedes guardar los bytes del audio en la base de datos
      DBSaving();
    } catch (e) {
      print(e);
    }
  }

  DBSaving() async {
    try {
      var theUrl =
          Uri.https('wesafeoficial.000webhostapp.com', '/newAlert.php');
      var res = await http.post(theUrl, body: {
        'ubi': '$currentLocation',
        'fecha': '${DateTime.now()}',
        'estado': '1',
        'usuario': '${jsonParser?.getUsuario()}',
        'imagenF': '$frontImageBytes2',
        'imagenT': '$rearImageBytes2',
        'audio': '$audioBytes2',
      });
      print(res.body);

      var responsBody = json.decode(res.body);
    } catch (e) {
      print('Error ${e}');
    }
  }
}
