import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Cash extends StatelessWidget {
  final store = FirebaseFirestore.instance;
  Cash({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: store.collection('cash').snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.home),
              onPressed: () {
                Navigator.popAndPushNamed(context, '/mainframe');
              },
            ),
            title: Text("รายการสั่งซื้อน้องแมว"),
          ),
          body: snapshot.hasData
              ? buildCatList(snapshot.data!)
              : const Center(
                  child: CircularProgressIndicator(),
                ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.pushNamed(context, '/confirm');
            },
            child: const Icon(Icons.credit_card),
          ),
        );
      },
    );
  }

  Future<void> deleteValue(String titleName) async {
    await store.collection('cash').doc(titleName).delete().catchError((e) {
      print(e);
    });
  }

  ListView buildCatList(QuerySnapshot data) {
    return ListView.builder(
      itemCount: data.size,
      itemBuilder: (BuildContext context, int index) {
        var model = data.docs.elementAt(index);
        return ListTile(
          title: Text(model['title']),
          subtitle: Text("${model['price']}" + " Bath"),
          trailing: ElevatedButton(
              child: const Text('Delete'),
              onPressed: () {
                print(model.id);
                deleteValue(model.id);
                //Navigator.pop(context);
              }),
        );
      },
    );
  }
}
