class Historique {
  String nom;
  String prenom;
  int idLivraisonExterne;
  int prix;
  String createdAt;
  String etat;

  Historique(
      {this.nom,
      this.prenom,
      this.idLivraisonExterne,
      this.prix,
      this.createdAt,
      this.etat});

  Historique.fromJson(Map<String, dynamic> json) {
    nom = json['nom'];
    prenom = json['prenom'];
    idLivraisonExterne = json['id_livraison_externe'];
    prix = json['prix'];
    createdAt = json['created_at'];
    etat = json['etat'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nom'] = this.nom;
    data['prenom'] = this.prenom;
    data['id_livraison_externe'] = this.idLivraisonExterne;
    data['prix'] = this.prix;
    data['created_at'] = this.createdAt;
    data['etat'] = this.etat;
    return data;
  }
}
