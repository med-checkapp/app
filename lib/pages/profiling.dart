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
  final _idadeController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _autovalidar = false;
  String sexoSelecionado;
  List<bool> _sexo;
  Future<List<Disease>> futureDisease;

  @override
  void initState() {
    super.initState();
    _sexo = [false, false];
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
      _sexo = [false, false];
      sexoSelecionado = null;
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
                  child: ToggleButtons(
                    fillColor: Colors.teal,
                    selectedColor: Colors.white,
                    color: Colors.teal,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 12.0,
                          horizontal: 20,
                        ),
                        child: Text("Masculino"),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 12.0,
                          horizontal: 20.0,
                        ),
                        child: Text("Feminino"),
                      )
                    ],
                    onPressed: (int index) {
                      setState(() {
                        if (index == 0) {
                          _sexo[0] = true;
                          _sexo[1] = false;
                          sexoSelecionado = "Masculino";
                        } else {
                          _sexo[0] = false;
                          _sexo[1] = true;
                          sexoSelecionado = "Feminino";
                        }
                      });
                      Provider.of<ProfilingState>(context, listen: false)
                          .fillSex();
                    },
                    isSelected: _sexo,
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
                                dynamic validation =
                                    validate(_idade, sexoSelecionado);
                                print(sexoSelecionado);
                                if (validation['isValid']) {
                                  futureDisease = getDiseasesByProfileTarget(
                                      sex: sexoSelecionado,
                                      age: _idade.toString());
                                  Navigator.pushNamed(context, actionsListRoute,
                                      arguments: {
                                        'sexo': sexoSelecionado,
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
