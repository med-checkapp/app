import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomForm extends StatefulWidget {
  final Map<String, dynamic> formFields;
  final Function onSubmit;

  CustomForm(this.formFields, this.onSubmit);
  @override
  _FormState createState() => _FormState();
}

class _FormState extends State<CustomForm> {
  final Map<String, dynamic> _formValuesState = {};

  @override
  void initState() {
    super.initState();
    widget.formFields.forEach((key, value) {
      _formValuesState[key] = value["defaultValue"];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Expanded(child: _formBuilder()),
      RaisedButton(
        child: Text("Confirmar"),
        onPressed: () => widget.onSubmit(_formValuesState),
      )
    ]);
  }

  Widget _formBuilder() {
    return ListView(
      children: widget.formFields.entries
          .map((e) => _formFieldBuilder(e.value, e.key, _formValuesState[e.key],
                  (value, key) {
                setState(() {
                  _formValuesState[key] = value;
                });
              }))
          .toList(),
    );
  }

  Widget _formFieldBuilder(
      Map<String, dynamic> item, String key, dynamic value, Function onChange) {
    print(item);
    Widget widget;
    switch (item["type"]) {
      case "bool":
        widget = ListTile(
            title: Text(item["label"]),
            leading:
                Checkbox(value: value, onChanged: (val) => onChange(val, key)));
        break;
      case "text":
        widget = ListTile(
            title: TextField(
          onChanged: (val) => onChange(val, key),
          decoration: InputDecoration(hintText: item["label"]),
        ));
        break;
      case "select":
        widget = ListTile(
            leading: Text(item["label"]),
            title: DropdownButton(
              onChanged: (val) => onChange(val, key),
              value: value,
              items: item["options"]
                  .map<DropdownMenuItem<dynamic>>((option) => DropdownMenuItem(
                        child: Text(option["name"]),
                        value: option["value"],
                      ))
                  .toList(),
            ));
        break;
      default:
        widget = Container();
    }
    return widget;
  }
}
