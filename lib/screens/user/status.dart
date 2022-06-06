import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dalxiz/screens/home_screen.dart';
import 'package:dalxiz/screens/spash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:flutter/material.dart';

import '../constant.dart';

class Nofication extends StatelessWidget {
  final String? payload;
  final String? body;
  Nofication({Key? key, this.body, this.payload}) : super(key: key);

  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Color.fromARGB(255, 112, 190, 112),
          title: Padding(
            padding: const EdgeInsets.only(left: 70),
            child: Text(
              'Bookings',
              style: TextStyle(fontSize: 30),
            ),
          ),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SplashScreen()));
            },
          ),
        ),
        body: Container(
          child: StreamBuilder<dynamic>(
              stream: getUsersTripsStreamSnapshots(context),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return const Text("Loading...");
                return ListView.builder(
                    itemCount: snapshot.data.docs.length,
                    itemBuilder: (BuildContext context, int index) =>
                        buildTripCard(context, snapshot.data.docs[index]));
              }),
        ));
  }

  Stream<QuerySnapshot> getUsersTripsStreamSnapshots(
      BuildContext context) async* {
    final currentUser = FirebaseAuth.instance.currentUser;

    yield* FirebaseFirestore.instance
        .collection("users")
        .doc(_auth.currentUser!.uid)
        .collection("trips")
        .snapshots();
  }

  Widget buildTripCard(BuildContext context, DocumentSnapshot trip) {
    return new Container(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 4.0),
                child: Row(children: <Widget>[
                  Text(
                    trip['title'],
                    style: new TextStyle(
                      fontSize: 30.0,
                    ),
                  ),
                  Spacer(),
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () async {
                      await FirebaseFirestore.instance
                          .collection("users")
                          .doc(_auth.currentUser!.uid)
                          .collection("trips");
                    },
                  ),
                ]),
              ),
              Padding(
                padding: EdgeInsets.only(top: 4.0, bottom: 30.0),
                child: Row(children: <Widget>[
                  Expanded(
                    child: Text(
                      trip['body'],
                      style: new TextStyle(
                        fontSize: 15.0,
                      ),
                    ),
                  )
                  // Spacer(),
                ]),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: .0),
                child: Row(
                  children: <Widget>[
                    Text(
                      r"$ " + trip['payload'].toString(),
                      style: new TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.greenAccent),
                    ),
                    Spacer(),
                    Icon(Icons.directions_car),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
    
//     Scaffold(
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
//         body: Stack(alignment: Alignment.center, children: [
//           Column(mainAxisAlignment: MainAxisAlignment.center, children: [
//             FutureBuilder(
//               future: FirebaseFirestore.instance
//                   .collection('users')
//                   .doc(_auth.currentUser!.uid)
//                   .collection('trips')
//                   .get(),
//               builder: (context, snapshot) {
//                 if (snapshot.connectionState == ConnectionState.done) {
//                   return displayUserInformation(context, snapshot);
//                 } else {
//                   return CircularProgressIndicator();
//                 }
//               },
//             ),
//           ]),
//           CustomPaint(
//             child: Container(
//               width: MediaQuery.of(context).size.width,
//               height: MediaQuery.of(context).size.height,
//             ),
//             painter: HeaderCurvedContainer(),
//           ),
//           Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
//             Padding(
//               padding: EdgeInsets.all(10),
//               child: Text(
//                 "Notification",
//                 style: TextStyle(
//                   fontSize: 35,
//                   letterSpacing: 1.5,
//                   color: Colors.white,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//             ),
//           ])
//         ]));
//   }
// }

// class HeaderCurvedContainer extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     Paint paint = Paint()..color = Color.fromARGB(255, 112, 190, 112);
//     Path path = Path()
//       ..relativeLineTo(0, 150)
//       ..quadraticBezierTo(size.width / 2, 225, size.width, 150)
//       ..relativeLineTo(0, -150)
//       ..close();
//     canvas.drawPath(path, paint);
//   }

//   @override
//   bool shouldRepaint(CustomPainter oldDelegate) => false;
// }

// Widget displayUserInformation(context, snapshot) {
//   // TextEditingController _usernameController = TextEditingController();

//   // final user = snapshot.data;

//   return Center(
//       child: Container(
//     margin: EdgeInsets.symmetric(horizontal: 20),
//     height: 200,
//     width: double.infinity,
//     decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(10),
//         boxShadow: [
//           BoxShadow(
//               color: Colors.grey.shade300,
//               blurRadius: 20,
//               spreadRadius: 10,
//               offset: const Offset(0, 10))
//         ]),
//     child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
//       Divider(
//         thickness: 0.5,
//         height: 10,
//       ),
//       TextField(
//         // controller: _usernameController,
//         decoration: InputDecoration(
//             contentPadding: EdgeInsets.symmetric(horizontal: 10),
//             border: InputBorder.none,
//             prefixIcon: Icon(
//               Icons.person,
//               color: Colors.green,
//             ),
//             hintText: snapshot.data['title'],
//             hintStyle: TextStyle(
//                 color: Colors.grey[600],
//                 fontSize: 20,
//                 fontWeight: FontWeight.bold)),
//       ),
//       Divider(
//         thickness: 0.5,
//         height: 10,
//       ),
//       TextField(
//         // controller: _usernameController,
//         decoration: InputDecoration(
//             contentPadding: EdgeInsets.symmetric(horizontal: 10),
//             border: InputBorder.none,
//             prefixIcon: Icon(
//               Icons.email_outlined,
//               color: Colors.green,
//             ),
//             hintText: snapshot.data['body'],
//             hintStyle: TextStyle(
//                 color: Colors.grey[600],
//                 fontSize: 20,
//                 fontWeight: FontWeight.bold)),
//       ),
//       Divider(
//         thickness: 0.5,
//         height: 10,
//       ),
//       TextField(
//         // controller: _usernameController,
//         decoration: InputDecoration(
//             contentPadding: EdgeInsets.symmetric(horizontal: 10),
//             border: InputBorder.none,
//             prefixIcon: Icon(
//               Icons.phone_android_outlined,
//               color: Colors.green,
//             ),
//             hintText: snapshot.data['paylod'],
//             hintStyle: TextStyle(
//                 color: Colors.grey[600],
//                 fontSize: 20,
//                 fontWeight: FontWeight.bold)),
//       ),
//     ]),
//   ));
// }
