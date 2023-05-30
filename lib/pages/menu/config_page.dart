import 'package:flutter/material.dart';
import 'package:wesafe_main_version/routes/routes.dart';

class ConfigurationPage extends StatelessWidget {
  const ConfigurationPage({super.key, required this.getting});
  final getting;

  @override
  Widget build(BuildContext context) {
    int? _historialNumber = 3;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Configuración',
          style: TextStyle(
            color: Color(0xffB17A50),
            fontSize: 40,
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
            children: [
              Expanded(
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  padding: const EdgeInsets.only(top: 30, left: 20, right: 20),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black45,
                      width: 1,
                    ),
                    color: Colors.black12,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          style: const ButtonStyle(
                            alignment: Alignment.centerLeft,
                            iconColor: MaterialStatePropertyAll(
                              Color(0xffB17A50),
                            ),
                          ),
                          onPressed: () {
                            Navigator.pushNamed(
                                context, Routes.verifyAccountPage,
                                arguments: getting);
                          },
                          icon: const Icon(
                            Icons.arrow_forward,
                            size: 30,
                            color: Color(0xffB17A50),
                          ),
                          label: const Text(
                            'Verificar Cuenta',
                            style: TextStyle(
                              fontSize: 25,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          style: const ButtonStyle(
                            alignment: Alignment.centerLeft,
                            iconColor: MaterialStatePropertyAll(
                              Color(0xffB17A50),
                            ),
                          ),
                          onPressed: () {
                            Navigator.pushNamed(
                                context, Routes.deleteAccountPage,
                                arguments: getting);
                          },
                          icon: const Icon(
                            Icons.arrow_forward,
                            size: 30,
                            color: Color(0xffB17A50),
                          ),
                          label: const Text(
                            'Eliminar Cuenta',
                            style: TextStyle(
                              fontSize: 25,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
