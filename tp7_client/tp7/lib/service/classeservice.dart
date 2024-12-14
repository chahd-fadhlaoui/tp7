import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tp7/entities/classe.dart';

class ClasseService {
  static const String baseUrl = "http://10.0.2.2:8081/class";

  static Future<List<Classe>> getAllClasses() async {
    final response = await http.get(Uri.parse("$baseUrl/all"));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return List<Classe>.from(
          data.map((classeJson) => Classe.fromJson(classeJson)));
    } else {
      throw Exception('Failed to load classes');
    }
  }

  static Future<void> deleteClass(int id) async {
    final response = await http.delete(Uri.parse("$baseUrl/delete?id=$id"));
    if (response.statusCode != 200) {
      throw Exception('Failed to delete class');
    }
  }

  static Future<String> addClass(Classe classe) async {
    final response = await http.post(
      Uri.parse("$baseUrl/add"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(classe.toJson()),
    );
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to add class');
    }
  }

  static Future<String> updateClasse(Classe classe) async {
    final response = await http.put(
      Uri.parse("$baseUrl/update"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(classe.toJson()),
    );
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to update class');
    }
  }
}
