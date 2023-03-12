import 'package:firebase_database/firebase_database.dart';

class UserModel{
  String? phone;
  String? nom;
  String? id;
  String? email;

  UserModel({
    this.phone,
    this.nom,
    this.id,
    this.email,
});
  UserModel.fromSnapshot(DataSnapshot snap){
    phone =(snap.value as dynamic)["phone"];
    nom =(snap.value as dynamic)["nom"];
    id =snap.key;
    email =(snap.value as dynamic)["email"];
  }
}