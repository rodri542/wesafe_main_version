import 'dart:math';
import 'package:flutter/material.dart';
import 'package:wesafe_main_version/pages/login/widgets/login_text_field.dart';
import '../../routes/routes.dart';
import 'login_mixin.dart';

class GetResetCodePage extends StatefulWidget {
  const GetResetCodePage(
      {super.key, required this.number, required this.email});
  final number;
  final email;

  @override
  State<GetResetCodePage> createState() => _GetResetCodePageState();
}

class _GetResetCodePageState extends State<GetResetCodePage> with LoginMixin {
  int? randomNumber;
  Random random = Random();
  bool alowSubmit = false;
  bool error = false;

  @override
  Widget build(BuildContext context) {
    if (randomNumber != null) {
      setState(() {
        alowSubmit = true;
      });
    } else {
      setState(() {
        alowSubmit = false;
      });
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
                  height: 225,
                  child: Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      Container(
                        height: 200,
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
                        child: LoginTextField(
                          msg: 'Ingrese el codigo que se envió a su correo',
                          label: 'Ingrese el codigo que se envió a su correo',
                          textInputAction: TextInputAction.next,
                          onChanged: (text) {
                            setState(
                              () {
                                randomNumber = int.tryParse(text);
                              },
                            );
                          },
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      error
                          ? const Positioned(
                              top: 140,
                              child: Text(
                                'El codigo es incorrecto',
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
                              onPressed: alowSubmit
                                  ? () {
                                      _submit(context);
                                    }
                                  : null,
                              child: const Text('Validar numero'),
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
    if (widget.number == randomNumber) {
      Navigator.pushReplacementNamed(context, Routes.changePasswordPage,
          arguments: widget.email);
    } else {
      setState(() {
        error = true;
      });
    }

    print('valido');
  }
}
