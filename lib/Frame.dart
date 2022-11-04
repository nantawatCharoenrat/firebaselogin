import 'package:firebaselogin/User_page.dart';
import 'package:firebaselogin/cash.dart';
import 'package:firebaselogin/home.dart';
import 'package:flutter/material.dart';
import 'package:firebaselogin/drawers.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  int _selectedIndex = 0;
  final auth = FirebaseAuth.instance;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  List<Widget> _tabs = <Widget>[
    Cat_view(),
    Cash(),
    Me(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.logout),
          onPressed: () {
            auth.signOut();
            Navigator.popAndPushNamed(context, '/');
          },
        ),
        title: Text("Cat for you shop", style: TextStyle(color: Colors.white)),
        // actions: <Widget>[
        //   IconButton(
        //     icon: Icon(Icons.exit_to_app),
        //     onPressed: () {
        //       auth.signOut();
        //       Navigator.popAndPushNamed(context, '/');
        //     },
        //   ),
        // ],
      ),
      body: Center(
        child: _tabs.elementAt(_selectedIndex),
      ),
      //drawer: Me(),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_shopping_cart),
            label: 'cash',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Me',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.teal[800],
        unselectedItemColor: Colors.teal[200],
        onTap: _onItemTapped,
      ),
    );
  }
}
