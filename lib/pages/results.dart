import 'package:flutter/material.dart';

class Results extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculadora FRAX - Wiki"),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              margin: EdgeInsets.only(top: 30),
              child: Center(
                child: Text(
                  "Calculadora FRAX",
                  style: TextStyle(fontSize: 22),
                ),
              ),
            ),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "RFM10 < (LI - 20%)",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                      " - orientar sobre fatores de risco e medidas preventivas"),
                  Text(" - fazer acompanhamento periódico")
                ],
              ),
            ),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 10),
                    child: Text(
                      "(LI - 20%) < RFM10 < (LI + 20%)",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Text(" - solicitar densitometria óssea"),
                  Text(" - recalcular RFM10 com T-score na próxima consulta")
                ],
              ),
            ),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "(LI + 20%) < RFM10",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.only(bottom: 10),
                      child: Text(" - tratamento clinico está recomendado")),
                  Container(
                    margin: EdgeInsets.only(bottom: 10),
                    child: RichText(
                      text: TextSpan(
                        style: TextStyle(color: Colors.black),
                        children: <TextSpan>[
                          TextSpan(
                            text: "- Não é necessário densitometria óssea",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                              text:
                                  " para       rastreamento; pode ser solicitada "),
                          TextSpan(
                            text: "para acompanhamento",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Text(
                      " - orientar sobre fatores de risco e medidas preventivas"),
                ],
              ),
            ),
            Center(
              child: FlatButton(
                onPressed: () {
                  int count = 0;
                  Navigator.of(context).popUntil((_) => count++ >= 3);
                },
                child: Text(
                  "Voltar a lista de prioridades",
                  style: TextStyle(
                    color: Colors.teal,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
