class FechoModel {
  int? nomot;
  String? nomemot;
  int? fechado;
  List<Matriculas>? matriculas;

  FechoModel({this.nomot, this.nomemot, this.fechado, this.matriculas});

  FechoModel.fromJson(Map<String, dynamic> json) {
    nomot = json['nomot'];
    nomemot = json['nomemot'];
    fechado = json['Fechado'];
    if (json['matriculas'] != null) {
      matriculas = <Matriculas>[];
      json['matriculas'].forEach((v) {
        matriculas!.add(new Matriculas.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nomot'] = this.nomot;
    data['nomemot'] = this.nomemot;
    data['Fechado'] = this.fechado;
    if (this.matriculas != null) {
      data['matriculas'] = this.matriculas!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Matriculas {
  String? matricula;
  int? fechado;
  List<Dados>? dados;

  Matriculas({this.matricula, this.fechado, this.dados});

  Matriculas.fromJson(Map<String, dynamic> json) {
    matricula = json['matricula'];
    fechado = json['Fechado'];
    if (json['dados'] != null) {
      dados = <Dados>[];
      json['dados'].forEach((v) {
        dados!.add(new Dados.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['matricula'] = this.matricula;
    data['Fechado'] = this.fechado;
    if (this.dados != null) {
      data['dados'] = this.dados!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Dados {
  String? dfecho;
  String? habertura;
  String? hfecho;
  String? dabertura;
  int? idterminal;

  Dados(
      {this.dfecho,
        this.habertura,
        this.hfecho,
        this.dabertura,
        this.idterminal});

  Dados.fromJson(Map<String, dynamic> json) {
    dfecho = json['dfecho'];
    habertura = json['habertura'];
    hfecho = json['hfecho'].toString()=="false"?'Ainda não fez fecho':json['hfecho'].toString();;
    dabertura = json['dabertura'];
    idterminal = json['idterminal'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dfecho'] = this.dfecho;
    data['habertura'] = this.habertura;
    data['hfecho'] = this.hfecho;
    data['dabertura'] = this.dabertura;
    data['idterminal'] = this.idterminal;
    return data;
  }
}
