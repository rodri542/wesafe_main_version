import 'package:flutter/material.dart';
import 'package:wesafe_main_version/pages/login/widgets/login_text_field.dart';

import '../../routes/routes.dart';
import 'login_mixin.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> with LoginMixin {
  String _email = '';

  @override
  Widget build(BuildContext context) {
    bool alowSubmit = emailValidator(_email) == null;

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
                          msg:
                              'El email debe contener @ y tener un formato normal',
                          label: 'Ingrese su correo electronico:',
                          textInputAction: TextInputAction.next,
                          onChanged: (text) {
                            setState(
                              () {
                                _email = text.trim();
                              },
                            );
                          },
                          keyboardType: TextInputType.emailAddress,
                          validator: emailValidator,
                        ),
                      ),
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
                              child: const Text('Enviar'),
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
    final formState = Form.of(context);
    if (formState.validate() ) {
      Navigator.maybePop(context, Routes.mainPage);
      print('valido');
    } else {
      print('Invalido');
    }
  }
}
