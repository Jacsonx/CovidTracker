class CovidEstado {
  String sId;
  String nome;
  int casosAcumulado;
  int obitosAcumulado;
  String populacaoTCU2019;
  String incidencia;
  String incidenciaObito;

  CovidEstado(
      {this.sId,
      this.nome,
      this.casosAcumulado,
      this.obitosAcumulado,
      this.populacaoTCU2019,
      this.incidencia,
      this.incidenciaObito});

  CovidEstado.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    nome = json['nome'];
    casosAcumulado = json['casosAcumulado'];
    obitosAcumulado = json['obitosAcumulado'];
    populacaoTCU2019 = json['populacaoTCU2019'];
    incidencia = json['incidencia'];
    incidenciaObito = json['incidenciaObito'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['nome'] = this.nome;
    data['casosAcumulado'] = this.casosAcumulado;
    data['obitosAcumulado'] = this.obitosAcumulado;
    data['populacaoTCU2019'] = this.populacaoTCU2019;
    data['incidencia'] = this.incidencia;
    data['incidenciaObito'] = this.incidenciaObito;
    return data;
  }
}
