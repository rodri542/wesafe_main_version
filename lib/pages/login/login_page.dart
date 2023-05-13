import 'package:flutter/material.dart';
import 'package:wesafe_main_version/pages/login/login_mixin.dart';
import 'package:wesafe_main_version/pages/login/widgets/login_text_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with LoginMixin {
  String _email = '', _password = '';

  @override
  Widget build(BuildContext context) {
    bool alowSubmit = emailValidator(_email) == null;
    if (alowSubmit) {
      alowSubmit = passwordValidator(_password) == null;
    }

    return Form(
      child: Scaffold(
        body: SafeArea(
          child: ListView(
            padding: const EdgeInsets.all(15),
            children: [
              LoginTextField(
                label: 'Email',
                textInputAction: TextInputAction.next,
                onChanged: (text) {
                  setState(() {
                    _email = text.trim();
                  });
                },
                keyboardType: TextInputType.emailAddress,
                validator: emailValidator,
              ),
              const SizedBox(height: 30),
              Builder(builder: (context) {
                return LoginTextField(
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
              }),
              const SizedBox(height: 30),
              Builder(builder: (context) {
                return ElevatedButton(
                  onPressed: alowSubmit
                      ? () {
                          _submit(context);
                        }
                      : null,
                  child: const Text('Iniciar Sesion'),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  void _submit(BuildContext context) {
    final formState = Form.of(context);
    if (formState?.validate() ?? false) {
      print('valido');
      
    } else {
      print('Invalido');
    }

    ///checar credenciales aquí
  }
}
