import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

const double LI = 6.4;

const String homeRoute = '/';
const String moreInfoRoute = '/more-info';
const String resultsRoute = '/results';
const String informativeRoute = '/informative';
const String actionsListRoute = '/actions-list';
const String diseasesSelection = '/diseases-selection';
const String wikiRoute = '/wiki';
const String fraxRoute = '/frax';
// const String serverUrl = 'ratel.ime.usp.br:3001';
// const String serverUrl = 'localhost:3000';
const String serverUrl = '10.0.2.2:3000';
const String texto_informativo_osteo = """
<center> Fraturas por Osteoporose </center>
<br><br><br><br>

Para iniciar o rastreamento de osteoporose, calcule o risco da sua paciente apresentar
fraturas de ossos maiores em 10 anos (RFM10), usando a calculadora do FRAX Brasil.</br></br>
<ul>

<li> Primeira consulta: se a paciente ainda não fez rastreamento de osteoporose,
preencha as informações solicitadas, deixando o item 12 em branco. <br><br>
</li>

<li>Se o paciente <strong> já tem o resultado de densitometria óssea</strong>, introduza o valor de <strong> T-score no item 12</strong>. <br><br><br><br></li>
""";

Widget makeTestable(Widget widget) {
  return MediaQuery(
    data: MediaQueryData(),
    child: MaterialApp(home: widget),
  );
}

// hdnethnicity",
// "hdnpreviousfracture",
// "hdnpfracturehip",
// "hdncurrentsmoker",
// "hdnglucocorticoids",
// "hdnarthritis",
// "hdnosteoporosis",
// "hdnalcohol",
// "hdnbmd",
// "hdnthescore",
// "hdnsex",
// "hdnbmi",
// "hdnAuthCode",
// "nameid",
// "btnCalculate",
// "btnRefresh"

const Map<String, dynamic> fraxFormFields = {
  "age": {"id": "toolage", "type": "text", "label": "Idade"},
  "dateofbirth": {
    "id": "dateofbirth",
    "type": "date",
    "label": "Data de Nascimento"
  },
  "gender": {
    "id": "sex",
    "type": "select",
    "options": [
      {"name": "Masculino", "value": "1"},
      {"name": "Feminino", "value": "2"}
    ],
    "label": "Sexo"
  },
  "weight": {"id": "toolweight", "type": "text", "label": "Peso"},
  "height": {"id": "ht", "type": "text", "label": "Altura"},
  "previous_fracture": {
    "id": "previousfracture",
    "type": "bool",
    "label": "Fraturas anteriores",
    "defaultValue": false,
  },
  "parent_fractured_hip": {
    "id": "pfracturehip",
    "type": "bool",
    "label": "Pais tiveram fratura de quadril",
    "defaultValue": false,
  },
  "current_smoking": {
    "id": "currentsmoker",
    "type": "bool",
    "label": "Fumante",
    "defaultValue": false,
  },
  "glucocorticoids": {
    "id": "glucocorticoids",
    "type": "bool",
    "label": "Glucocorticoids",
    "defaultValue": false,
  },
  "rheumatoid_arthritis": {
    "id": "arthritis",
    "type": "bool",
    "label": "Artrite reumatoide",
    "defaultValue": false,
  },
  "secondary_osteoporosis": {
    "id": "osteoporosis",
    "type": "bool",
    "label": "Osteoporose secundária",
    "defaultValue": false,
  },
  "alcohol": {
    "id": "alcohol",
    "type": "bool",
    "label": "Consumo de álcool 3 ou mais unidades por dia",
    "defaultValue": false,
  },
  // "femoral_neck_BMD": {"value": "bmd_input", "type": "bool"},
};
