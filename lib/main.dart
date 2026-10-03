import 'package:flutter/material.dart';
void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tahap 16 - Debugging',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const KasusCPage(), 
    );
  }
}
class KasusCPage extends StatelessWidget {
  const KasusCPage({super.key});
  final String studentName = 'I Wayan Agus Wredhi Putra';
  final String studentId = '2415051007';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kasus C - Keyboard Overflow Fix'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            color: Colors.white,
            padding: const EdgeInsets.all(16.0),
            child: Text(
              '$studentName ($studentId)',
              style: const TextStyle(fontWeight: FontWeight.bold, 
              fontSize: 16, color: Color.fromARGB(255, 0, 0, 0)),
            ),
          ),
          const Divider(height: 1, thickness: 2), 
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: 450, 
                    color: Colors.blue.shade50,
                    alignment: Alignment.center,
                    child: const Text('Ruang Kosong Penanda Layout'),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Klik Di Sini!',
                      ),
                    ),
                  ),
                  const SizedBox(height: 150),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}