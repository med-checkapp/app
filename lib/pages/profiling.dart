import 'package:check_app/Notifiers/profiling_state.dart';
import 'package:check_app/config_size.dart';
import 'package:check_app/constants.dart';
import 'package:check_app/models/diseases.dart';
import 'package:check_app/services/diseases.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

class Profiling extends StatefulWidget {
  @override
  _ProfilingState createState() => _ProfilingState();
}

class _ProfilingState extends State<Profiling> {
  int _idade;
  String _sexo;
  final _idadeController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _autovalidar = false;
  Future<List<Disease>> futureDisease;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    super.dispose();
  }

  dynamic validate(int idade, String sexo) {
    if (idade == null || idade < 0 || idade > 120) {
      return {
        "isValid": false,
        "reason": "Idade precisa ser um número entre 0 e 120"
      };
    }
    if (sexo != 'Masculino' && sexo != 'Feminino') {
      return {"isValid": false, "reason": "Sexo inválido"};
    }

    return {"isValid": true, "reason": ""};
  }

  void preenchaIdade(BuildContext context, String value) {
    _autovalidar = true;
    if (value == "") {
      Provider.of<ProfilingState>(context, listen: false).clearAge();
    } else if (!Provider.of<ProfilingState>(context, listen: false).idade) {
      Provider.of<ProfilingState>(context, listen: false).fillAge();
    }
  }

  void clearNotifier(BuildContext context) {
    setState(() {
      Provider.of<ProfilingState>(context, listen: false).clearAge();
      Provider.of<ProfilingState>(context, listen: false).clearSex();
      _sexo = null;
      _idadeController.clear();
      _autovalidar = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
        appBar: AppBar(
          title: Text("CheckApp"),
        ),
        body: Form(
          key: _formKey,
          child: Container(
            height: SizeConfig.safeBlockVertical * 80,
            padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Center(
                    child: Text("Entre com os dados do paciente",
                        style: TextStyle(fontSize: 20.0))),
                TextFormField(
                  keyboardType: TextInputType.number,
                  autovalidate: _autovalidar,
                  controller: _idadeController,
                  onChanged: (value) {
                    preenchaIdade(context, value);
                  },
                  validator: (input) {
                    if (input.length == 0) {
                      return 'Idade não pode ser vazia';
                    } else {
                      _idade = int.tryParse(input);
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Idade",
                  ),
                ),
                Center(
                  child: DropdownButtonHideUnderline(
                    child: Listener(
                      onPointerDown: (_) => FocusScope.of(context).unfocus(),
                      child: DropdownButton<dynamic>(
                        key: ValueKey("DropdownButton"),
                        value: _sexo,
                        icon: Icon(Icons.arrow_drop_down),
                        iconSize: 24,
                        elevation: 16,
                        hint: Text("Sexo"),
                        onChanged: (novoSexo) {
                          if (!Provider.of<ProfilingState>(context,
                                  listen: false)
                              .sexo) {
                            Provider.of<ProfilingState>(context, listen: false)
                                .fillSex();
                          }
                          setState(() {
                            _sexo = novoSexo;
                          });
                        },
                        items: <String>['Masculino', 'Feminino']
                            .map((String value) {
                          return DropdownMenuItem<String>(
                            key: ValueKey(value),
                            child: Text(value),
                            value: value,
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    RaisedButton(
                        child: Text("Limpar"),
                        onPressed: () {
                          clearNotifier(context);
                        }),
                    Consumer<ProfilingState>(builder: (context, profile, _) {
                      return RaisedButton(
                        child: Text("Continuar"),
                        onPressed: profile.filled
                            ? () {
                                dynamic validation = validate(_idade, _sexo);
                                if (validation['isValid']) {
                                  futureDisease = getDiseasesByProfileTarget(
                                      sex: _sexo, age: _idade.toString());
                                  Navigator.pushNamed(context, actionsListRoute,
                                      arguments: {
                                        'sexo': _sexo,
                                        'idade': _idade,
                                      });
                                } else {
                                  Scaffold.of(context).showSnackBar(SnackBar(
                                    content: Text(validation["reason"]),
                                  ));
                                }
                              }
                            : null,
                      );
                    })
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
