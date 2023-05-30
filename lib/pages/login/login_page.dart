import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:wesafe_main_version/pages/login/login_mixin.dart';
import 'package:wesafe_main_version/pages/login/widgets/login_text_field.dart';

import '../../routes/routes.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({
    super.key,
  });

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with LoginMixin {
  String _email = '', _password = '';
  bool? invalid;

  getMethod() async {
    try {
      var theUrl = Uri.https('wesafeoficial.000webhostapp.com', '/login.php');
      var res = await http.post(theUrl, body: {
        'contrasena': _password,
        'correo': _email,
      });
      invalid = false;
      var responsBody = res.body;
      print('valido');

      Navigator.pushNamed(context, Routes.mainPage, arguments: responsBody);
    } catch (e) {
      invalid = true;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    bool alowSubmit = emailValidator(_email) == null;
    if (alowSubmit) {
      alowSubmit = passwordValidator(_password) == null;
    }

    return Form(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Container(
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
                      )
                    ],
                  ),
                ),
                Flexible(
                  child: Container(
                    padding:
                        const EdgeInsets.only(top: 30, left: 20, right: 20),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black45,
                        width: 1,
                      ),
                      color: Colors.black12,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: ListView(
                      ///Aqui para ver como se mueva
                      physics: ScrollPhysics(),
                      children: [
                        LoginTextField(
                          msg:
                              'El email debe contener @ y tener un formato normal',
                          label: 'Email',
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
                        const SizedBox(height: 30),
                        Builder(
                          builder: (context) {
                            return LoginTextField(
                              msg:
                                  'La contraseña debe tener almenos 8 caracteres, una letra mayuscula, un numero y un caracter especial',
                              textInputAction: TextInputAction.send,
                              label: 'Contraseña',
                              onChanged: (value) {
                                setState(() {
                                  _password = value.trim();
                                });
                              },
                              onFieldSubmitted: (_) => _submit(context),
                              obscureText: true,
                              validator: passwordValidator,
                            );
                          },
                        ),
                        const SizedBox(height: 30),
                        Builder(
                          builder: (context) {
                            return ElevatedButton(
                              onPressed: alowSubmit
                                  ? () {
                                      _submit(context);
                                    }
                                  : null,
                              child: const Text('Ingresar'),
                            );
                          },
                        ),
                        if (invalid != true)
                          Text('')
                        else
                          const Text(
                            'Correo y/o Contraseña incorrecta',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 20,
                            ),
                          ),
                        const SizedBox(height: 30),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, Routes.resetPassword);
                          },
                          child: const Text(
                            '¿Olvidaste tu contraseña?',
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, Routes.singUpPage);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        '¿No tienes cuenta? ',
                        style: TextStyle(color: Color(0xffB17A50)),
                      ),
                      Text(
                        'Registrate',
                        style: TextStyle(
                          decoration: TextDecoration.underline,
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
    getMethod();
    if (invalid == false) {
    } else {
      print('invalido');
    }
  }
}
