import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dalxiz/screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
final User? _currentUser = FirebaseAuth.instance.currentUser;



// Future<User?> getCurrentUID() async {
//   return (await FirebaseAuth.currentUser()).uid;
// }

Future<User?> createAccount(
  String name,
  String email,
  String phone,
  String password,

) async {
  FirebaseAuth _auth = FirebaseAuth.instance;

  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  try {
    UserCredential userCrendetial = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);

    print("Account created Succesfull");

    userCrendetial.user!.updateDisplayName(name);

    await _firestore.collection('users').doc(_auth.currentUser!.uid).set({
      "name": name,
      "email": email,
      "phone": phone,
      "uid": _auth.currentUser!.uid,
   
    });

    return userCrendetial.user;
  } catch (e) {
    print(e);
    return null;
  }
}

final FirebaseAuth auth = FirebaseAuth.instance;

void inputData() {
  final User? user = auth.currentUser;
  final uid = user?.uid;
  // here you write the codes to input the data into firestore
}

Future<User?> logIn(String email, String password) async {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  try {
    UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email, password: password);

    print("Login Sucessfull");
    _firestore
        .collection('users')
        .doc(_auth.currentUser!.uid)
        .get()
        .then((value) => userCredential.user!.updateDisplayName(value['name']));

    return userCredential.user;
  } catch (e) {
    print(e);
    return null;
  }
}

Future logOut(BuildContext context) async {
  FirebaseAuth _auth = FirebaseAuth.instance;

  try {
    await _auth.signOut().then((value) {
      Navigator.push(context, MaterialPageRoute(builder: (_) => LoginScreen()));
    });
  } catch (e) {
    print("error");
  }
}

Future getCurrentUser() async {
final currentUser = FirebaseAuth.instance.currentUser;

}

// Future getCurrentUser(BuildContext context) async {
//   final User? _currentUser = FirebaseAuth.instance.currentUser;

// if (FirebaseAuth.currentUser !== null)
//         console.log("user id: " + FirebaseAuth.currentUser.uid);

//         FirebaseAuth.currentUser.onAuthStateChanged((user) => {
//   if (user) {
//     // User logged in already or has just logged in.
//     console.log(user.uid);
//   } else {
//     // User not logged in or has just logged out.
//   }
// });
//   var user = FirebaseAuth.instance.currentUser;

//   if (user != null) {
//     // User is signed in.
//   } else {
//     // No user is signed in.
//     print("error");
//   }
// }
