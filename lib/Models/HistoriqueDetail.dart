class HistoriqueDetail {
  String nom;
  String prenom;
  double note;
  String adresse;
  String adresseDropOff;
  int prix;
  String createdAt;
  String localityPick;
  String localityDrop;

  HistoriqueDetail(
      {this.nom,
      this.prenom,
      this.note,
      this.adresse,
      this.adresseDropOff,
      this.prix,
      this.createdAt,
      this.localityPick,
      this.localityDrop});

  HistoriqueDetail.fromJson(Map<String, dynamic> json) {
    nom = json['nom'];
    prenom = json['prenom'];
    note = json['note'].toDouble();
    adresse = json['adresse'];
    adresseDropOff = json['adresse_drop_off'];
    prix = json['prix'];
    createdAt = json['created_at'];
    localityPick = json['locality_pick'];
    localityDrop = json['locality_drop'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nom'] = this.nom;
    data['prenom'] = this.prenom;
    data['note'] = this.note;
    data['adresse'] = this.adresse;
    data['adresse_drop_off'] = this.adresseDropOff;
    data['prix'] = this.prix;
    data['created_at'] = this.createdAt;
    data['locality_pick'] = this.localityPick;
    data['locality_drop'] = this.localityDrop;
    return data;
  }
}
