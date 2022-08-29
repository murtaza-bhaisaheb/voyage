import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:voyage/models/user.dart';

class UserServices {
  final String collection = "users";
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> createUser(Map<String, dynamic> values) async {
    String id = values['id'];
    await _firestore.collection(collection).doc(id).set(values);
  }

  Future<void> updateUser(Map<String, dynamic> values) async {
    String id = values['id'];
    await _firestore.collection(collection).doc(id).update(values);
  }

  Future<void> getUserById(String id) async {
    await _firestore.collection(collection).doc(id).get().then((doc){
      if(doc.data() == null){
        return null;
      }
      return UserModel.fromSnapshot(doc);
    });
  }
}
