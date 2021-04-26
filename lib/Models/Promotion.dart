class Promotions {
  double valeur;
  String finValidite;
  String debutValidite;
  String code;

  Promotions({this.valeur, this.finValidite, this.debutValidite, this.code});

  Promotions.fromJson(Map<String, dynamic> json) {
    valeur = json['valeur'].toDouble();
    finValidite = json['fin_validite'];
    debutValidite = json['debut_validite'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['valeur'] = this.valeur;
    data['fin_validite'] = this.finValidite;
    data['debut_validite'] = this.debutValidite;
    data['code'] = this.code;
    return data;
  }
}