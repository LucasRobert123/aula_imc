import 'dart:math';

import 'package:aula_imc/models/table_class.dart';
import 'package:flutter/material.dart';

class CalculoImcWidget extends StatefulWidget {
  @override
  _CalculoImcWidgetState createState() => _CalculoImcWidgetState();
}

class _CalculoImcWidgetState extends State<CalculoImcWidget> {
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  TextEditingController alturacontroller = TextEditingController();
  TextEditingController pesocontroller = TextEditingController();
  TextEditingController circunferenciacontroller = TextEditingController();

  String _resultadoImc, _resultadoIac;
  int _radioGenreValue = 0, _radioTypeValue = 0;

  List<TableClass> tableIMC = [
    TableClass(genre: "Masculino", limit: 20.0, warning: "Abaixo do peso"),
    TableClass(genre: "Masculino", limit: 24.9, warning: "Peso ideal"),
    TableClass(
        genre: "Masculino", limit: 29.9, warning: "Levemente acima do peso"),
    TableClass(genre: "Masculino", limit: 39.9, warning: "Obesidade grau I"),
    TableClass(genre: "Masculino", limit: 43.0, warning: "Obesidade grau II"),
    TableClass(genre: "Feminino", limit: 18.6, warning: "Abaixo do peso"),
    TableClass(genre: "Feminino", limit: 25.0, warning: "Peso ideal"),
    TableClass(
        genre: "Feminino", limit: 30.0, warning: "Levemente acima do peso"),
    TableClass(genre: "Feminino", limit: 35.0, warning: "Obesidade grau I"),
    TableClass(genre: "Feminino", limit: 40.0, warning: "Obesidade grau II"),
  ];

  void _handleRadioGenreValChange(int value) {
    setState(() {
      _resultadoIac = _resultadoImc = null;
      _radioGenreValue = value;
    });
  }

  void _handleRadioTypeValChange(int value) {
    setState(() {
      _resultadoIac = _resultadoImc = null;
      _radioTypeValue = value;
    });
  }

  void _calcularimc() {
    double altura = double.parse(alturacontroller.text) / 100;
    double peso = double.parse(pesocontroller.text);
    double imc = peso / pow(altura, 2);

    setState(() {
      _resultadoIac = null;
      _resultadoImc =
          imc.toStringAsFixed(2) + "\n\n" + getClassificacaoIMC(imc);
    });
  }

  void _calculariac() {
    double altura = double.parse(alturacontroller.text) / 100;
    double circunferencia = double.parse(circunferenciacontroller.text);
    double iac = (circunferencia / (altura * sqrt(altura))) - 18;

    setState(() {
      _resultadoImc = null;
      _resultadoIac =
          iac.toStringAsFixed(2) + "\n\n" + getClassificacaoIAC(iac);
    });
  }

  String getClassificacaoTableIMC(String genre, num imc) {
    String strclassificacao = "";
    tableIMC
        .where((element) => element.genre == genre)
        .map(
          (item) => {
            if (imc < item.limit && strclassificacao == "")
              {strclassificacao = item.warning}
          },
        )
        .toList();

    return strclassificacao;
  }

  String getClassificacaoIMC(num imc) {
    String strclassificacao = "";

    if (_radioGenreValue == 0) {
      if (imc < 43) {
        strclassificacao = getClassificacaoTableIMC("Masculino", imc);
      } else {
        strclassificacao = "Obesidade grau III";
      }
    } else {
      if (imc < 40) {
        strclassificacao = getClassificacaoTableIMC("Feminino", imc);
      } else
        strclassificacao = "Obesidade grau III";
    }
    return strclassificacao;
  }

  List<TableClass> tableIAC = [
    TableClass(genre: "Masculino", limit: 8.0, warning: "Abaixo do normal"),
    TableClass(genre: "Masculino", limit: 20.9, warning: "Adiposidade normal"),
    TableClass(genre: "Masculino", limit: 25.0, warning: "Sobrepeso"),
    TableClass(genre: "Feminino", limit: 21.0, warning: "Abaixo do normal"),
    TableClass(genre: "Feminino", limit: 32.9, warning: "Adiposidade normal"),
    TableClass(genre: "Feminino", limit: 38.0, warning: "Sobrepeso"),
  ];

  String getClassificacaoTableIAC(String genre, num iac) {
    String strclassificacao = "";
    tableIAC
        .where((element) => element.genre == genre)
        .map(
          (item) => {
            if (iac < item.limit && strclassificacao == "")
              {strclassificacao = item.warning}
          },
        )
        .toList();

    return strclassificacao;
  }

  String getClassificacaoIAC(num iac) {
    String strclassificacao;

    if (_radioGenreValue == 0) {
      if (iac < 25) {
        strclassificacao = getClassificacaoTableIAC("Masculino", iac);
      } else
        strclassificacao = "Obesidade";
    } else {
      if (iac < 38) {
        strclassificacao = getClassificacaoTableIAC("Feminino", iac);
      } else
        strclassificacao = "Obesidade";
    }

    return strclassificacao;
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Form(
          key: _formkey,
          child: Container(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Radio(
                        value: 0,
                        groupValue: _radioTypeValue,
                        onChanged: _handleRadioTypeValChange,
                      ),
                      new Text("IMC"),
                      Radio(
                        value: 1,
                        groupValue: _radioTypeValue,
                        onChanged: _handleRadioTypeValChange,
                      ),
                      new Text("IAC")
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Radio(
                        value: 0,
                        groupValue: _radioGenreValue,
                        onChanged: _handleRadioGenreValChange,
                      ),
                      new Text("Homem"),
                      Radio(
                        value: 1,
                        groupValue: _radioGenreValue,
                        onChanged: _handleRadioGenreValChange,
                      ),
                      new Text("Mulher")
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(16),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    controller: alturacontroller,
                    validator: (value) {
                      return value.isEmpty ? "Informe a altura" : null;
                    },
                    decoration: InputDecoration(labelText: "Altura em cm:"),
                  ),
                ),
                Visibility(
                  child: Container(
                    margin: EdgeInsets.all(16),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      controller: pesocontroller,
                      validator: (value) {
                        return value.isEmpty ? "Informe o peso" : null;
                      },
                      decoration: InputDecoration(labelText: "Peso em Kg:"),
                    ),
                  ),
                  visible: _radioTypeValue == 0,
                ),
                Visibility(
                  child: Container(
                    margin: EdgeInsets.all(16),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      controller: circunferenciacontroller,
                      validator: (value) {
                        return value.isEmpty
                            ? "Informe a circunferência do quadril"
                            : null;
                      },
                      decoration: InputDecoration(
                          labelText: "Circunferência do quadril:"),
                    ),
                  ),
                  visible: _radioTypeValue == 1,
                ),
                Container(
                  margin: EdgeInsets.all(16),
                  child: Text(_resultadoImc == null
                      ? _resultadoIac == null
                          ? ""
                          : "IAC: $_resultadoIac"
                      : "IMC: $_resultadoImc"),
                ),
                Container(
                  margin: EdgeInsets.all(16),
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formkey.currentState.validate()) {
                        if (_radioTypeValue == 0)
                          _calcularimc();
                        else
                          _calculariac();
                      }
                    },
                    child: Text("Calcular"),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
