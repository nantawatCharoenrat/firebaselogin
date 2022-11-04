import 'package:firebaselogin/login.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formstate = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Form(
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
                child: Text('Register',
                    style: TextStyle(
                        fontSize: 29.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold)),
              ),
            ),
          ]),
          SizedBox(
            height: 40,
          ),
          buildEmailField(),
          buildPasswordField(),
          SizedBox(
            height: 50,
          ),
          buildRegisterButton(),
        ],
      ),
    ));
  }

  ElevatedButton buildRegisterButton() {
    return ElevatedButton(
      child: const Text('Register'),
      style: ElevatedButton.styleFrom(
          textStyle: const TextStyle(
              color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))),
      onPressed: () async {
        print('Regis new Account');
        if (_formstate.currentState!.validate()) print(email.text);
        print(password.text);
        final _user = await auth.createUserWithEmailAndPassword(
            email: email.text.trim(), password: password.text.trim());
        _user.user!.sendEmailVerification();
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const LoginPage()),
            ModalRoute.withName('/'));
      },
    );
  }

  TextFormField buildPasswordField() {
    return TextFormField(
      controller: password,
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
        icon: Icon(Icons.lock),
      ),
    );
  }

  TextFormField buildEmailField() {
    return TextFormField(
      controller: email,
      validator: (value) {
        if (value!.isEmpty)
          return 'Please fill in E-mail field';
        else
          return null;
      },
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      decoration: const InputDecoration(
        labelText: 'E-mail',
        labelStyle: TextStyle(
            color: Colors.black, fontSize: 28, fontWeight: FontWeight.bold),
        icon: Icon(Icons.email),
        hintText: 'x@x.com',
      ),
    );
  }
}
