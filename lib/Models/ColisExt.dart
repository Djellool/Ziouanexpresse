class ColisExt {
  String dimensions;
  String fragilite;
  int valeur;
  double poids;

  ColisExt({this.dimensions, this.fragilite, this.valeur, this.poids});

  ColisExt.fromJson(Map<String, dynamic> json) {
    dimensions = json['dimensions'];
    fragilite = json['fragilite'];
    valeur = json['valeur'];
    poids = json['poids'].toDouble();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dimensions'] = this.dimensions;
    data['fragilite'] = this.fragilite;
    data['valeur'] = this.valeur;
    data['poids'] = this.poids;
    return data;
  }
}
