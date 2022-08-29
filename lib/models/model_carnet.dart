
import 'dart:convert';

List<CarnetModel> carnetModelFromJson(String str) => List<CarnetModel>.from(json.decode(str).map((x) => CarnetModel.fromJson(x)));

// String carnetModelToJson(List<CarnetModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));


class CarnetModel {
  String id;
  String idCarnet;
  String code;
  String nom;
  String prenom;
  String telephone;
  String numero;
  String date;
  String createdAt;
  String updatedAt;

  CarnetModel(
      {this.id,
      this.idCarnet,
      this.code,
      this.nom,
      this.prenom,
      this.telephone,
      this.numero,
      this.date,
      this.createdAt,
      this.updatedAt});

  CarnetModel.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    idCarnet = json['id_carnet'];
    code = json['code'];
    nom = json['nom'];
    prenom = json['prenom'];
    telephone = json['telephone'];
    numero = json['numero'];
    date = json['date'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['id_carnet'] = this.idCarnet;
    data['code'] = this.code;
    data['nom'] = this.nom;
    data['prenom'] = this.prenom;
    data['telephone'] = this.telephone;
    data['numero'] = this.numero;
    data['date'] = this.date;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
