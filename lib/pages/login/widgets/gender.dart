import 'package:flutter/material.dart';

List<String> list = <String>['Mujer', 'Hombre', 'Otro'];

class GenderSelection extends StatefulWidget {
  const GenderSelection({super.key});

  @override
  State<GenderSelection> createState() => _GenderSelectionState();
}

class _GenderSelectionState extends State<GenderSelection> {
  @override
  Widget build(BuildContext context) {
    String dropdownValue = list.first;

    return DropdownButton(
      hint: Text('SEXO'),
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
      value: dropdownValue,
      items: list.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      icon: Icon(
        Icons.arrow_downward,
        color: Colors.white,
      ),
      onChanged: (value) {
        setState(() {
          dropdownValue = value!;
          print(dropdownValue);
        });
      },
    );
  }
}
