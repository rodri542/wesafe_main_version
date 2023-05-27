import 'package:flutter/material.dart';
import 'package:wesafe_main_version/pages/login/widgets/login_text_field.dart';

import '../login/login_mixin.dart';

class AddContactPage extends StatefulWidget {
  const AddContactPage({super.key, this.getting});
    final getting;


  @override
  State<AddContactPage> createState() => _AddContactPageState();
}

class _AddContactPageState extends State<AddContactPage> with LoginMixin {
  String _name = '', _phone = '';
  bool alowSubmit = false;
  @override
  Widget build(BuildContext context) {
    if (_name != '') {
      alowSubmit = phoneValidator(_phone) == null;
    }

    return Form(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Contactos',
            style: TextStyle(
              color: Color(0xffB17A50),
              fontSize: 45,
            ),
          ),
        ),
        body: SafeArea(
          child: Container(
            height: double.infinity,
            width: double.infinity,
            padding:
                const EdgeInsets.only(top: 15, left: 15, right: 15, bottom: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('  Agregar contacto...',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Color(0xff511262),
                      fontSize: 25,
                    )),
                const SizedBox(height: 10),
                SizedBox(
                  height: 350,
                  child: Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      Container(
                        width: double.infinity,
                        height: 325,
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
                        child: Column(
                          children: [
                            LoginTextField(
                              msg: '',
                              label: 'Nombre',
                              validator: namesValidator,
                              onChanged: (text) {
                                setState(
                                  () {
                                    _name = text.trim();
                                  },
                                );
                              },
                            ),
                            const SizedBox(height: 30),
                            LoginTextField(
                              msg: '',
                              label: 'Teléfono',
                              validator: phoneValidator,
                              onChanged: (text) {
                                setState(
                                  () {
                                    _phone = text.trim();
                                  },
                                );
                              },
                            ),
                          ],
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
                              child: const Text(
                                'Guardar',
                                style: TextStyle(fontSize: 20),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  color: Colors.transparent,
                )
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
      ///aqui se agrega e usuario
      print('valido');
    } else {
      print('Invalido');
    }
  }
}
