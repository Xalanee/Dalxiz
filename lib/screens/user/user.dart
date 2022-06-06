import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dalxiz/method.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../login_screen.dart';

// class ProfileUI2 extends StatelessWidget {
//   FirebaseAuth _auth = FirebaseAuth.instance;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           elevation: 0.0,
//           backgroundColor: Color.fromARGB(255, 112, 190, 112),
//           leading: IconButton(
//             icon: Icon(
//               Icons.arrow_back,
//               color: Colors.white,
//             ),
//             onPressed: () {},
//           ),
//         ),
//         body: Stack(
//           alignment: Alignment.center,
//           children: [
//             Column(mainAxisAlignment: MainAxisAlignment.center, children: [
//               Container(
//                 width: MediaQuery.of(context).size.width,
//                 child: Column(
//                   children: <Widget>[
//                     FutureBuilder(
//                       future: FirebaseFirestore.instance
//                           .collection('users')
//                           .doc(_auth.currentUser!.uid)
//                           .get(),
//                       builder: (context, snapshot) {
//                         if (snapshot.connectionState == ConnectionState.done) {
//                           return displayUserInformation(context, snapshot);
//                         } else {
//                           return CircularProgressIndicator();
//                         }
//                       },
//                     )
//                   ],
//                 ),
//               ),
//             ]),
//           ],
//         ));
//   }
// }

// Widget displayUserInformation(context, snapshot) {
//   // final user = snapshot.data;

//   return Column(
//     children: <Widget>[
//       Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Text(
//           snapshot.data['name'],
//           // "Name: ${user.name ?? 'Anonymous'}",
//           style: TextStyle(fontSize: 20),
//         ),
//       ),
//       Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Text(
//           snapshot.data['email'],

//           // "Email: ${user.email ?? 'Anonymous'}",
//           style: TextStyle(fontSize: 20),
//         ),
//       ),
//       Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Text(
//           snapshot.data['phone'],

//           // "Phone: ${user.phone ?? 'Anonymous'}",
//           style: TextStyle(fontSize: 20),
//         ),
//       ),
//     ],
//   );
// }

// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// import '../login_screen.dart';

class ProfileUI2 extends StatefulWidget {
  @override
  State<ProfileUI2> createState() => _ProfileUI2State();
}

class _ProfileUI2State extends State<ProfileUI2> {
  FirebaseAuth _auth = FirebaseAuth.instance;

  TextEditingController _usernameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Color.fromARGB(255, 112, 190, 112),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {},
          ),
        ),
        body: Stack(alignment: Alignment.topCenter, children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FutureBuilder(
                future: FirebaseFirestore.instance
                    .collection('users')
                    .doc(_auth.currentUser!.uid)
                    .get(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return displayUserInformation(context, snapshot);
                  } else {
                    return CircularProgressIndicator();
                  }
                },
              ),
              SizedBox(
                height: 60,
              ),
              // Container(
              //   height: 55,
              //   width: double.infinity,
              //   child: MaterialButton(
              //     onPressed: () async {
              //       await _auth.signOut().then((value) {
              //         Navigator.push(context,
              //             MaterialPageRoute(builder: (_) => LoginScreen()));
              //       });
              //     },
              //     textColor: Colors.white,
              //     color: Colors.green.shade700,
              //     shape: const StadiumBorder(),
              //     height: 45,
              //     minWidth: 240,
              //     child: Center(
              //       child: Text(
              //         "SIGN OUT",
              //         style: TextStyle(
              //           fontSize: 23,
              //           color: Colors.white,
              //         ),
              //       ),
              //     ),
              //   ),
              // )
            ],
          ),
          CustomPaint(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
            ),
            painter: HeaderCurvedContainer(),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  "Profile",
                  style: TextStyle(
                    fontSize: 35,
                    letterSpacing: 1.5,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(10.0),
                width: MediaQuery.of(context).size.width / 3,
                height: MediaQuery.of(context).size.width / 3,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 5),
                  shape: BoxShape.circle,
                  color: Colors.white,
                  image: const DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('assets/images/profile.jpg'),
                  ),
                ),
              ),
            ],
          ),
          // Padding(
          //   padding: EdgeInsets.only(bottom: 200, left: 120),
          //   child: CircleAvatar(
          //     backgroundColor: Colors.black54,
          //     child: IconButton(
          //       icon: Icon(
          //         Icons.edit,
          //         color: Colors.white,
          //       ),
          //       onPressed: () {},
          //     ),
          //   ),
          // )
        ]));
  }
}

class HeaderCurvedContainer extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = Color.fromARGB(255, 112, 190, 112);
    Path path = Path()
      ..relativeLineTo(0, 150)
      ..quadraticBezierTo(size.width / 2, 225, size.width, 150)
      ..relativeLineTo(0, -150)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

Widget displayUserInformation(context, snapshot) {
  // TextEditingController _usernameController = TextEditingController();

  // final user = snapshot.data;

  return Center(

   
      child: Container(
    margin: EdgeInsets.symmetric(horizontal: 20),
    height: 200,
    width: double.infinity,
    decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
              color: Colors.grey.shade300,
              blurRadius: 20,
              spreadRadius: 10,
              offset: const Offset(0, 10))
        ]),
    child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Divider(
        thickness: 0.5,
        height: 10,
      ),
      TextField(
        // controller: _usernameController,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 10),
            border: InputBorder.none,
            prefixIcon: Icon(
              Icons.person,
              color: Colors.green,
            ),
            hintText: snapshot.data['name'],
            hintStyle: TextStyle(
                color: Colors.grey[600],
                fontSize: 20,
                fontWeight: FontWeight.bold)),
      ),
      Divider(
        thickness: 0.5,
        height: 10,
      ),
      TextField(
        // controller: _usernameController,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 10),
            border: InputBorder.none,
            prefixIcon: Icon(
              Icons.email_outlined,
              color: Colors.green,
            ),
            hintText: snapshot.data['email'],
            hintStyle: TextStyle(
                color: Colors.grey[600],
                fontSize: 20,
                fontWeight: FontWeight.bold)),
      ),
      Divider(
        thickness: 0.5,
        height: 10,
      ),
      TextField(
        // controller: _usernameController,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 10),
            border: InputBorder.none,
            prefixIcon: Icon(
              Icons.phone_android_outlined,
              color: Colors.green,
            ),
            hintText: snapshot.data['phone'],
            hintStyle: TextStyle(
                color: Colors.grey[600],
                fontSize: 20,
                fontWeight: FontWeight.bold)),
      ),
   
    ]),
  ));

  
}
