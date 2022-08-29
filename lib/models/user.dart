import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  static const number = 'number';
  static const id = 'id';

  String? _number;
  String? _id;

  String get num => _number!;
  String get uid => _id!;

  UserModel.fromSnapshot(DocumentSnapshot snapshot){
    _number = snapshot[number];
    _id = snapshot[id];
  }
}