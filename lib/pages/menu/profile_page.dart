import 'package:flutter/material.dart';
import 'package:wesafe_main_version/pages/login/widgets/profile_text_field.dart';
import '../../json_user.dart';
import '../login/login_mixin.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key, required this.getting});
    final getting;


  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> with LoginMixin {
  bool modifyactivate = false;
  String _email = '',
      _emailM = '',
      _password = '',
      _passwordM = '',
      _phone = '',
      _phoneM = '',
      _apellidoMaterno = '',
      _apellidoPaterno = '',
      _nombre = '',
      _gender = '',
      _age = '';

  JsonParser? jsonParser;

  void inicia() {
    jsonParser = JsonParser(widget.getting);
  }

  void download() {
    _email= jsonParser!.getCorreo();
    _nombre= jsonParser!.getNombre();
    _apellidoPaterno= jsonParser!.getApellidoPaterno();
    _apellidoMaterno= jsonParser!.getApellidoMaterno();
    _phone= jsonParser!.getTelefono();
    _age= jsonParser!.getFechaNacimiento();
    _gender= jsonParser!.getGenero();
    _password = jsonParser!.getContrasena();
  }

  @override
  void initState() {
    super.initState();
    inicia();
        download();

  }

  @override
  Widget build(BuildContext context) {
    bool alowSubmit = emailValidator(_emailM) == null;

    if (alowSubmit) {
      alowSubmit = passwordValidator(_passwordM) == null;
    }
    if (alowSubmit) {
      alowSubmit = phoneValidator(_phoneM) == null;
    }

    return Form(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text(
            'Perfil',
            style: TextStyle(
              color: Color(0xffB17A50),
              fontSize: 50,
            ),
          ),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {
                setState(() {
                  if (modifyactivate == false) {
                    modifyactivate = true;
                    _emailM = _email;
                    _passwordM = _password;
                    _phoneM = _phone;
                  } else {
                    modifyactivate = false;
                  }
                });
              },
              icon: const Icon(
                Icons.edit,
                size: 30,
                color: Color(0xffB17A50),
              ),
            )
          ],
        ),
        body: SafeArea(
          child: Container(
            height: double.infinity,
            width: double.infinity,
            padding:
                const EdgeInsets.only(top: 15, left: 15, right: 15, bottom: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: double.infinity,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          width: 180,
                        ),
                        Container(
                          color: Colors.grey,
                          child: const Icon(
                            Icons.add_a_photo,
                            size: 100,
                          ),
                        ),
                        const SizedBox(
                          width: 40,
                        ),
                        Container(
                          color: Colors.grey,
                          child: const Icon(
                            Icons.add_a_photo,
                            size: 100,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 25,
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
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          ProfileTextField(
                            modifyactivated: modifyactivate,
                            msg:
                                'El email debe contener @ y tener un formato normal',
                            label: 'Correo',
                            initialValue: _email,
                            validator: emailValidator,
                            onChanged: (value) {
                              setState(() {
                                _emailM = value.trim();
                              });
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          ProfileTextField(
                            modifyactivated: false,
                            msg: 'Prueba',
                            label: 'Nombre(s)',
                            initialValue: _nombre,
                            validator: namesValidator,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          ProfileTextField(
                            modifyactivated: false,
                            msg: 'Prueba',
                            label: 'Apellido Paterno',
                            initialValue: _apellidoPaterno,
                            validator: namesValidator,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          ProfileTextField(
                            modifyactivated: false,
                            msg: 'Prueba',
                            label: 'Apellido Materno',
                            initialValue: _apellidoMaterno,
                            validator: namesValidator,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          ProfileTextField(
                            modifyactivated: modifyactivate,
                            msg: 'El telefono debe contener almenos 10 digitos',
                            label: 'Teléfono',
                            initialValue: _phone,
                            validator: phoneValidator,
                            keyboardType: TextInputType.phone,
                            onChanged: (value) {
                              setState(() {
                                _phoneM = value.trim();
                              });
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          ProfileTextField(
                            modifyactivated: modifyactivate,
                            msg:
                                'La contraseña debe tener almenos 8 caracteres, una letra mayuscula, un numero y un caracter especial',
                            label: 'Contraseña',
                            obscureText: true,
                            initialValue: _password,
                            validator: passwordValidator,
                            onChanged: (value) {
                              setState(() {
                                _passwordM = value.trim();
                              });
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          ProfileTextField(
                            modifyactivated: false,
                            msg: 'Prueba',
                            label: 'Edad',
                            initialValue: _age,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          ProfileTextField(
                            modifyactivated: false,
                            msg: 'Prueba',
                            label: 'Gender',
                            initialValue: _gender,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                if (modifyactivate)
                  Builder(builder: (context) {
                    return ElevatedButton(
                      onPressed: alowSubmit
                          ? () {
                              setState(() {
                                _submit(context);
                              });
                            }
                          : null,
                      child: const Text('Guardar'),
                    );
                  })
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _submit(BuildContext context) {
    final formState = Form.of(context);

    if (formState.validate()) {
      setState(() {
        modifyactivate = false;
        _email = _emailM;
        _password = _passwordM;
        _phone = _phoneM;
      });

      print('valido');
    } else {
      modifyactivate = false;

      print('Invalido');
    }
  }
}
