class Client {
  int idClient;
  String nom;
  String prenom;
  String telephone;
  int wilaya;
  int commune;
  String adresse;
  String email;
  String emailVerifiedAt;
  String code;
  int nbPoints;
  String createdAt;
  String updatedAt;
  int enCours;

  Client(
      {this.idClient,
      this.nom,
      this.prenom,
      this.telephone,
      this.wilaya,
      this.commune,
      this.adresse,
      this.email,
      this.emailVerifiedAt,
      this.code,
      this.nbPoints,
      this.createdAt,
      this.updatedAt,
      this.enCours});

  Client.fromJson(Map<String, dynamic> json) {
    idClient = json['id_client'];
    nom = json['nom'];
    prenom = json['prenom'];
    telephone = json['telephone'];
    wilaya = json['wilaya'];
    commune = json['commune'];
    adresse = json['adresse'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    code = json['code'];
    nbPoints = json['nb_points'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    enCours = json['EnCours'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_client'] = this.idClient;
    data['nom'] = this.nom;
    data['prenom'] = this.prenom;
    data['telephone'] = this.telephone;
    data['wilaya'] = this.wilaya;
    data['commune'] = this.commune;
    data['adresse'] = this.adresse;
    data['email'] = this.email;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['code'] = this.code;
    data['nb_points'] = this.nbPoints;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['EnCours'] = this.enCours;
    return data;
  }
}
