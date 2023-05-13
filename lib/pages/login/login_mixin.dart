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
        ).hasMatch(value) &&
        !value.contains(' ');

    if (isValid) {
      return null;
    }
    return 'Contraseña Invalida';
  }
}
