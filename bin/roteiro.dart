// ignore_for_file: unnecessary_new, unnecessary_this, prefer_collection_literals, file_names
import 'dias.dart';

class Roteiro {
  List<Dias>? dias;

  Roteiro({this.dias});

  Roteiro.fromJson(Map<String, dynamic> json) {
    if (json['dias'] != null) {
      dias = <Dias>[];
      json['dias'].forEach((v) {
        dias!.add(new Dias.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.dias != null) {
      data['dias'] = this.dias!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
