import 'package:firebaselogin/drawers.dart';
import 'package:firebaselogin/login.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

final auth = FirebaseAuth.instance;

class Userpage extends StatelessWidget {
  const Userpage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 25, 218, 214),
          title: Text(
            'Profile',
            style: TextStyle(
                color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
          ),
          leading: IconButton(
              icon: Icon(Icons.keyboard_double_arrow_left),
              onPressed: () {
                //
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Me()));
              })),
      body: Center(
          child: Column(
              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
            SizedBox(height: 90),
            CircleAvatar(
                radius: 132,
                backgroundImage: NetworkImage(
                    'https://i.cbc.ca/1.5359228.1577206958!/fileImage/httpImage/image.jpg_gen/derivatives/16x9_940/smudge-the-viral-cat.jpg')),
            SizedBox(
              height: 50,
            ),
            SizedBox(
                height: 50,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 50,
                  ),
                  child: Container(
                    height: 1,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Color(0xFF18D191),
                        borderRadius: BorderRadius.circular(90)),
                    child: Text('Name Your Email',
                        style: TextStyle(
                            fontSize: 28.0,
                            color: Colors.amber[50],
                            fontWeight: FontWeight.bold)),
                  ),
                )),
            SizedBox(
              height: 20,
            ),
            SizedBox(
                height: 70,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 25,
                  ),
                  child: Container(
                    alignment: Alignment.center,
                    height: 1,
                    decoration: BoxDecoration(
                        color: Colors.amber[400],
                        borderRadius: BorderRadius.circular(90)),
                    child: Text(auth.currentUser!.email!,
                        style: TextStyle(
                            fontSize: 26,
                            color: Colors.white,
                            fontWeight: FontWeight.bold)),
                  ),
                ))
          ])));
}
