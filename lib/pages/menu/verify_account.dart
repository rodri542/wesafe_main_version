import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

import '../../json_user.dart';

class VerifyAccountPage extends StatefulWidget {
  const VerifyAccountPage({super.key, required this.getting});
  final getting;

  @override
  State<VerifyAccountPage> createState() => _VerifyAccountPageState();
}

class _VerifyAccountPageState extends State<VerifyAccountPage> {
  File? image;

  JsonParser? jsonParser;

  void inicia() {
    jsonParser = JsonParser(widget.getting);
  }

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemporary = File(image.path);
      setState(() {
        this.image = imageTemporary;
      });
    } on PlatformException catch (e) {
      print('Fallo al elegir imagen $e');
    }
  }

  getMethod() async {
    try {
      var theUrl = Uri.https('wesafeoficial.000webhostapp.com', '/singup.php');
      var res = await http.post(theUrl, body: {
        'correo': "${jsonParser?.getCorreo()}",
        'identificacion': '$image',
      });
      var responsBody = res.body;
      print('Guardado');
    } catch (e) {}
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Verificar Cuenta',
          style: TextStyle(
            color: Color(0xffB17A50),
            fontSize: 40,
          ),
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding:
            const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            const Text(
              'Para solicitar la verificación de la cuenta se requiere una identificación oficial.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 30,
              ),
            ),
            const SizedBox(height: 25),
            SizedBox(
              height: 330,
              width: 400,
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  Container(
                    height: 300,
                    width: 400,
                    padding: const EdgeInsets.only(
                        top: 30, left: 20, right: 20, bottom: 20),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black45,
                        width: 1,
                      ),
                      color: Colors.black12,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: image == null
                        ? IconButton(
                            onPressed: () {
                              pickImage();
                            },
                            icon: const Icon(
                              Icons.cloud_upload,
                            ),
                            iconSize: 120,
                          )
                        : Image.file(image!),
                  ),
                  Positioned(
                    bottom: 0,
                    child: SizedBox(
                      width: 200,
                      child: ElevatedButton(
                        onPressed: () {
                          //aqui se guarda la imagen que seleccionas
                        },
                        child: const Text(
                          'Solicitar verifiación',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
