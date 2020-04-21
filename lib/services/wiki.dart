import 'package:check_app/models/diseases.dart';
import 'package:check_app/constants.dart';
import 'package:http/http.dart' as http;
import 'package:check_app/models/wiki.dart';
import 'dart:convert';

Future<Wiki> getWikiById(String wikiId) async {

  Uri uri = Uri.http("$serverUrl:3000", "/wikis/$wikiId");
  final response = await http.get(uri);

  print("\n\n ${response.body}\n\n");

  if (response.statusCode == 200)
    return Wiki.fromJson(json
        .decode(response.body)["wiki"]
    );
  else
    throw Exception('Faild to request Disease');
}
