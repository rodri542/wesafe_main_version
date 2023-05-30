import 'dart:convert';

class JsonParser {
  final String json;

  JsonParser(this.json);

  String getField(String fieldName) {
    List<Map<String, dynamic>> jsonList = jsonDecode(json).cast<Map<String, dynamic>>();
    Map<String, dynamic> jsonMap = jsonList.first;
    return jsonMap[fieldName].toString();
  }

 String getUsuario() {
    return getField("idUsuario_Princial");
  }

  String getNombre() {
    return getField("Nombre");
  }

  String getCorreo() {
    return getField("Correo");
  }

 String getApellidoPaterno() {
    return getField("Apellido_Paterno");
  }

  String getApellidoMaterno() {
    return getField("Apellido_Materno");
  }

  String getTelefono() {
    return getField("Telefono");
  }

  String getIdentificacion() {
    return getField("Identificacion");
  }

  int getVerificado() {
    return int.parse(getField("Verificado"));
  }

  String getGenero() {
    return getField("Genero");
  }

  int getEstado() {
    return int.parse(getField("Estado"));
  }

  String getFechaNacimiento() {
    return getField("Fecha_Nacimiento");
  }

  String getContrasena() {
    return getField("Contrasena");
  }

  int getAdministrador() {
    return int.parse(getField("Administrador"));
  }

  String getContactos() {
    return getField("Contactos");
  }

   String getFotoPerfil() {
    return getField("img_Perfil");
  }
}