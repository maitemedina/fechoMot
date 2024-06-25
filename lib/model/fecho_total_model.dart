class FechoTotalModel {
  String? totalBilhete;

  FechoTotalModel({this.totalBilhete});

  FechoTotalModel.fromJson(Map<String, dynamic> json) {
    totalBilhete = json['Total_Bilhete'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Total_Bilhete'] = this.totalBilhete;
    return data;
  }
}