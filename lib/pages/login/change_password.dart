import 'package:flutter/material.dart';
import 'package:wesafe_main_version/pages/login/widgets/login_text_field.dart';
import 'package:http/http.dart' as http;
import '../../routes/routes.dart';
import 'login_mixin.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({
    super.key,
    required this.getting,
  });
  final getting;
  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage>
    with LoginMixin {
  bool error = false;
  String? responsBody;
  String? _equalpassword;
  String? _password;

  getMethod() async {
    try {
      var theUrl =
          Uri.https('wesafeoficial.000webhostapp.com', '/updateContrasena.php');
      var res = await http.post(theUrl, body: {
        'contrasena': _password,
        'correo': widget.getting,
      });
      setState(() {
        responsBody = res.body;
        if (responsBody != null) {
          if (responsBody!.contains('Se agrego correctamente')) {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  alignment: Alignment.center,
                  backgroundColor: Colors.white,
                  title: const Text(
                    'Cambio exitoso',
                    textAlign: TextAlign.center,
                  ),
                  content: Container(
                    alignment: Alignment.center,
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color(0xff511262),
                    ),
                    child: const Text(
                      'Se cambió su contraseña con exito',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  actions: [
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            Routes.loginPage,
                            (_) => false,
                          );
                        },
                        child: const Text('Ok', style: TextStyle()),
                      ),
                    ),
                  ],
                );
              },
            );
          } else {
            print('error');
          }
        }
      });
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    bool result = false;

    if (_password != null && _equalpassword != null) {
      bool alowSubmit = passwordValidator(_password) == null;

      if (alowSubmit) {
        alowSubmit = passwordValidator(_equalpassword) == null;
      }
      result = alowSubmit;
    }

    return Form(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Container(
            color: Colors.white,
            height: double.infinity,
            width: double.infinity,
            padding:
                const EdgeInsets.only(top: 15, left: 15, right: 15, bottom: 20),
            child: Column(
              children: [
                Container(
                  alignment: Alignment.center,
                  color: Colors.transparent,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ClipRRect(
                          borderRadius: BorderRadius.circular(7),
                          child: Image.asset(
                            'assets/logo/weSafelogo.jpg',
                            width: 55,
                          )),
                      const SizedBox(width: 10),
                      const Text(
                        'weSafe',
                        // textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xffB17A50),
                          fontSize: 70,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                const Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Recuperación de contraseña...',
                    style: TextStyle(
                      fontSize: 20,
                      color: Color(0xff511262),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 325,
                  child: Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      Container(
                        height: 300,
                        padding: const EdgeInsets.only(
                            top: 20, left: 20, right: 20, bottom: 30),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black45,
                            width: 1,
                          ),
                          color: Colors.black12,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Column(
                          children: [
                            LoginTextField(
                              initialValue: _password,
                              msg:
                                  'La contraseña debe tener almenos 8 caracteres, una letra mayuscula, un numero y un caracter especial',
                              textInputAction: TextInputAction.next,
                              label: 'Nueva Contraseña',
                              onChanged: (value) {
                                setState(() {
                                  _password = value.trim();
                                });
                              },
                              obscureText: true,
                              validator: passwordValidator,
                            ),
                            const SizedBox(height: 30),
                            LoginTextField(
                              initialValue: _equalpassword,
                              msg:
                                  'La contraseña debe tener almenos 8 caracteres, una letra mayuscula, un numero y un caracter especial',
                              label: 'Repite tu Contraseña',
                              textInputAction: TextInputAction.next,
                              onChanged: (value) {
                                setState(() {
                                  _equalpassword = value.trim();
                                });
                              },
                              obscureText: true,
                              validator: passwordValidator,
                            ),
                          ],
                        ),
                      ),
                      error
                          ? const Positioned(
                              top: 230,
                              child: Text(
                                'Los campos no coinciden',
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 20,
                                ),
                              ))
                          : const Text(''),
                      Positioned(
                        bottom: 0,
                        child: Builder(
                          builder: (context) {
                            return ElevatedButton(
                              onPressed: result
                                  ? () {
                                      _submit(context);
                                    }
                                  : null,
                              child: const Text('Cambiar contraseña'),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _submit(BuildContext context) {
    if (_password == _equalpassword) {
      getMethod();
    } else {
      setState(() {
        error = true;
      });
    }
  }
}
