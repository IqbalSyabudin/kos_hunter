import 'package:flutter/material.dart';

class NotificationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pemberitahuan'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          ListTile(
            leading: Icon(Icons.notifications, color: Colors.blue),
            title: Text('Update Aplikasi!'),
            subtitle: Text('Versi terbaru 1.2 telah dirilis.'),
            trailing: Text('1 hari lalu'),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.info_outline, color: Colors.orange),
            title: Text('Promo Khusus Member Baru'),
            subtitle: Text('Dapatkan diskon 25% kos pilihan.'),
            trailing: Text('3 hari lalu'),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.check_circle_outline, color: Colors.green),
            title: Text('Fitur Favorit Aktif!'),
            subtitle: Text('Kini kamu bisa menyimpan kos favoritmu.'),
            trailing: Text('5 hari lalu'),
          ),
        ],
      ),
    );
  }
}
