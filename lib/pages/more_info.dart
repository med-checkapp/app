import 'package:flutter/material.dart';
import 'package:check_app/constants.dart';

class MoreInfo extends StatelessWidget {
  String rfm10;

  MoreInfo(Map<String, String> args) {
    rfm10 = args['rmf10'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculadora FRAX"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            "Resultados e conclusões",
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 25),
                  child: Text(
                    "O RFM10 calculado foi: $rfm10",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 15),
                  child: Text(
                    "O Limiar de intervenção para este perfil é de $LI",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 15),
                  child: Text(
                    "A faixa na qual a Densitometria Óssea tem maior importância clinica-preventiva é entre 5.2% e 7.7%",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 50,
              vertical: 25,
            ),
            child: Text(
              "Não é ncessária nenhuma intervenção",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.teal,
              ),
            ),
            decoration: BoxDecoration(
              border: Border.all(
                width: 0.8,
                color: Colors.teal,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          Container(
            child: Column(
              children: [
                FlatButton(
                  onPressed: () {
                    Navigator.pushNamed(context, resultsRoute);
                  },
                  child: Text(
                    "Saiba mais sobre a interpretação destes resultados",
                    style: TextStyle(
                      color: Colors.teal,
                    ),
                  ),
                ),
                FlatButton(
                  onPressed: () {
                    int count = 0;
                    Navigator.of(context).popUntil((_) => count++ >= 2);
                  },
                  child: Text(
                    "Voltar a lista de prioridades",
                    style: TextStyle(
                      color: Colors.teal,
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
