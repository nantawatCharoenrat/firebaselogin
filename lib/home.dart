import 'package:flutter/material.dart';

class Cat_view extends StatelessWidget {
  const Cat_view({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Drawer(
          child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            buildMenuItems(context),
          ],
        ),
      ));

  Widget buildMenuItems(BuildContext context) => Container(
      padding: const EdgeInsets.all(12),
      child: Wrap(
        runSpacing: 32,
        children: [
          const Divider(
            color: Colors.amber,
          ),
          ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://image.bangkokbiznews.com/image/kt/media/image/fileupload1/source/161838826160.jpg?1618388265692'),
            ),
            title: Text('แมววิเชียรมาศ'),
            subtitle: Text('แมววิเชียรมาศเป็นน้องแมวสายพันธุ์ไทยที่สวยมาก'),
            onTap: () {
              Navigator.pushNamed(context, '/catpage1');
            },
          ),
          ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://image.bangkokbiznews.com/image/kt/media/image/fileupload1/source/161838865746.jpg?1618388659114'),
            ),
            title: Text('แมวสีสวาด'),
            subtitle: Text(
                'แมวสีสวาดแมวสายพันธุ์ไทยอีกสายพันธุ์ที่มีสีที่เป็นเอกลักษณ์'),
            onTap: () {
              Navigator.pushNamed(context, '/catpage2');
            },
          ),
          ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://image.bangkokbiznews.com/image/kt/media/image/fileupload1/source/161838876966.jpg?1618388772799'),
            ),
            title: Text('แมวศุภลักษณ์'),
            subtitle:
                Text('แมวศุภลักษณ์วสายพันธุ์ไทยที่มีความสง่างามสูงมาในองค์รวม'),
            onTap: () {
              Navigator.pushNamed(context, '/catpage3');
            },
          ),
          const Divider(
            color: Colors.amber,
          ),
        ],
      ));
}
