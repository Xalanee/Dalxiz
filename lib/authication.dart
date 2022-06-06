import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DatabaseManager {
  final CollectionReference profileList =
      FirebaseFirestore.instance.collection('users');
  FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> createUserData(String name, String email, String phone) async {
    return await profileList
        .doc(_auth.currentUser!.uid)
        .set({'name': name, 'email': email, 'phone': phone});
  }

  Future updateUserList(String name, String email, String phone) async {
    return await profileList
        .doc(_auth.currentUser!.uid)
        .update({'name': name, 'email': email, 'phone': phone});
  }

  Future getUsersList() async {
    List itemsList = [];

    try {
      await profileList.doc(_auth.currentUser!.uid).get().then((querySnapshot) {
        querySnapshot.get((element) {
          itemsList.add(element.data);
        });
      });
      return itemsList;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
