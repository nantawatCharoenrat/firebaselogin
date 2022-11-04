// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebaselogin/updatecat2.dart';
import 'package:flutter/material.dart';

class CatDetail2 extends StatefulWidget {
  final String _idi; //if you have multiple values add here
  CatDetail2(this._idi, {Key? key})
      : super(key: key); //add also..example this.abc,this...

  @override
  _CatDetail2State createState() => _CatDetail2State();
}

class _CatDetail2State extends State<CatDetail2> {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    String _id = widget._idi;
    return StreamBuilder(
        stream: getcat(_id),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("Detail แมวสีสวาด"),
            ),
            body: snapshot.hasData
                ? buildCatList(snapshot.data!)
                : const Center(
                    child: CircularProgressIndicator(),
                  ),
          );
        });
  }

  ListView buildCatList(QuerySnapshot data) {
    return ListView.builder(
      itemCount: data.docs.length,
      itemBuilder: (BuildContext context, int index) {
        var model = data.docs.elementAt(index);
        String a = model['detail'] +
            '               ' +
            model['price'].toString() +
            " Bath";
        return ListTile(
            title: Text(model['title']),
            subtitle: Text(a),
            trailing: Wrap(
              spacing: 12,
              children: <Widget>[
                ElevatedButton(
                    child: const Text('Edit'),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EditCatPage2(model.id)));
                    }),
                ElevatedButton(
                    child: const Text('Delete'),
                    onPressed: () {
                      print(model.id);
                      deleteValue(model.id);
                      Navigator.pop(context);
                    }),
              ],
            ));
      },
    );
  }

  Future<void> deleteValue(String titleName) async {
    await _firestore.collection('cat2').doc(titleName).delete().catchError((e) {
      print(e);
    });
  }

  Stream<QuerySnapshot> getcat(String titleName) {
    // Firestore _firestore = Firestore.instance;
    return _firestore
        .collection('cat2')
        .where('title', isEqualTo: titleName)
        .snapshots();
  }
}
