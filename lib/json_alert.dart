import 'dart:convert';

class JsonAlertParser {
  final String json;

  JsonAlertParser(this.json);

  List<Map<String, dynamic>> getJsonList() {
    return jsonDecode(json).cast<Map<String, dynamic>>();
  }

  int getRecordCount() {
    List<Map<String, dynamic>> jsonList = getJsonList();
    return jsonList.length;
  }

  String getField(int index, String fieldName) {
    List<Map<String, dynamic>> jsonList = getJsonList();
    if (index >= 0 && index < jsonList.length) {
      Map<String, dynamic> jsonMap = jsonList[index];
      return jsonMap[fieldName].toString();
    }
    return '';
  }

  String getIdAlerta(int index) {
    return getField(index, "idAlerta");
  }

  String getUsuario(int index) {
    return getField(index, "Usuario_Princial_idUsuario_Princial");
  }

  String getEstado(int index) {
    return getField(index, "Estado");
  }

  String getFecha(int index) {
    return getField(index, "Fecha");
  }

  String getUbicacion(int index) {
    return getField(index, "Ubicacion");
  }

  String getImagenFrontal(int index) {
    return getField(index, "imagenFrontal");
  }

  String getImagenTrasera(int index) {
    return getField(index, "imagenTrasera");
  }

  String getAudio(int index) {
    return getField(index, "audio");
  }
}
