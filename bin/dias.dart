// ignore_for_file: unnecessary_this, prefer_collection_literals, unnecessary_new

class Dias {
  int? dia;
  String? nomeLugar;
  int? valorTotal;

  Dias({this.dia, this.nomeLugar, this.valorTotal});

  Dias.fromJson(Map<String, dynamic> json) {
    dia = json['dia'];
    nomeLugar = json['nomeLugar'];
    valorTotal = json['valorTotal'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dia'] = this.dia;
    data['nomeLugar'] = this.nomeLugar;
    data['valorTotal'] = this.valorTotal;
    return data;
  }
}
