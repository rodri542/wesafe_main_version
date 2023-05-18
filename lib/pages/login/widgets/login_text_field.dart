import 'package:flutter/material.dart';

class LoginTextField extends FormField<String> {
  LoginTextField({
    Key? key,
    required String msg,
    required String label,
    String? initialValue,
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
            return Builder(builder: (context) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: const TextStyle(
                      color: Color(0xff511262),
                      fontSize: 26,
                    ),
                  ),
                  Container(
                    height: 56,
                    padding: const EdgeInsets.only(left: 8),
                    decoration: const BoxDecoration(
                      color: Color(0xff511262),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.elliptical(65, 15),
                          bottomLeft: Radius.circular(5),
                          topRight: Radius.circular(5),
                          bottomRight: Radius.elliptical(19, 55)),
                    ),
                    child: TextFormField(
                      initialValue: initialValue,
                      textAlignVertical: TextAlignVertical.center,
                      style: const TextStyle(fontSize: 19),
                      autocorrect: false,
                      textAlign: TextAlign.left,
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
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5)),
                        contentPadding: EdgeInsets.all(5),
                        fillColor: Colors.white,
                        filled: true,
                        // label: Text(label),
                        suffixIcon: IconButton(
                          onPressed: () {
                            final snackBar = SnackBar(
                              content: Text(msg),
                              duration: const Duration(seconds: 3),
                              behavior: SnackBarBehavior.floating,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              elevation: 0,
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 100, vertical: 50),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 5),
                              backgroundColor: Color(0xff511262),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          },
                          icon: Icon(
                            Icons.check_circle,
                            color: isOk ? Colors.green : Colors.black38,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            });
          },
        );
}
