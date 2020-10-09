import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:check_app/constants.dart';
import 'package:check_app/pages/wiki_web_view.dart';
import 'package:check_app/components/form.dart';

class Frax extends StatefulWidget {
  @override
  _FraxState createState() => _FraxState();
}

class _FraxState extends State<Frax> {
  @override
  void initState() {
    super.initState();
  }

  void onSubmitForm(Map<String, dynamic> result) {
    Navigator.push(
        context, MaterialPageRoute(builder: (ctx) => WikiWebView(result)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(), body: CustomForm(fraxFormFields, onSubmitForm));
  }
}
