import 'dart:io';
import 'dart:typed_data';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import '../../json_alert.dart';
import '../../json_user.dart';

class HistorialPage extends StatefulWidget {
  const HistorialPage({
    super.key,
    required this.getting,
  });
  final getting;

  @override
  State<HistorialPage> createState() => _HistorialPageState();
}

class _HistorialPageState extends State<HistorialPage> {
  int? _contacts = 1;
  JsonAlertParser? jsonAlertParser;
  JsonParser? jsonParser;

  void inicia() {
    jsonParser = JsonParser(widget.getting);
    getAlerts();
  }

  void getAlerts() async {
    try {
      var theUrl =
          Uri.https('wesafeoficial.000webhostapp.com', '/getUsrAlert.php');
      var res = await http.post(theUrl, body: {
        'usuario': '${jsonParser?.getUsuario()}',
      });
      var responsBody = res.body;
      jsonAlertParser = JsonAlertParser(responsBody);
    } catch (e) {
      print(e);
    }
  }

  void DesactivateAlert(int index) async {
    try {
      var theUrl =
          Uri.https('wesafeoficial.000webhostapp.com', '/deactivateAlert.php');
      var res = await http.post(theUrl, body: {
        'idAlerta': '${jsonAlertParser!.getIdAlerta(index)}',
      });
      var responsBody = res.body;
      print('$responsBody');
      setState(() {
        
      });

    } catch (e) {
      print(e);
    }
  }

  String formatDate(String dateTimeString) {
    print(dateTimeString);
    // Parsear la cadena de texto a un objeto DateTime
    DateTime dateTime = DateTime.parse(dateTimeString);

    // Obtener los componentes de la fecha y hora
    int hour = dateTime.hour;
    int day = dateTime.day;
    int month = dateTime.month;
    int year = dateTime.year;

    // Obtener el nombre del mes a partir del número del mes
    List<String> monthNames = [
      '', // Dejar el primer elemento vacío para coincidir con el índice de los meses (enero = 1)
      'enero', 'febrero', 'marzo', 'abril', 'mayo', 'junio',
      'julio', 'agosto', 'septiembre', 'octubre', 'noviembre', 'diciembre'
    ];
    String monthName = monthNames[month];

    // Construir la cadena de texto formateada
    String formattedDate =
        ' $day de $monthName de $year,\n Hora de activación: $hour:00';

    return formattedDate;
  }

  @override
  void initState() {
    inicia();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Historial',
          style: TextStyle(
            color: Color(0xffB17A50),
            fontSize: 45,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          padding:
              const EdgeInsets.only(top: 15, left: 15, right: 15, bottom: 20),
          child: Column(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.only(top: 30, left: 20, right: 20),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black45,
                      width: 1,
                    ),
                    color: Colors.black12,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: RefreshIndicator(
                    onRefresh: () async {
                      if (jsonAlertParser != null) {
                        setState(() {
                          _contacts = jsonAlertParser!.getRecordCount();
                        });
                      }
                    },
                    child: ListView.builder(
                      itemCount: _contacts,
                      itemBuilder: (BuildContext context, int index) {
                        return SizedBox(
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 20),
                            width: 70,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(),
                            ),
                            child: Stack(
                              children: [
                                Container(
                                  height: 460,
                                  width: double.infinity,
                                  child: Container(
                                    padding: EdgeInsets.all(10),
                                    color: Colors.white,
                                    alignment: Alignment.centerLeft,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Usuario: ${jsonParser!.getNombre()}',
                                          textAlign: TextAlign.start,
                                        ),
                                        const SizedBox(height: 10),
                                        jsonAlertParser != null
                                            ? Text(
                                                'Fecha: ${formatDate(jsonAlertParser!.getFecha(index))}',
                                                textAlign: TextAlign.start,
                                              )
                                            : Text(''),
                                        const SizedBox(height: 10),
                                        jsonAlertParser != null
                                            ? Text(
                                                'Ubicación: ${jsonAlertParser?.getUbicacion(index)}')
                                            : Text(''),
                                        const SizedBox(height: 10),
                                        jsonAlertParser != null
                                            ? imagenes(jsonAlertParser!
                                                .getImagenFrontal(index))
                                            : Text(''),
                                        const SizedBox(height: 10),
                                        jsonAlertParser != null
                                            ? imagenes(jsonAlertParser!
                                                .getImagenTrasera(index))
                                            : Text(''),
                                        jsonAlertParser != null
                                            ? audio(jsonAlertParser!
                                                .getAudio(index))
                                            : Text(''),
                                      ],
                                    ),
                                  ),
                                ),
                                Positioned(
                                    top: 3,
                                    right: 3,
                                    child: IconButton(
                                        onPressed:
                                            jsonAlertParser?.getEstado(index) ==
                                                    '1'
                                                ? () {
                                                    DesactivateAlert(index);
                                                  }
                                                : null,
                                        icon: Icon(Icons.health_and_safety)))
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  imagenes(String foto) {
    List<int> bytes = foto
        .replaceAll('[', '') // Eliminar el corchete de apertura
        .replaceAll(']', '') // Eliminar el corchete de cierre
        .split(', ') // Separar los valores por coma y espacio
        .map<int>((value) => int.parse(value)) // Convertir cada valor a entero
        .toList();

    Uint8List byteData = Uint8List.fromList(bytes);
    return Container(
      height: 100,
      alignment: Alignment.center,
      child: Image.memory(byteData,
          fit: BoxFit.contain, alignment: Alignment.center),
    );
  }

  audio(String audio) {
    List<int> bytes = audio
        .replaceAll('[', '') // Eliminar el corchete de apertura
        .replaceAll(']', '') // Eliminar el corchete de cierre
        .split(', ') // Separar los valores por coma y espacio
        .map<int>((value) => int.parse(value)) // Convertir cada valor a entero
        .toList();

    Uint8List byteData = Uint8List.fromList(bytes);
    AudioPlayer audioPlayer = AudioPlayer();

    return Container(
      height: 100,
      alignment: Alignment.center,
      child: ElevatedButton(
        onPressed: () async {
          final tempDir = await getTemporaryDirectory();
          final tempPath = tempDir.path;
          final filePath = '$tempPath/audio.mp3';
          final file = await File(filePath).writeAsBytes(byteData);

          final Uint8List fileData = await file.readAsBytes();
          await audioPlayer.play(BytesSource(fileData));
          print('reproduciendo');
        },
        child: Text('Reproducir audio'),
      ),
    );
  }
}
