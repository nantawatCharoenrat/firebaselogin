import 'package:firebaselogin/drawers.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

class Confirm extends StatelessWidget {
  final store = FirebaseFirestore.instance;
  Confirm({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: store.collection('cash').snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        return Scaffold(
          appBar: AppBar(
            title: Text("ยืนยันการจ่ายเงิน"),
          ),
          body: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                    child: Text('Confirm'),
                    onPressed: () {
                      sendNotification();
                      deleteAll();
                      Navigator.popAndPushNamed(context, '/mainframe');
                    }),
                ElevatedButton(
                  child: Text('Cencel'),
                  onPressed: () {
                    Navigator.maybePop(context);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> sendNotification() async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails('noti01', 'แจ้งเตือนการชำระเงิน',
            importance: Importance.max,
            priority: Priority.high,
            ticker: 'ticker');

    const NotificationDetails platformChannelDetails = NotificationDetails(
      android: androidNotificationDetails,
    );

    await flutterLocalNotificationsPlugin.show(
        0,
        'แจ้งเตือนการชำระเงิน',
        'คุณ ' + auth.currentUser!.email! + ' ได้ชำระเงินสำเร็จแล้ว',
        platformChannelDetails);
  }

  Future<void> deleteAll() async {
    final collection =
        await FirebaseFirestore.instance.collection("cash").get();

    final batch = FirebaseFirestore.instance.batch();

    for (final doc in collection.docs) {
      batch.delete(doc.reference);
    }

    return batch.commit();
  }
}
