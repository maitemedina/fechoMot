class TurnoModel {
  String? mxstamp;
  String? dATA;
  String? hfim;
  String? hinicio;
  String? div;
  String? vendedor;
  String? uHorario;
  String? uLinha;
  String? inicio;
  String? fim;

  TurnoModel(
      {this.mxstamp,
        this.dATA,
        this.hfim,
        this.hinicio,
        this.div,
        this.vendedor,
        this.uHorario,
        this.uLinha,
        this.inicio,
        this.fim});

  TurnoModel.fromJson(Map<String, dynamic> json) {
    mxstamp = json['mxstamp'];
    dATA = json['DATA'];
    hfim = json['hfim'];
    hinicio = json['hinicio'];
    div = json['div'];
    vendedor = json['vendedor'];
    uHorario = json['u_horario'];
    uLinha = json['u_linha'];
    inicio = json['inicio'];
    fim = json['fim'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mxstamp'] = this.mxstamp;
    data['DATA'] = this.dATA;
    data['hfim'] = this.hfim;
    data['hinicio'] = this.hinicio;
    data['div'] = this.div;
    data['vendedor'] = this.vendedor;
    data['u_horario'] = this.uHorario;
    data['u_linha'] = this.uLinha;
    data['inicio'] = this.inicio;
    data['fim'] = this.fim;
    return data;
  }
}