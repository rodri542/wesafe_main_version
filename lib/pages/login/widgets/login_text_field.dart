import 'package:flutter/material.dart';

class LoginTextField extends FormField<String> {
  LoginTextField({
    Key? key,
    required String label,
    TextInputAction? textInputAction,
    TextInputType? keyboardType,
    void Function(String)? onFieldSubmitted,
    bool obscureText = false,

    void Function(String)? onChanged,
    String? Function(String?)? validator,
  }) : super(
            validator: validator,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            key: key,
            builder: (state) {
              bool isOk = !state.hasError &&
                  state.value != null &&
                  state.value!.isNotEmpty;
              return TextFormField(
                textInputAction: textInputAction,
                validator: validator,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                onFieldSubmitted: onFieldSubmitted,
                obscureText: obscureText,
                keyboardType: keyboardType,
                onChanged: (text) {
                  state.didChange(text);
                  if (onChanged != null) {
                    onChanged(text);
                  }
                },
                decoration: InputDecoration(
                  label: Text(label),
                  suffixIcon: Icon(
                    Icons.check_circle,
                    color: isOk ? Colors.green : Colors.black38,
                  ),
                ),
              );
            });
}
