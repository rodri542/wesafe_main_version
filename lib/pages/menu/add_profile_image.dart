import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import '../../json_user.dart';

class ProfileImagePage extends StatefulWidget {
  const ProfileImagePage({super.key, required this.getting});
  final getting;

  @override
  State<ProfileImagePage> createState() => _ProfileImagePageState();
}

class _ProfileImagePageState extends State<ProfileImagePage> {
  File? image;
  List<int>? frontImageBytes2;
  int Verificado = 0;
  bool active = false;

  JsonParser? jsonParser;

  void inicia() {
    jsonParser = JsonParser(widget.getting);
    Verificado = jsonParser!.getVerificado();
    print(Verificado);
  }

  DBSaving() async {
    print('${jsonParser?.getUsuario()}');
    try {
      var theUrl =
          Uri.https('wesafeoficial.000webhostapp.com', '/addProfileImage.php');
      var res = await http.post(theUrl, body: {
        'usuario': '${jsonParser?.getUsuario()}',
        'imagenF': '$frontImageBytes2',
      });

      Navigator.pop(context, frontImageBytes2);

      var responsBody = json.decode(res.body);
      print(res);
      setState(() {});
    } catch (e) {
      print('Error ${e}');
    }
  }

  @override
  void initState() {
    inicia();

    super.initState();
  }

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);
      if (image == null) return;
      final imageTemporary = File(image.path);
      List<int> frontImageBytes = await imageTemporary.readAsBytes();
      frontImageBytes2 = frontImageBytes;

      setState(() {
        this.image = imageTemporary;
        if (image != null) {
          active = true;
        }
      });
    } on PlatformException catch (e) {
      print('Fallo al elegir imagen $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Foto de perfil',
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
            Text(
              'Tomate una foto para tu perfil ${jsonParser?.getNombre()}!',
              textAlign: TextAlign.left,
              style: const TextStyle(
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
                        onPressed: active
                            ? () {
                                if (image != null) {
                                  DBSaving();
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        alignment: Alignment.center,
                                        backgroundColor: Colors.white,
                                        title: const Text(
                                          'Se actualizó tu foto de perfil',
                                          textAlign: TextAlign.center,
                                        ),
                                        content: Container(
                                          alignment: Alignment.center,
                                          height: 40,
                                          width: 40,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: const Color(0xff511262),
                                          ),
                                          child: const Text(
                                            'Se actualizó tu foto con exito',
                                            textAlign: TextAlign.center,
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                        actions: [
                                          Center(
                                            child: ElevatedButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: const Text('Ok',
                                                  style: TextStyle()),
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                }
                              }
                            : null,
                        child: const Text(
                          'Subir foto de perfil',
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
