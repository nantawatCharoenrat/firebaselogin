import 'package:firebaselogin/login.dart';
import 'package:flutter/material.dart';
//import 'package:firebaselogin/main.dart';
import 'package:firebaselogin/User_page.dart';
import 'package:firebaselogin/Frame.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

final auth = FirebaseAuth.instance;

class BuyCat extends StatelessWidget {
  const BuyCat({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Buy Cat',
            style: TextStyle(color: Colors.white, fontSize: 20)),
        backgroundColor: Color.fromARGB(255, 242, 50, 33),
      ),
      // body: Center(
      //   child: Image.asset(
      //     'assets/catmeme12.png',
      //     width: 300,
      //     height: 300,
      //   ),
      // ),
    );
  }
}

class Me extends StatefulWidget {
  const Me({super.key});

  @override
  State<Me> createState() => _MeState();
}

class _MeState extends State<Me> {
  File? _image;
  File? pickedFile;
  @override
  Widget build(BuildContext context) => Drawer(
          child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            buildHeader(context),
            buildMenuItems(context),
          ],
        ),
      ));
  Widget buildHeader(BuildContext context) => Material(
      color: Color.fromARGB(255, 25, 218, 214),
      child: InkWell(
          onTap: () {
            Navigator.pop(context);
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => Userpage()));
          },
          child: Container(
            padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top, bottom: 24),
            child: Column(children: [
              SizedBox(
                height: 20,
              ),
              _image != null
                  ? CircleAvatar(
                      backgroundImage: FileImage(_image!),
                      radius: 52,
                    )
                  : CircleAvatar(
                      backgroundImage: NetworkImage(
                          'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png'),
                      radius: 52,
                    ),
              SizedBox(
                height: 12,
              ),
              Text(
                auth.currentUser!.email!,
                style: TextStyle(
                    fontSize: 28,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 12,
              ),
              Text(
                'User_Email',
                style: TextStyle(
                    fontSize: 24,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              Row(
                children: [cameraButton(), galleryButton()],
                mainAxisAlignment: MainAxisAlignment.center,
              )
            ]),
          )));
  Widget buildMenuItems(BuildContext context) => Container(
      padding: const EdgeInsets.all(32),
      child: Wrap(
        runSpacing: 12,
        children: [
          SizedBox(
            height: 20,
          ),
          ListTile(
              leading: const Icon(Icons.home_outlined),
              title: const Text('Home'),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => MyStatefulWidget()));
              }),
          SizedBox(
            height: 40,
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: () {
              Navigator.popUntil(context, ModalRoute.withName('/'));
            },
          ),
        ],
      ));

  Widget cameraButton() {
    return IconButton(
        onPressed: () {
          onChooseImage(ImageSource.camera);
        },
        icon: Icon(
          Icons.add_a_photo,
          size: 36.0,
          color: Colors.white,
        ));
  }

  Future<void> onChooseImage(ImageSource imageSource) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: imageSource);
    if (pickedFile == null) return;

    setState(() {
      _image = File(pickedFile.path);
    });
  }

  Widget galleryButton() {
    return IconButton(
        onPressed: () {
          onChooseImage(ImageSource.gallery);
        },
        icon: Icon(
          Icons.add_photo_alternate,
          size: 36.0,
          color: Colors.white,
        ));
  }
}
