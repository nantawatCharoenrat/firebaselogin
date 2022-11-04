import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebaselogin/showdetailcat1.dart';

class Catpage1 extends StatelessWidget {
  final store = FirebaseFirestore.instance;
  Catpage1({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: store.collection('cat1').snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("แมววิเชียรมาศ"),
            actions: <Widget>[buildAddButton(context)],
          ),
          body: snapshot.hasData
              ? buildCatList(snapshot.data!)
              : const Center(
                  child: CircularProgressIndicator(),
                ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.pushNamed(context, '/cash');
            },
            child: const Icon(Icons.add_shopping_cart),
          ),
        );
      },
    );
  }

  IconButton buildAddButton(context) {
    return IconButton(
        icon: const Icon(Icons.add),
        onPressed: () {
          print("add icon press");
          Navigator.pushNamed(context, '/addcat1');
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
              child: const Text('เพิ่มน้องแมวลงรถเข็น'),
              onPressed: () async {
                if (true) {
                  print('save button press');
                  Map<String, dynamic> data = {
                    'title': model['title'],
                    'detail': model['detail'],
                    'price': model['price'],
                  };
                  try {
                    DocumentReference ref =
                        await store.collection('cash').add(data);
                    print('save id = ${ref.id}');
                    // Navigator.pop(context);
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Error $e'),
                      ),
                    );
                  }
                }
              }),
          onTap: () {
            print(model['title']);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CatDetail1(model['title'])));
          },
        );
      },
    );
  }
}
