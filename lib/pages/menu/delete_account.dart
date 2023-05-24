import 'package:flutter/material.dart';

class DeleteAcountPage extends StatefulWidget {
  const DeleteAcountPage({super.key});

  @override
  State<DeleteAcountPage> createState() => _DeleteAcountPageState();
}

class _DeleteAcountPageState extends State<DeleteAcountPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Eliminar Cuenta',
          style: TextStyle(
            color: Color(0xffB17A50),
            fontSize: 40,
          ),
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding:
            const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            const Text(
              'Si elimina la cuenta no se podrá revertir esta acción.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 30,
              ),
            ),
            const SizedBox(height: 35),
            SizedBox(
              height: 230,
              width: 400,
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  Container(
                    height: 200,
                    width: 400,
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
                    child: const Text(
                      'Estimado usuario ¿Está seguro de que quiere eliminar su cuenta?',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 30,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    child: SizedBox(
                      width: 300,
                      child: ElevatedButton(
                        onPressed: () {
                         // showDialog(context: context, builder: (context) {
                         //   return Text('Aceptado');
                         // },);
                          //Aqui se elimina la cuenta
                        },
                        child: const Text(
                          'Sí, deseo eliminarla',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
