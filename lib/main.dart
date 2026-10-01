import 'package:flutter/material.dart';

void main() => runApp(const MyApp());
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  static const String studentName = 'I Wayan Agus Wredhi Putra';
  static const String studentId = '2415051007';
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Tahap 6: Scrollable & Keyboard'),
          backgroundColor: const Color.fromARGB(255, 1, 154, 249),
          foregroundColor: Colors.white,
        ),
        body: const ScrollableFormPage(),
      ),
    );
  }
}
class ScrollableFormPage extends StatelessWidget {
  const ScrollableFormPage({super.key});
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: Colors.indigo.shade50,
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(color: Colors.indigo.shade200),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Identitas Mahasiswa:',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.indigo),
                ),
                SizedBox(height: 4),
                Text(
                  '${MyApp.studentId} - ${MyApp.studentName}',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Form Profil & Informasi',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 16),
          const TextField(
            decoration: InputDecoration(
              labelText: 'Nama Lengkap',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.person),
            ),
          ),
          const SizedBox(height: 12),
          const TextField(
            decoration: InputDecoration(
              labelText: 'NIM',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.badge),
            ),
          ),
          const SizedBox(height: 12),
          const TextField(
            decoration: InputDecoration(
              labelText: 'Email',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.email),
            ),
          ),
          const SizedBox(height: 12),
          const TextField(
            decoration: InputDecoration(
              labelText: 'Nomor Telepon',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.phone),
            ),
          ),
          const SizedBox(height: 12),
          const TextField(
            maxLines: 2,
            decoration: InputDecoration(
              labelText: 'Alamat',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.home),
            ),
          ),
          const SizedBox(height: 12),
          const TextField(
            maxLines: 2,
            decoration: InputDecoration(
              labelText: 'Catatan Tambahan',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.note),
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.indigo,
                foregroundColor: Colors.white,
              ),
              child: const Text('Simpan Data'),
            ),
          ),
        ],
      ),
    );
  }
}