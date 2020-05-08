import 'package:check_app/Notifiers/profiling_state.dart';
import 'package:check_app/models/diseases.dart';
import 'package:check_app/services/diseases.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:check_app/constants.dart';
import 'package:check_app/config_size.dart';

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
    if (idade == null || idade < 0 || idade > 120)
      return {
        "isValid": false,
        "reason": "Idade precisa ser um número entre 0 e 120"
      };
    if (sexo != 'Masculino' && sexo != 'Feminino')
      return {"isValid": false, "reason": "Sexo inválido"};

    return {"isValid": true, "reason": ""};
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
                    _autovalidar = true;
                    Provider.of<ProfilingState>(context, listen: false)
                        .preencherIdade();
                  },
                  validator: (input) {
                    if (input.length == 0) {
                      Provider.of<ProfilingState>(context, listen: false)
                          .esvaziarIdade();
                      return 'Idade não pode ser vazia';
                    } else {
                        _idade = int.tryParse(input); 
                      Provider.of<ProfilingState>(context, listen: false)
                          .preencherIdade();
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
                    child: DropdownButton<String>(
                      value: _sexo,
                      icon: Icon(Icons.arrow_drop_down),
                      iconSize: 24,
                      elevation: 16,
                      hint: Text("Sexo"),
                      onChanged: (novoSexo) {
                        setState(() {
                          _sexo = novoSexo;
                          if (!Provider.of<ProfilingState>(context,
                                  listen: false)
                              .getSexo())
                            Provider.of<ProfilingState>(context, listen: false)
                                .changeSexo();
                        });
                      },
                      items:
                          <String>['Masculino', 'Feminino'].map((String value) {
                        return DropdownMenuItem<String>(
                          child: Text(value),
                          value: value,
                        );
                      }).toList(),
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
                          setState(() {
                            Provider.of<ProfilingState>(context, listen: false)
                                .esvaziarIdade();
                            Provider.of<ProfilingState>(context, listen: false)
                                .changeSexo();
                            _sexo = null;
                            _idadeController.clear();
                            _autovalidar = false;
                          });
                        }),
                    Consumer<ProfilingState>(
                        builder: (context, profile, child) {
                      return RaisedButton(
                        child: Text("Continuar"),
                        onPressed: profile.filled()
                            ? () {
                                dynamic validation = validate(_idade, _sexo);
                                print(validation);
                                if (validation['isValid']) {
                                  futureDisease = getDiseasesByProfileTarget(
                                      sex: _sexo, age: _idade.toString());
                                  Navigator.pushNamed(context, actionsListRoute,
                                      arguments: {
                                        'sexo': _sexo,
                                        'idade': _idade,
                                      });
                                } else
                                  Scaffold.of(context).showSnackBar(SnackBar(
                                    content: Text(validation["reason"]),
                                  ));
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
