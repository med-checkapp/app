import 'dart:convert';
import 'package:check_app/constants.dart';
import 'package:check_app/models/diseases.dart';
import 'package:http/http.dart' as http;

Future<List<Disease>> getDiseasesByProfileTarget(
    {String sex, String age}) async {
  Map<String, String> params = {
    'sex': sex.toLowerCase(),
    'age': age,
  };
  Uri uri = Uri.http(serverUrl, "/profiling", params);
  final response = await http.get(uri);

  if (response.statusCode == 200) {
    return json
        .decode(response.body)["diseases"]
        .map<Disease>((item) => Disease.fromJson(item))
        .toList();
  } else
    throw Exception('Faild to request Disease');
}
