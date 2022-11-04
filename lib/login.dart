import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formstate = GlobalKey<FormState>();
  String? email;
  String? password;
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blue[400],
        body: Container(
            child: Form(
          autovalidateMode: AutovalidateMode.always,
          key: _formstate,
          child: ListView(
            children: <Widget>[
              Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                SizedBox(
                  height: 50,
                ),
                SizedBox(
                  height: 50,
                  child: Container(
                    height: 1,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.red,
                    ),
                    child: Text('Login Cat Shop',
                        style: TextStyle(
                            fontSize: 28.0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold)),
                  ),
                ),
              ]),
              SizedBox(
                height: 40,
              ),
              emailTextFormField(),
              passwordTextFormField(),
              SizedBox(
                height: 30,
              ),
              loginButton(),
              SizedBox(
                height: 20,
              ),
              registerButton(context),
            ],
          ),
        )));
  }

  ElevatedButton registerButton(BuildContext context) {
    return ElevatedButton(
      // ignore: prefer_const_constructors
      child: Text('Register new account'),
      style: ElevatedButton.styleFrom(
          textStyle: const TextStyle(
              color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))),
      onPressed: () {
        print('Goto  Regis pagge');
        Navigator.pushNamed(context, '/register');
      },
    );
  }

  ElevatedButton loginButton() {
    return ElevatedButton(
        child: Text('Login'),
        style: ElevatedButton.styleFrom(
            textStyle: const TextStyle(
                color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30))),
        onPressed: () async {
          if (_formstate.currentState!.validate()) {
            print('Valid Form');
            _formstate.currentState!.save();
            try {
              await auth
                  .signInWithEmailAndPassword(
                      email: email!, password: password!)
                  .then((value) {
                if (value.user!.emailVerified) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Login Pass")));
                  deleteAll();
                  Navigator.pushNamed(context, '/mainframe');
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Please verify email")));
                }
              }).catchError((reason) {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Login or Password Invalid")));
              });
            } on FirebaseAuthException catch (e) {
              if (e.code == 'user-not-found') {
                print('No user found for that email.');
              } else if (e.code == 'wrong-password') {
                print('Wrong password provided for that user.');
              }
            }
          } else
            print('Invalid Form');
        });
  }

  TextFormField passwordTextFormField() {
    return TextFormField(
      onSaved: (value) {
        password = value!.trim();
      },
      validator: (value) {
        if (value!.length < 8)
          return 'Please Enter more than 8 Character';
        else
          return null;
      },
      obscureText: true,
      keyboardType: TextInputType.text,
      decoration: const InputDecoration(
        labelText: 'Password',
        labelStyle: TextStyle(
            color: Colors.black, fontSize: 28, fontWeight: FontWeight.bold),
        icon: Icon(
          Icons.lock,
          color: Colors.white,
        ),
      ),
    );
  }

  TextFormField emailTextFormField() {
    return TextFormField(
      onSaved: (value) {
        email = value!.trim();
      },
      validator: (value) {
        if (!validateEmail(value!))
          return 'Please fill in E-m.ail field';
        else
          return null;
      },
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      decoration: const InputDecoration(
          labelText: 'E-mail',
          labelStyle: TextStyle(
              color: Colors.black, fontSize: 28, fontWeight: FontWeight.bold),
          icon: Icon(
            Icons.email,
            color: Colors.white,
          ),
          hintText: 'x@x.com',
          hintStyle: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
    );
  }

  bool validateEmail(String value) {
    RegExp regex = RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');

    return (!regex.hasMatch(value)) ? false : true;
  }
}

Future<void> deleteAll() async {
  final collection = await FirebaseFirestore.instance.collection("cash").get();

  final batch = FirebaseFirestore.instance.batch();

  for (final doc in collection.docs) {
    batch.delete(doc.reference);
  }

  return batch.commit();
}
