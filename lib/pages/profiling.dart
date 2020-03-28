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


  @override
  Widget build(BuildContext context) {

    return ChangeNotifierProvider<ProfilingState>(
      create: (context) => ProfilingState(),
      child: Scaffold(
        drawer: Drawer(),
        appBar: AppBar(
          title: Text("CheckApp"),
        ),
        body: Column(

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


            TextField(
              controller: _idadeController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Idade",
              ),
              onSubmitted: (String newIdade) {
                setState(() {
                  idade = int.parse(newIdade);
                  Provider.of<ProfilingState>(context, listen: false).changeIdade();
                });
                },
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
                        _sexo = null;
                        _idadeController.clear();
                      });
                    }
                ),
                Consumer<ProfilingState>(
                  builder: (context, profile, child) {
                    return FlatButton(
                      child: Text("Continuar"),
                      disabledColor: Colors.grey,
                      onPressed: profile.filled()? (){
                        print("\n\nFOOOI\n\n");
                      }: null,
                      color: Colors.blue,
                    );
                  }
                )
              ],

            )

          ],
        )
      ),
    );
  }
}
