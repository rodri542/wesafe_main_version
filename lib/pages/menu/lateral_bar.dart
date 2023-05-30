import 'dart:math';
import 'package:flutter/material.dart';
import 'package:wesafe_main_version/pages/login/login_page.dart';
import '../../json_user.dart';
import '../../routes/routes.dart';

class LateralBar extends StatefulWidget {
  const LateralBar(
      {super.key, required this.getting, required this.jsonAlertParser});
  final getting;
  final jsonAlertParser;

  @override
  State<LateralBar> createState() => _LateralBarState();
}

class _LateralBarState extends State<LateralBar> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(0xff761a8d),
      width: 200,
      elevation: 50,
      child: SafeArea(
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    width: double.infinity,
                    height: 10,
                  ),
                  const Center(
                    child: Text(
                      'Menu',
                      style: TextStyle(
                        color: Color(0xffB17A50),
                        fontSize: 50,
                      ),
                    ),
                  ),
                  arrowButton(label: 'Perfil', ruta: Routes.profilePage),
                  arrowButton(label: 'Historial', ruta: Routes.historialPage),
                  arrowButton(label: 'Contactos', ruta: Routes.contactsPage),
                  arrowButton(label: 'Configuración', ruta: Routes.configPage),
                ],
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.popUntil(
                      context,
                      (route) => route.isFirst,
                    );
                    print(context);
                  },
                  icon: const Icon(
                    Icons.arrow_right_alt_outlined,
                    size: 30,
                  ),
                  label: const Text(
                    'Cerrar sesión',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  style: const ButtonStyle(
                    alignment: Alignment.centerLeft,
                    iconColor: MaterialStatePropertyAll(
                      Color(0xffB17A50),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  SizedBox arrowButton({
    required String label,
    required String ruta,
  }) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: () {
          Navigator.pushNamed(
            context,
            ruta,
            arguments: widget.getting,
          );
        },
        icon: const Icon(
          Icons.arrow_right_alt_outlined,
          size: 30,
        ),
        label: Text(
          label,
          style: const TextStyle(
            fontSize: 20,
          ),
        ),
        style: const ButtonStyle(
          alignment: Alignment.centerLeft,
          iconColor: MaterialStatePropertyAll(
            Color(0xffB17A50),
          ),
        ),
      ),
    );
  }
}
