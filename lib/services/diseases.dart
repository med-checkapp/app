import 'package:check_app/models/diseases.dart';
import 'package:check_app/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<List<Disease>> fetchDisease(dynamic data) async {
  Map<String, String> parametros = {
    'sex': data['sexo'].toLowerCase(),
    'age': data['idade'].toString(),
  };
  Uri uri = Uri.http("$serverUrl:3000", "/profiling", parametros);
  final response = await http.get(uri);

  if (response.statusCode == 200)
    return json
        .decode(response.body)["diseases"]
        .map<Disease>((item) => Disease.fromJson(item))
        .toList();
  else
    throw Exception('Faild to request Disease');
}
