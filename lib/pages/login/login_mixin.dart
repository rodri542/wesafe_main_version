import 'package:flutter/material.dart';

mixin LoginMixin {
  String? emailValidator(String? value) {
    value ??= '';
    final isValid = RegExp(
          r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?",
        ).hasMatch(value) &&
        !value.contains(' ');

    if (isValid) {
      return null;
    }
    return 'Email Invalido';
  }

  String? passwordValidator(String? value) {
    value ??= '';

    final isValid = RegExp(
      r"^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[\W]).{8,}$",
    ).hasMatch(value);

    if (isValid) {
      return null;
    }
    return 'Contraseña Invalida';
  }

  String? phoneValidator(String? value) {
    value ??= '';

    final isValid = RegExp(
      r"\b\d{10}$",
    ).hasMatch(value);

    if (isValid) {
      return null;
    }
    return 'Teléfono Invalido';
  }

  String? namesValidator(String? value) {
    value ??= '';
    final isValid = value != null || value != '';
    if (isValid) {
      return null;
    }
    return 'Campo requerido';
  }
}
