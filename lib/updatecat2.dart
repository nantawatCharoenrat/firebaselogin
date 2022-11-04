// ignore_for_file: avoid_print, deprecated_member_use
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EditCatPage2 extends StatefulWidget {
  final String _idi;
  const EditCatPage2(this._idi, {Key? key}) : super(key: key);

  @override
  _EditCatPage2State createState() => _EditCatPage2State();
}

class _EditCatPage2State extends State<EditCatPage2> {
  final _form = GlobalKey<FormState>();
  final _title = TextEditingController();
  final _detail = TextEditingController();
  final _price = TextEditingController();
  final store = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    String _id = widget._idi;
    var snapshot = getcat(_id);
    //final store = FirebaseFirestore.instance.collection('cat1').doc(_id);

    return Scaffold(
      appBar: AppBar(
        title: const Text('edit แมวสีสวาด'),
      ),
      body: Form(
        key: _form,
        child: ListView(
          children: <Widget>[
            buildTitleField(),
            buildDetailField(),
            buildPriceField(),
            buildSaveButton(_id)
          ],
        ),
      ),
    );
  }

  ElevatedButton buildSaveButton(var id) {
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
              var collection = FirebaseFirestore.instance.collection('cat2');
              collection
                  .doc(id)
                  .update(data) // <-- Updated data
                  .then((_) => print('Success'))
                  .catchError((error) => print('Failed: $error'));
              deleteAll();
              Navigator.popUntil(context, ModalRoute.withName('/catpage2'));
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

  Stream<QuerySnapshot> getcat(String titleName) {
    // Firestore _firestore = Firestore.instance;
    return store
        .collection('cat2')
        .where('title', isEqualTo: titleName)
        .snapshots();
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
