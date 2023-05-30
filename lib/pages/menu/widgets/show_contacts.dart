import 'package:flutter/material.dart';

class ShowContacts extends StatefulWidget {
  const ShowContacts({super.key});

  @override
  State<ShowContacts> createState() => _ShowContactsState();
}

class _ShowContactsState extends State<ShowContacts> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      height: 70,
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
                  Text('Nombre: Pedro'),
                  SizedBox(height: 10),
                  Text('Usuario: 3'),
                ],
              ),
            ),
          ),
          IconButton(
            icon: const Icon(
              Icons.cancel,
              size: 30,
            ),
            onPressed: () {
              //Aqui se elimina el usuario
            },
          ),
        ],
      ),
    );
  }
}
