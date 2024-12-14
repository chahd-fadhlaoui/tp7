class Classe {
  int nbreEtud;
  String nomClass;
  int? codClass;

  Classe(this.nbreEtud, this.nomClass, [this.codClass]);

  factory Classe.fromJson(Map<String, dynamic> json) {
    return Classe(
      json['nbreEtud'],
      json['nomClass'],
      json['codClass'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nbreEtud': nbreEtud,
      'nomClass': nomClass,
      'codClass': codClass,
    };
  }
}