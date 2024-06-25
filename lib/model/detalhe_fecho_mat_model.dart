class DetalheFechoMatModel {
  String? idterminal;
  String? hevento;
  String? tipoevento;
  String? nocartao;
  String? linha;
  String? localizacao;
  String? noviagem;

  DetalheFechoMatModel(
      {this.idterminal,
        this.hevento,
        this.tipoevento,
        this.nocartao,
        this.linha,
        this.localizacao,
        this.noviagem});

  DetalheFechoMatModel.fromJson(Map<String, dynamic> json) {
    idterminal = json['idterminal'];
    hevento = json['hevento'];
    tipoevento = json['tipoevento'];
    nocartao = json['nocartao'];
    linha = json['linha'];
    localizacao = json['localizacao'];
    noviagem = json['noviagem'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idterminal'] = this.idterminal;
    data['hevento'] = this.hevento;
    data['tipoevento'] = this.tipoevento;
    data['nocartao'] = this.nocartao;
    data['linha'] = this.linha;
    data['localizacao'] = this.localizacao;
    data['noviagem'] = this.noviagem;
    return data;
  }
}