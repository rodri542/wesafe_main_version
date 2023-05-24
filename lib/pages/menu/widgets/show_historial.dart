import 'package:flutter/material.dart';

class ShowHistorial extends StatefulWidget {
  const ShowHistorial({super.key});

  @override
  State<ShowHistorial> createState() => _ShowHistorialState();
}

class _ShowHistorialState extends State<ShowHistorial> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      height: 120,
      width: 70,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(),
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Fecha: ',
                    textAlign: TextAlign.start,
                  ),
                  SizedBox(height: 10),
                  Text('Hora: ', textAlign: TextAlign.start),
                  SizedBox(height: 10),
                  Text('Ubicación: '),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
