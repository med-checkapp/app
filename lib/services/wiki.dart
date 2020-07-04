import 'dart:convert';

import 'package:check_app/constants.dart';
import 'package:check_app/models/wiki.dart';
import 'package:http/http.dart' as http;

Future<Wiki> getWikiById(String wikiId) async {
  Uri uri = Uri.http(serverUrl, "/wikis/$wikiId");
  final response = await http.get(uri);

  if (response.statusCode == 200) {
    return Wiki.fromJson(json.decode(response.body)["wiki"]);
  } else {
    throw Exception('Failed to request Disease');
  }
}
