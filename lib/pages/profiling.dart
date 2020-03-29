import 'package:check_app/Notifiers/profiling_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

class Profiling extends StatefulWidget {

  @override
  _ProfilingState createState() => _ProfilingState();
}

class _ProfilingState extends State<Profiling> {
  int idade;
  String _sexo;
  final _idadeController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _autovalidar = false;

  @override
  void initState() {
    super.initState();

  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        drawer: Drawer(),
        appBar: AppBar(
          title: Text("CheckApp"),
        ),
        body: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Center(
                  child: Text(
                      "Entre com os dados do paciente",
                      style: TextStyle(
                          fontSize: 20.0
                      )
                  )
              ),


              TextFormField(
                keyboardType: TextInputType.number,
                autovalidate: _autovalidar,
                controller: _idadeController,
                onChanged: (value) {
                  _autovalidar = true;
                  Provider.of<ProfilingState>(context, listen: false).preencherIdade();
                },
                validator: (input) {
                  if (input.compareTo("") == 0) {
                    Provider.of<ProfilingState>(context, listen: false).esvaziarIdade();
                      return 'Idade não pode ser vazia';
                  }
                  else {
                      idade = int.parse(input);
                    Provider.of<ProfilingState>(context, listen: false).preencherIdade();
                    return null;
                  }
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Idade",
                ),
              ),

              DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: _sexo,
                  icon: Icon(Icons.arrow_drop_down),
                  iconSize: 24,
                  hint: Text("Sexo"),
                  elevation: 16,
                  onChanged: (novoSexo) {
                    setState(() {
                      _sexo = novoSexo;
                      Provider.of<ProfilingState>(context, listen: false).changeSexo();
                    });
                    },
                  items: <String>['Masculino', 'Feminino']
                      .map((String value) {
                        return DropdownMenuItem<String>(
                          child: Text(value),
                          value: value,
                        );
                      }).toList(),
                ),
              ),

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  FlatButton(
                      child: Text("Limpar"),
                      color: Colors.grey,
                      onPressed: (){
                        setState(() {
                          Provider.of<ProfilingState>(context, listen: false).esvaziarIdade();
                          Provider.of<ProfilingState>(context, listen: false).changeSexo();
                          _sexo = null;
                          _idadeController.clear();
                          _autovalidar = false;

                        });
                      }
                  ),
                  Consumer<ProfilingState>(
                    builder: (context, profile, child) {
                      return FlatButton(
                        child: Text("Continuar"),
                        disabledColor: Colors.grey,
                        onPressed: profile.filled()? (){
                        }: null,
                        color: Colors.blue,
                      );
                    }
                  )
                ],

              )

            ],
          ),
        )
      );
  }
}
