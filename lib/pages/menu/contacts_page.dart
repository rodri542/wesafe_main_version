import 'package:flutter/material.dart';
import 'package:wesafe_main_version/pages/menu/widgets/show_contacts.dart';
import 'package:wesafe_main_version/routes/routes.dart';

class ContactsPage extends StatefulWidget {
  const ContactsPage({super.key, required this.getting});
  final getting;

  @override
  State<ContactsPage> createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  int? _contacts = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Contactos',
          style: TextStyle(
            color: Color(0xffB17A50),
            fontSize: 45,
          ),
        ),
        centerTitle: true,
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
                    child: ListView.builder(
                      itemCount: _contacts,
                      itemBuilder: (BuildContext context, int index) {
                        return ShowContacts();
                      },
                    )),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, Routes.addContactPage);
                },
                child: const Text('Agregar Usuario'),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
