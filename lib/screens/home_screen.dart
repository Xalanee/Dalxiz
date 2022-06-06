import 'package:dalxiz/screens/login_screen.dart';
import 'package:dalxiz/screens/user/user.dart';
import 'package:dalxiz/screens/user/users.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'constant.dart';
import 'data.dart';
import 'details.dart';
import 'tabbar/acount.dart';
import 'tabbar/home.dart';
import 'tabbar/message.dart';
import 'tabbar/notifcation.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  int _selectedIndex = -1;
  int _selectedItem = 0;
  List<IconData> _icons = [
    FontAwesomeIcons.plane,
    FontAwesomeIcons.car,
    FontAwesomeIcons.ship,
    FontAwesomeIcons.biking,
  ];

  Widget _buildIcon(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });
      },
      child: Container(
        height: 60.0,
        width: 60.0,
        decoration: BoxDecoration(
          color: _selectedIndex == index
              ? Theme.of(context).backgroundColor
              : Color.fromARGB(255, 231, 238, 235),
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: Icon(
          _icons[index],
          size: 25.0,
          color: _selectedIndex == index
              ? Theme.of(context).primaryColor
              : Color.fromARGB(255, 94, 202, 121),
        ),
      ),
    );
  }

  var currentIndex = 0;
  int _currentTab = 0;
  List<Place> places = getPlaceList();
  late TabController _tabController;
  int _currentPosition = 0;

  final widgetOptions = [
    // ProfileUI2(),
  ];
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    setState(() {});
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedItem = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,

      // resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "Travel",
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: false,
        actions: <Widget>[
          SizedBox(
            height: 90,
          ),
        ],
        // bottom: TabBar(
        //   controller: _tabController,
        //   tabs: [
        //     Tab(
        //       icon: Icon(
        //         Icons.flight,
        //         color: Colors.blue,
        //       ),
        //     ),
        //     Tab(
        //       icon: Icon(
        //         Icons.train_outlined,
        //         color: Colors.green,
        //       ),
        //     ),
        //     Tab(
        //       icon: Icon(
        //         Icons.directions_car,
        //         color: Colors.red,
        //       ),
        //     ),
        //     Tab(
        //       icon: Icon(
        //         Icons.directions_boat,
        //         color: Colors.black,
        //       ),
        //     ),
        //   ],
        //   onTap: (position) {
        //     setState(() {
        //       _currentPosition = position;
        //       print(position);
        //     });
        //   },
        // ),
      ),
      // drawer: Drawer(),

      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(
              left: 16,
              right: 16,
              top: 16,
            ),
            child: SizedBox(
              height: 80,
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search',
                  hintStyle: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[400],
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      width: 0,
                      style: BorderStyle.none,
                    ),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 20, horizontal: 24),
                  suffixIcon: Padding(
                    padding: EdgeInsets.only(right: 24.0, left: 8.0),
                    child: Icon(
                      Icons.search,
                      color: Colors.grey[400],
                      size: 26,
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 20.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: _icons
                .asMap()
                .entries
                .map(
                  (MapEntry map) => _buildIcon(map.key),
                )
                .toList(),
          ),
          SizedBox(height: 20.0),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(
                top: 8,
                left: 16,
              ),
              child: ListView(
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                children: buildPlaces(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> buildPlaces() {
    List<Widget> list = [];
    for (var place in places) {
      list.add(buildPlace(place));
    }
    return list;
  }

  Widget buildPlace(Place place) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Detail(place: place)),
        );
      },
      child: Card(
        elevation: 2,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
        ),
        child: Hero(
          tag: place.images[0],
          child: Container(
            width: 230,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(place.images[0]),
                fit: BoxFit.cover,
              ),
            ),
            child: Stack(
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    setState(() {
                      place.favorite = !place.favorite;
                    });
                  },
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: 12,
                      top: 12,
                    ),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Icon(
                        place.favorite ? Icons.favorite : Icons.favorite_border,
                        color: kPrimaryColor,
                        size: 36,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 12,
                    bottom: 12,
                    right: 12,
                  ),
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          place.description,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Row(
                          children: <Widget>[
                            Icon(
                              Icons.location_on,
                              color: Colors.white,
                              size: 20,
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              place.country,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // List<Widget> buildNavigationItems() {
  //   List<Widget> list = [];
  //   for (var navigationItem in navigationItems) {
  //     list.add(buildNavigationItem(navigationItem));
  //   }
  //   return list;
  // }

  // Widget buildNavigationItem(NavigationItem item) {
  //   return GestureDetector(
  //     child: Container(
  //       width: 50,
  //       child: Stack(
  //         children: <Widget>[
  //           IconButton(
  //             icon: Icon(
  //               Icons.home,
  //             ),
  //             onPressed: () {},
  //           ),
  //           IconButton(
  //             icon: Icon(Icons.notifications_on),
  //             onPressed: () {},
  //           ),
  //           IconButton(
  //             icon: Icon(Icons.settings),
  //             onPressed: () {},
  //           ),
  //           IconButton(
  //               icon: Icon(
  //                 Icons.person,
  //                 color: Colors.red,
  //               ),
  //               onPressed: () {
  //                 Navigator.push(
  //                     context, MaterialPageRoute(builder: (_) => ProfileUI2()));
  //               }),
  //           // Align(
  //           //   alignment: Alignment.topCenter,
  //           //   child: Container(
  //           //     width: 40,
  //           //     height: 3,
  //           //     color:
  //           //         selectedItem == item ? kPrimaryColor : Colors.transparent,
  //           //   ),
  //           // ),
  //           // Center(
  //           //   child: Icon(
  //           //     item.iconData,
  //           //     color: selectedItem == item ? kPrimaryColor : Colors.grey[400],
  //           //     size: 28,
  //           //   ),
  //           // )
  //         ],
  //       ),
  //     ),
  //   );
  // }
}
