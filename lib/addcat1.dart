// ignore_for_file: avoid_print, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddCatPage1 extends StatefulWidget {
  const AddCatPage1({Key? key}) : super(key: key);

  @override
  _AddCatPage1State createState() => _AddCatPage1State();
}

class _AddCatPage1State extends State<AddCatPage1> {
  final _form = GlobalKey<FormState>();
  final _title = TextEditingController();
  final _detail = TextEditingController();
  final _price = TextEditingController();
  final store = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add cat แมววิเชียรมาศ'),
      ),
      body: Form(
        key: _form,
        child: ListView(
          children: <Widget>[
            buildTitleField(),
            buildDetailField(),
            buildPriceField(),
            buildSaveButton()
          ],
        ),
      ),
    );
  }

  ElevatedButton buildSaveButton() {
    return ElevatedButton(
        child: const Text('Save'),
        onPressed: () async {
          if (_form.currentState!.validate()) {
            print('save button press');
            Map<String, dynamic> data = {
              'title': _title.text,
              'detail': _detail.text,
              'price': double.parse(_price.text),
            };
            try {
              DocumentReference ref = await store.collection('cat1').add(data);
              print('save id = ${ref.id}');
              Navigator.pop(context);
            } catch (e) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Error $e'),
                ),
              );
            }
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Please validate value'),
              ),
            );
          }
        });
  }

  TextFormField buildTitleField() {
    return TextFormField(
      controller: _title,
      decoration: const InputDecoration(
        labelText: 'title',
        icon: Icon(Icons.book),
      ),
      validator: (value) => value!.isEmpty ? 'Please fill in title' : null,
    );
  }

  TextFormField buildDetailField() {
    return TextFormField(
      controller: _detail,
      decoration: const InputDecoration(
        labelText: 'detail',
        icon: Icon(Icons.list),
      ),
      validator: (value) => value!.isEmpty ? 'Please fill in detail' : null,
    );
  }

  TextFormField buildPriceField() {
    return TextFormField(
        controller: _price,
        keyboardType: TextInputType.number,
        decoration: const InputDecoration(
          labelText: 'price',
          icon: Icon(Icons.list),
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return 'Please fill in price';
          } else {
            double price = double.parse(value);
            if (price < 0) {
              return 'Please fill in price';
            } else {
              return null;
            }
          }
        });
  }
}
