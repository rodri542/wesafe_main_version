import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:wesafe_main_version/pages/login/widgets/login_text_field.dart';
import '../../routes/routes.dart';
import 'login_mixin.dart';

List<String> list = <String>['Mujer', 'Hombre', 'Otro'];

class SingUpPage extends StatefulWidget {
  const SingUpPage({super.key});

  @override
  State<SingUpPage> createState() => _SingUpPageState();
}

class _SingUpPageState extends State<SingUpPage> with LoginMixin {
  String _email = '',
      _password = '',
      _phone = '',
      _apellidoMaterno = '',
      _apellidoPaterno = '',
      _nombre = '';

  String? _equalpassword = '';
  String genero = list.last;
  DateTime? _birthday;

  getMethod() async {
    try {
      var theUrl = Uri.https('wesafeoficial.000webhostapp.com', '/singup.php');
      var res = await http.post(theUrl, body: {
        'nombre': '$_nombre',
        'apellidomaterno': '$_apellidoMaterno',
        'apellidopaterno': '$_apellidoPaterno',
        'numero': '$_phone',
        'genero': '$genero',
        'compleanos': '$_birthday',
        'contrasena': '$_password',
        'correo': "$_email",
      });
      var responsBody = res.body;
      print(res.body);
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    String dropdownValue = genero;
    bool result = false;

    if (_password == _equalpassword &&
        _equalpassword != null &&
        _nombre != '' &&
        _apellidoMaterno != '' &&
        _apellidoPaterno != '') {
      bool alowSubmit = emailValidator(_email) == null;

      if (alowSubmit) {
        alowSubmit = passwordValidator(_password) == null;
      }
      if (alowSubmit) {
        alowSubmit = phoneValidator(_phone) == null;
      }
      result = alowSubmit;
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
                  width: double.infinity,
                  height: double.infinity,
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
                    'Ingresa tus datos',
                    style: TextStyle(
                      fontSize: 20,
                      color: Color(0xff511262),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
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
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          LoginTextField(
                            initialValue: _email,
                            key: const Key('sexo'),
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
                          LoginTextField(
                            initialValue: _phone,
                            keyboardType: TextInputType.phone,
                            msg: 'El telefono debe contener almenos 10 digitos',
                            textInputAction: TextInputAction.next,
                            label: 'Teléfono',
                            onChanged: (value) {
                              setState(
                                () {
                                  _phone = value.trim();
                                },
                              );
                            },
                            validator: phoneValidator,
                          ),
                          const SizedBox(height: 30),
                          LoginTextField(
                            initialValue: _password,
                            msg:
                                'La contraseña debe tener almenos 8 caracteres, una letra mayuscula, un numero y un caracter especial',
                            textInputAction: TextInputAction.next,
                            label: 'Contraseña',
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
                          const SizedBox(height: 10),
                          LoginTextField(
                            initialValue: _nombre,
                            msg: '',
                            textInputAction: TextInputAction.next,
                            label: 'Nombre(s)',
                            onChanged: (value) {
                              setState(() {
                                _nombre = value.trim();
                              });
                            },
                            validator: namesValidator,
                          ),
                          const SizedBox(height: 30),
                          LoginTextField(
                            initialValue: _apellidoPaterno,
                            msg: '',
                            textInputAction: TextInputAction.send,
                            label: 'Apellido Paterno',
                            onChanged: (value) {
                              setState(() {
                                _apellidoPaterno = value.trim();
                              });
                            },
                            validator: namesValidator,
                          ),
                          const SizedBox(height: 30),
                          LoginTextField(
                            initialValue: _apellidoMaterno,
                            msg: '',
                            textInputAction: TextInputAction.send,
                            label: 'Apellido Materno',
                            onChanged: (value) {
                              setState(() {
                                _apellidoMaterno = value.trim();
                              });
                            },
                            validator: namesValidator,
                          ),
                          const SizedBox(height: 30),
                          const SizedBox(
                            width: double.infinity,
                            child: Text(
                              'Genero',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: Color(0xff511262),
                                fontSize: 26,
                              ),
                            ),
                          ),
                          const SizedBox(height: 5),
                          Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Color(0xff511262), //Color(0xff511262),
                            ),
                            child: DropdownButton(
                              underline: Container(
                                height: 2,
                                color: Colors.white,
                              ),
                              dropdownColor: Color(0xff511262),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                              elevation: 16,
                              key: ValueKey('ss'),
                              value: dropdownValue,
                              items: list.map<DropdownMenuItem<String>>(
                                  (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              icon: const Icon(
                                Icons.arrow_downward,
                                color: Colors.white,
                              ),
                              onChanged: (value) {
                                setState(() {
                                  genero = value!;

                                  print(genero);
                                });
                              },
                            ),
                          ),
                          const SizedBox(height: 30),
                          const SizedBox(
                            width: double.infinity,
                            child: Text(
                              'Fecha de nacimiento',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: Color(0xff511262),
                                fontSize: 26,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: Container(
                              child: ElevatedButton(
                                onPressed: _selectDate,
                                child: Text(
                                  textAlign: TextAlign.left,
                                  comparate(),
                                  style: const TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 50),
                        ],
                      ),
                    ),
                  ),
                ),
                Builder(
                  builder: (context) {
                    return ElevatedButton(
                      onPressed: result
                          ? () {
                              _submit(context);
                            }
                          : null,
                      child: const Text('Guardar'),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String comparate() {
    if (_birthday == null) {
      return 'Ingrese su fecha de nacimiento';
    } else {
      return '${_birthday?.day} / ${_birthday?.month} / ${_birthday?.year}';
    }
  }

  Future<void> _selectDate() async {
    final date = await showDatePicker(
      initialEntryMode: DatePickerEntryMode.calendar,
      helpText: null,
      locale: const Locale('es'),
      confirmText: 'Aceptar',
      cancelText: 'Cancelar',
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1970),
      lastDate: DateTime.now(),
    );
    if (date != null) {
      setState(() {
        _birthday = date;
      });
    }
  }

  void _submit(BuildContext context) {
    final formState = Form.of(context);

    if (formState.validate()) {
      getMethod();
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            alignment: Alignment.center,
            backgroundColor: Colors.white,
            title: const Text(
              'Registro exitoso',
              textAlign: TextAlign.center,
            ),
            content: Container(
              alignment: Alignment.center,
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: const Color(0xff511262),
              ),
              child: const Text(
                'Se registró tu cuenta con exito',
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
      print('valido');
    } else {
      print('Invalido');
    }
  }
}
