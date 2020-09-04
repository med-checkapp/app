import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

const String homeRoute = '/';
const String informativeRoute = '/informative';
const String actionsListRoute = '/actions-list';
const String wikiRoute = '/wiki';
// const String serverUrl = 'ratel.ime.usp.br:3001';
// const String serverUrl = 'localhost:3000';
const String serverUrl = '10.0.2.2:3000';
const String texto_informativo_osteo = """

Para iniciar o rastreamento de osteoporose, calcule o risco da sua paciente apresentar
fraturas de ossos maiores em 10 anos (RFM10), usando a calculadora do FRAX Brasil.

• Para isso, clique em www.sheffield.ac.uk/FRAX/tool.aspx?country=55.

• Primeira consulta: se a paciente ainda não fez rastreamento de osteoporose,
preencha as informações solicitadas, deixando o item 12 em branco.

• Retorno de consulta: com resultado de densitometria óssea solicitada em consulta
anterior, introduza o valor de T-score no item 12.
""";

Widget makeTestable(Widget widget) {
  return MediaQuery(
    data: MediaQueryData(),
    child: MaterialApp(home: widget),
  );
}
