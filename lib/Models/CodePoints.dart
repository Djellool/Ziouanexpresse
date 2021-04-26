class CodePoints {
  String code;
  int nbPoints;

  CodePoints({this.code, this.nbPoints});

  CodePoints.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    nbPoints = json['nb_points'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['nb_points'] = this.nbPoints;
    return data;
  }
}
