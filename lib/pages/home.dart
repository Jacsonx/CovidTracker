import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:flutter_circular_chart/flutter_circular_chart.dart';
import 'package:http/http.dart' as http;
import 'package:future_widget/models/covid.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Animation animation;

  final GlobalKey<AnimatedCircularChartState> _chartKey =
      new GlobalKey<AnimatedCircularChartState>();

  @override
  void initState() {

    super.initState();
  
  }

  List<CircularStackEntry> getData(CovidEstado covid) {
    List<CircularStackEntry> data = <CircularStackEntry>[
      new CircularStackEntry(
        <CircularSegmentEntry>[
          new CircularSegmentEntry(covid.obitosAcumulado.toDouble(), Colors.redAccent[200]),
          new CircularSegmentEntry(covid.casosAcumulado.toDouble(), Colors.teal[200]),
        ],
      ),
    ];
    return data;
  }

  Future<List<CovidEstado>> _getCovid() async {
    try {
      Response response = await http.get(
          'https://xx9p7hp1p7.execute-api.us-east-1.amazonaws.com/prod/PortalEstado');

      if (response.statusCode == 400) {
        throw Exception();
      }

      var jsonResposta = jsonDecode(response.body);

      List<CovidEstado> covidState = List<CovidEstado>();

      for (var i = 0; i < jsonResposta.length; i++) {
        covidState.add(CovidEstado.fromJson(jsonResposta[i]));
      }

      return covidState;
    } catch (exception) {
      return exception;
    }
  }

  Widget _criaList(List<CovidEstado> covidList) {
    return ListView.builder(
      itemCount: covidList.length,
      itemBuilder: (context, index) {
        final CovidEstado covid = covidList[index];
        return _criaComponentList(covid);
      },
    );
  }

  Widget _criaComponentList(CovidEstado covid) {
    return ExpansionTile(
      title: Text(covid.nome),
      children: <Widget>[
        Card(
          child: Container(
            padding: EdgeInsets.all(16.0),
            alignment: Alignment.centerLeft,
            color: Colors.grey[100],
            child: Column(
              children: <Widget>[
                new AnimatedCircularChart(
                  duration: Duration(seconds: 2),
                  key: _chartKey,    
                  size: const Size(300.0, 300.0),
                  chartType: CircularChartType.Radial,
                  initialChartData: getData(covid),
                  holeLabel:"Casos: ${covid.casosAcumulado.toString()} / Mortes: ${covid.obitosAcumulado.toString()}",
                ),
                styleFont(
                  "Casos confirmados: ${covid.casosAcumulado.toString()}"),
                Divider(),
                styleFont(
                  "Mortes confirmadas: ${covid.obitosAcumulado.toString()}"),
                Divider(),
                styleFont("População: ${covid.populacaoTCU2019.toString()}"),
                Divider(),
                styleFont("Incidentes: ${covid.incidencia.toString()}"),
                Divider(),
                styleFont(
                  "Mortes de Incidentes: ${covid.incidenciaObito.toString()}")
              ]
            )
          ),
        ),
      ],
    );
  }

  Widget styleFont(String text) {
    return Text(
      text,
      textAlign: TextAlign.left,
      style: TextStyle(
        textBaseline: TextBaseline.ideographic,
        color: Colors.black,
        fontWeight: FontWeight.w400,
        fontFamily: 'Roboto',
        letterSpacing: 0.5,
        fontSize: 16,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Covid-19')),
      body: FutureBuilder<List<CovidEstado>>(
        future: _getCovid(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.error != null) {
            return Center(
              child: Text('Ops, ocorreu um problema'),
            );
          } else if (snapshot.connectionState == ConnectionState.done) {
            return _criaList(snapshot.data);
          } else {
            return Center(
              child: Text('teste'),
            );
          }
        },
      ),
    );
  }
}
